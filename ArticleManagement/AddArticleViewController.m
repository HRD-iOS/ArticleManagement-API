//
//  AddArticleViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/16/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "AddArticleViewController.h"
#import "ConnectionManager.h"


@interface AddArticleViewController ()<ConnectionManagerDelegate>

@end

@implementation AddArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveRecord:(id)sender {
    
    //Create connection object
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    //Set delegate
    manager.delegate = self;
    
    //Create dictionary for store article detail input from user
    NSDictionary *dictionaryObject = @{
                                 @"title": _textFieldTitle.text,
                                 @"description": _textViewContent.text,
                                 @"userId": @"43",
                                 @"image": (self.imageView.image == nil)? @"http://www.kshrd.com.kh/jsp/img/logo.png": @"http://www.kshrd.com.kh/jsp/img/logo.png"
                                 };
    
    //Send data to server and insert it
    [manager sendTranData:dictionaryObject withKey:@"/api/article/hrd_c001"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)returnResult:(NSDictionary *)result{
    NSLog(@"+++++++++++++ %@",result);
}


- (IBAction)dismissAddImageView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    self.imageView.image = chosenImage;
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
//    NSLog(@"%@", savedImagePath);
//    UIImage *image = chosenImage; // imageView is my image from camera
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [imageData writeToFile:savedImagePath atomically:YES];
   
    
    
    
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
