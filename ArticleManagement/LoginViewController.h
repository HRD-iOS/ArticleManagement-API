//
//  LoginViewController.h
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/30/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonForgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUp;

@end
