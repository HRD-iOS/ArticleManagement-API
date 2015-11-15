//
//  ArticleDetailsNoImageViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ArticleDetailsNoImageViewController.h"

@interface ArticleDetailsNoImageViewController ()

@end

@implementation ArticleDetailsNoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelTitle.text = [_article title];
    _textViewContent.text = [_article content];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
