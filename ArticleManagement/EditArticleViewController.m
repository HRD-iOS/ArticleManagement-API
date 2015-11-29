//
//  EditArticleViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/17/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "EditArticleViewController.h"
#import "ConnectionManager.h"

@interface EditArticleViewController ()<ConnectionManagerDelegate>

@end

@implementation EditArticleViewController
NSString *articleID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldTitle.text=[self.dictionaryArticle valueForKey:@"title"];
    _textViewContent.text =[self.dictionaryArticle valueForKey:@"description"];
    _imageViewImage.image = [UIImage imageNamed:[self.dictionaryArticle valueForKey:@"image"]];
    articleID = [self.dictionaryArticle valueForKey:@"id"];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveEditDetail:(id)sender {
    //Create connection object
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    //Set delegate
    manager.delegate = self;
    
    //Create dictionary for store article detail input from user
    NSDictionary *dictionaryObject = @{
                                       @"id": articleID,
                                       @"title": _textFieldTitle.text,
                                       @"description": _textViewContent.text,
                                       @"enable": @"true",
                                       @"userId": @"43",
                                       @"image": (self.imageViewImage.image == nil)? @"http://www.kshrd.com.kh/jsp/img/logo.png": @"http://www.kshrd.com.kh/jsp/img/logo.png"
                                       };
    
    //Send data to server and insert it
    [manager sendTranData:dictionaryObject withKey:@"/api/article/hrd_u001"];
    
    [self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
}

- (IBAction)deleteArticleRecord:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Delete Article"
                                          message:@"Do you want to delete this article?"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    UIAlertAction *resetAction = [UIAlertAction
                                  actionWithTitle:NSLocalizedString(@"Delete", @"Delete action")
                                  style:UIAlertActionStyleDestructive
                                  handler:^(UIAlertAction *action)
                                  {
                                      //Create connection object
                                      ConnectionManager *manager = [[ConnectionManager alloc] init];
                                      
                                      //Set delegate
                                      manager.delegate = self;
                                      
                                      //Create dictionary for store article detail input from user
                                      NSDictionary *dictionaryObject = @{
                                                                         @"id": articleID
                                                                         };
                                      
                                      //Send data to server and insert it
                                      [manager sendTranData:dictionaryObject withKey:@"/api/article/hrd_d001"];
                                      
                                      [self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
                                  }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:resetAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)returnResult:(NSDictionary *)result{
    NSLog(@"+++++++++++++ %@",result);
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
