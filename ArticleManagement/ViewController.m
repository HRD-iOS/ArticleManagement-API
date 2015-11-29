//
//  ViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ViewController.h"
#import "ConnectionManager.h"
#import "ArticleManager.h"
#import "ArticleDetailsViewController.h"
#import "ArticleDetailsNoImageViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<ConnectionManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    manager.delegate = self;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:@"2" forKey:@"row"];
    [dictionary setObject:@"1" forKey:@"pageCount"];
    
    [manager sendTranData:dictionary withKey:@"/api/article/hrd_r001"];
    
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
   
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:75/255.0f green:157/255.0f blue:78/255.0f alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.customTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}


-(void)returnResult:(NSDictionary *)result{
    [ArticleManager sharedInstance].record = [result objectForKey:@"RES_DATA"];
    NSLog(@"+++++++++++++ %@",result);
    [self.customTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
}


-(void)refreshData{
    
    [self.customTableView reloadData];
}


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
    return [[ArticleManager sharedInstance].record  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *article = [[ArticleManager sharedInstance].record  objectAtIndex:indexPath.row];
    
    
    if([[article valueForKey:@"image"] isEqual: @""]){
        
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
        cell.labelTitleWithoutImage.text = [article valueForKey:@"title"];
        cell.labelContentWithoutImage.text = [article valueForKey:@"description"];
        [cell.labelContentWithoutImage sizeToFit];
        return cell;
    }
    else{
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithImage" forIndexPath:indexPath];
        
        cell.labelTitle.text = [article valueForKey:@"title"];
        cell.imageViewImage.image = [UIImage imageNamed:[article valueForKey:@"image"]];
        cell.labelContent.text = [article valueForKey:@"description"];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[[ArticleManager sharedInstance].record  objectAtIndex:indexPath.row] valueForKey:@"image"] isEqual:@""]){
        [self performSegueWithIdentifier:@"segueArticleDetailsNoImage" sender:[[ArticleManager sharedInstance].record objectAtIndex:indexPath.row]];
        
    }else{
        [self performSegueWithIdentifier:@"segueArticleDetails" sender:[[ArticleManager sharedInstance].record  objectAtIndex:indexPath.row]];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueArticleDetails"]) {
        ArticleDetailsViewController  *articleDetails = [segue destinationViewController];
        articleDetails.dictionaryArticle = sender;
    }else  if ([segue.identifier isEqualToString:@"segueArticleDetailsNoImage"]) {
        ArticleDetailsNoImageViewController  *articleDetailsNoImage = [segue destinationViewController];
        articleDetailsNoImage.dictionaryArticle = sender;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
