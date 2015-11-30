//
//  ArticleDetailsNoImageViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ArticleDetailsNoImageViewController.h"
#import "EditArticleViewController.h"

@interface ArticleDetailsNoImageViewController ()

@end

@implementation ArticleDetailsNoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // set article's content from sender to view element
    _labelTitle.text = [self.article title];
    _textViewContent.text = [self.article descriptions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissArticleDetailsNoImageView:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)shareArticleDetail:(id)sender {
    NSArray *data = [[NSArray alloc]initWithObjects:@"hello",nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:data applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)editDetail:(id)sender {
    [self performSegueWithIdentifier:@"segueEditDetailWithoutImage" sender:self.article];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segueEditDetailWithoutImage"]){
        EditArticleViewController *editArticle = [segue destinationViewController];
        editArticle.article = sender;
    }
}

@end
