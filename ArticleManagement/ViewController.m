//
//  ViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ViewController.h"
#import "Article.h"
#import "ArticleDetailsViewController.h"
#import "ArticleDetailsNoImageViewController.h"
#import "ConnectionManager.h"
#import "CustomTableViewCell.h"
#import "SWRevealViewController.h"

const int kLoadingCellTag = 1273;

@interface ViewController ()<ConnectionManagerDelegate>{
    UIActivityIndicatorView *indicatorFooter;
}
#define RIGHT_PANEL_TAG 3

//list for store article retrieve from server
@property (nonatomic,strong) NSMutableArray<Article *> *articleList;
@property int rows;
@property int currentPageNumber;
@property int totalPages;
@end

@implementation ViewController

#pragma mark:- custom property

- (void)setArticleList:(NSMutableArray *)articleList {
    _articleList = articleList;
    
    if ([_articleList count] > 0) {
        [self.customTableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    //set current page n rows
    _currentPageNumber =1;
    _rows = 5;
    
    //init article list
    self.articleList = [[NSMutableArray alloc]init];
    
    //create refresh control and set its properties
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:75/255.0f green:157/255.0f blue:78/255.0f alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.customTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    // call indicator at footer
    [self initializeRefreshControl];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    //remove all item from list
    [self.articleList removeAllObjects];
    
    [self fetchArticle];
    
    [self.customTableView reloadData];
    
    //Sidebar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        revealViewController.rightViewRevealOverdraw = 0.0f;
        [self.moreButton addTarget:self.revealViewController action:@selector(rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}



#pragma mark: - ConnectionManagerDelegate

-(void)returnResult:(NSDictionary *)result{
    NSLog(@"%@", result);
    _totalPages = ceil([[result valueForKey:@"TOTAL_REC"] floatValue] / _rows) ;
    
    // loop array in result
    for ( NSArray *subList in [result valueForKey:@"RES_DATA"]) {
        Article *article = [[Article alloc]initWithData:subList];
        [self.articleList addObject:article];
    }
    [self.customTableView reloadData];
}

-(void)refreshData{
    dispatch_async(dispatch_get_main_queue(), ^{
        //remove all item from list
        [self.articleList removeAllObjects];
        _currentPageNumber = 1;
        [self fetchArticle];
         [self.customTableView reloadData];
    });
    
}

#pragma mark:- fetching article from server
- (void)fetchArticle {
    //Create connection manager
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    manager.delegate = self;
    
    // request dictionary
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
    [dictionary setObject:[NSString stringWithFormat:@"%d", _rows] forKey:@"row"];
    [dictionary setObject:[NSString stringWithFormat:@"%d", _currentPageNumber] forKey:@"pageCount"];
    
    // send data to server
    [manager sendTranData:dictionary withKey:@"/api/article/hrd_r001"];
}



#pragma mark: - UITableViewDataSource

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //when last cell is visible then endRefreshing
    if([indexPath row] == ((NSIndexPath*)[[_customTableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
        [self.refreshControl endRefreshing];
        
        if (self.refreshControl) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
            
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                        forKey:NSForegroundColorAttributeName];
            NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
            self.refreshControl.attributedTitle = attributedTitle;
            
            [self.refreshControl endRefreshing];
        }
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.articleList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // validate if the article has image or not
    if([[[self.articleList objectAtIndex:indexPath.row] imageUrlString] isEqual: @"resources/image/article-image/default.jpg"]){
        // No image
        
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
        cell.labelTitleWithoutImage.text = [[self.articleList objectAtIndex:indexPath.row] title];
        cell.labelContentWithoutImage.text = [[self.articleList objectAtIndex:indexPath.row] descriptions];
        [cell.labelContentWithoutImage sizeToFit];
        return cell;
    }
    else{
        
        // Has image
        
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithImage" forIndexPath:indexPath];
        cell.labelTitle.text = [[self.articleList objectAtIndex:indexPath.row] title];
        cell.labelContent.text = [[self.articleList objectAtIndex:indexPath.row] descriptions];
        
        // check if image isn't finishing loading then set default image.
        if ([[self.articleList objectAtIndex:indexPath.row] image]) {
            cell.imageViewImage.image = [self.articleList[indexPath.row] image];
        }else{
            cell.imageViewImage.image = [UIImage imageNamed:@"no-images.png"];
            [self startDownloadingImage:[self.articleList objectAtIndex:indexPath.row] forIndexPath:indexPath];
            
        }
        return cell;
    }
}


// downloading image with GCD
- (void)startDownloadingImage:(Article *)article forIndexPath:(NSIndexPath *)indexPath {
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(concurrentQueue, ^{
        __block NSData *dataImage = nil;
        
        dispatch_sync(concurrentQueue, ^{
            NSURL *urlImage = [NSURL URLWithString:[article imageUrlString]];
            dataImage = [NSData dataWithContentsOfURL:urlImage];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CustomTableViewCell *cell = [self.customTableView  cellForRowAtIndexPath:indexPath];
            UIImage *image = [UIImage imageWithData:dataImage];
            self.articleList[indexPath.row].image = image;
            cell.imageViewImage.image = image;
        });
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Validate object send to Detail screen, whether it has image or not.
    if([[[self.articleList objectAtIndex:indexPath.row] imageUrlString] isEqual: @"resources/image/article-image/default.jpg"]){
        [self performSegueWithIdentifier:@"segueArticleDetailsNoImage" sender:[self.articleList objectAtIndex:indexPath.row]];
    }else{
        [self performSegueWithIdentifier:@"segueArticleDetails" sender:[self.articleList objectAtIndex:indexPath.row]];
        
    }
}

// set cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"segueArticleDetails"]) {
        ArticleDetailsViewController  *articleDetails = [segue destinationViewController];
        articleDetails.article = sender;
    }else  if ([segue.identifier isEqualToString:@"segueArticleDetailsNoImage"]) {
        ArticleDetailsNoImageViewController  *articleDetailsNoImage = [segue destinationViewController];
        articleDetailsNoImage.article = sender;
    }
    
}

#pragma mark loading indicator at footer
-(void)initializeRefreshControl
{
    indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.customTableView.frame), 44)];
    [indicatorFooter setColor:[UIColor blackColor]];
    [indicatorFooter startAnimating];
    [self.customTableView setTableFooterView:indicatorFooter];
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height)
    {
        [self refreshTableVeiwList];
    }
}

-(void)refreshTableVeiwList
{
    //Code here
    
    if(_currentPageNumber >= _totalPages){
        [indicatorFooter stopAnimating];
    }else{
        _currentPageNumber++;
        [self fetchArticle];
    }
    
    [self.customTableView setContentOffset:(CGPointMake(0,self.customTableView.contentOffset.y-indicatorFooter.frame.size.height)) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
