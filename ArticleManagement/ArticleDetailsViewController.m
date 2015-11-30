//
//  ArticleDetailsViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import "ImageViewController.h"
#import "EditArticleViewController.h"

@interface ArticleDetailsViewController ()

@end

@implementation ArticleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set article's content from sender to view element
    self.labelTitle.text = [self.article title];
    self.imageViewImage.image = [self.article image];
    self.textViewContent.text =[self.article descriptions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissArticleDetailsView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Share button
- (IBAction)shareArticleDetails:(id)sender {
    NSArray *data = [[NSArray alloc]initWithObjects:@"hello",nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:data applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)showImage:(id)sender {
    [self performSegueWithIdentifier:@"segueImage" sender:self.article];
}

- (IBAction)editDetail:(id)sender {
    [self performSegueWithIdentifier:@"segueEditDetail" sender:self.article];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segueImage"]){
        ImageViewController *imageViewController = [segue destinationViewController];
        imageViewController.article = sender;
    }else if([segue.identifier isEqualToString:@"segueEditDetail"]){
        EditArticleViewController *editArticle = [segue destinationViewController];
        editArticle.article = sender;
    }
}


@end
