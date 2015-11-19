//
//  ImageViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    _imageViewImage.image = [UIImage imageNamed:[_article image]];
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 6.0;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageViewImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissImageViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveImageToGallery:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Save Image"
                                          message:@"Do you want to save this image?"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UIImage *image = [UIImage imageNamed:[_article image]];
                                   UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
