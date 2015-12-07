//
//  SignUpUserViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 12/7/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "SignUpUserViewController.h"
#import "ConnectionManager.h"

@interface SignUpUserViewController ()<ConnectionManagerDelegate>

@end

@implementation SignUpUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImageView.image = [UIImage imageNamed:@"default.png"];
    
    // border radius
    [self.profileImageView.layer setCornerRadius:self.profileImageView.bounds.size.height/2];
    self.profileImageView.backgroundColor = [UIColor colorWithRed:(56/255.0) green:(128/255.0) blue:(64/255.0) alpha:1.00];
    self.profileImageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelAction:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveAction:(id)sender {
  
    //Create connection object
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    //Set delegate
    manager.delegate = self;
    //Create dictionary for store article detail input from user
    NSDictionary *dictionaryObject = @{
                                           @"username": self.usernameTextField.text,
                                           @"password": self.passwordTextField.text,
                                           @"roles": @"User",
                                           @"photo": @""
                                       
                                       };

    
    //Send data to server and insert it
    [manager sendTranData:dictionaryObject withKey:@"/api/user/hrd_c001"];

}

-(void)returnResult:(NSDictionary *)result{
    NSLog(@"+++++++++++++ %@",result);
    if([[result valueForKey:@"MESSAGE"] isEqualToString:@"USER HAS BEEN INSERTED"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"SignUp Failed"
                                              message:@"This username is already created!!!"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleCancel
                                       handler:nil];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
