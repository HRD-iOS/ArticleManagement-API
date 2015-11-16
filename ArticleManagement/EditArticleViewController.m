//
//  EditArticleViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/17/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "EditArticleViewController.h"

@interface EditArticleViewController ()

@end

@implementation EditArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textFieldTitle.text=[_article title];
    _textViewContent.text =[_article content];
    _imageViewImage.image = [UIImage imageNamed:[_article image]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveEditDetail:(id)sender {
    
    Article *article = [[Article alloc]initWithTitle:_textFieldTitle.text Content: _textViewContent.text ImagePath:@""];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[article] forKeys:@[@"article"]];
    [[ArticleManager sharedInstance].record replaceObjectAtIndex:[ArticleManager sharedInstance].recordID withObject:dic];
    
    [self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
}

- (IBAction)deleteArticleRecord:(id)sender {
    [[ArticleManager sharedInstance].record removeObjectAtIndex:[ArticleManager sharedInstance].recordID];
    [self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
}

- (IBAction)loadGallery:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageViewImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
