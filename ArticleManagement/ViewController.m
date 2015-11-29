//
//  ViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ViewController.h"
#import "Article.h"
#import "ArticleManager.h"
#import "ArticleDetailsViewController.h"
#import "ArticleDetailsNoImageViewController.h"
#import "ConnectionManager.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<ConnectionManagerDelegate>
@property (nonatomic,strong) NSMutableArray<Article *> *articleList;

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
    
    self.articleList = [[NSMutableArray alloc]init];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:75/255.0f green:157/255.0f blue:78/255.0f alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.customTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

-(void)viewDidAppear:(BOOL)animated{
        [self.articleList removeAllObjects];
        ConnectionManager *manager = [[ConnectionManager alloc] init];
        
        manager.delegate = self;
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:@"10" forKey:@"row"];
        [dictionary setObject:@"1" forKey:@"pageCount"];
        
        [manager sendTranData:dictionary withKey:@"/api/article/hrd_r001"];
        
        [self.customTableView reloadData];

}

#pragma mark: - ConnectionManagerDelegate

-(void)returnResult:(NSDictionary *)result{
    
    for ( NSArray *subList in [result valueForKeyPath:@"RES_DATA"]) {
        Article *article = [[Article alloc]initWithData:subList];
        [self.articleList addObject:article];
    }
    [self.customTableView reloadData];
}

-(void)refreshData{
     [self.articleList removeAllObjects];
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    manager.delegate = self;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:@"10" forKey:@"row"];
    [dictionary setObject:@"1" forKey:@"pageCount"];
    
    [manager sendTranData:dictionary withKey:@"/api/article/hrd_r001"];
    
    [self.customTableView reloadData];
}

#pragma mark: - UITableViewDataSource

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

    if([[[self.articleList objectAtIndex:indexPath.row] imageUrlString] isEqual: @"resources/image/article-image/default.jpg"]){
     
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
        cell.labelTitleWithoutImage.text = [[self.articleList objectAtIndex:indexPath.row] title];
        cell.labelContentWithoutImage.text = [[self.articleList objectAtIndex:indexPath.row] descriptions];
        [cell.labelContentWithoutImage sizeToFit];
        return cell;
    }
    else{
        
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithImage" forIndexPath:indexPath];
        cell.labelTitle.text = [[self.articleList objectAtIndex:indexPath.row] title];
        cell.labelContent.text = [[self.articleList objectAtIndex:indexPath.row] descriptions];
        if ([[self.articleList objectAtIndex:indexPath.row] image]) {
            cell.imageViewImage.image = [self.articleList[indexPath.row] image];
        }else{
            cell.imageViewImage.image = [UIImage imageNamed:@"no-images.png"];
            [self startDownloadingImage:[self.articleList objectAtIndex:indexPath.row] forIndexPath:indexPath];
            
        }
        return cell;
    }
}


- (void)startDownloadingImage:(Article *)article forIndexPath:(NSIndexPath *)indexPath {
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(concurrentQueue, ^{
        __block NSData *dataImage = nil;
        
        dispatch_sync(concurrentQueue, ^{
            NSURL *urlImage = [NSURL URLWithString:[article imageUrlString]];
            dataImage = [NSData dataWithContentsOfURL:urlImage];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CustomTableViewCell *cell = [self.customTableView cellForRowAtIndexPath:indexPath];
            UIImage *image = [UIImage imageWithData:dataImage];
            self.articleList[indexPath.row].image = image;
            cell.imageViewImage.image = image;
        });
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[self.articleList objectAtIndex:indexPath.row] imageUrlString] isEqual: @"resources/image/article-image/default.jpg"]){
        [self performSegueWithIdentifier:@"segueArticleDetailsNoImage" sender:[self.articleList objectAtIndex:indexPath.row]];
        
    }else{
        [self performSegueWithIdentifier:@"segueArticleDetails" sender:[self.articleList objectAtIndex:indexPath.row]];
        
    }
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
