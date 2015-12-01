//
//  LoginViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/30/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "LoginViewController.h"
#import "ConnectionManager.h"

@interface LoginViewController ()<ConnectionManagerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // border radius
    [self.textFieldUsername.layer setCornerRadius:25.0f];
    
    [self.textFieldPassword.layer setCornerRadius:25.0f];
    
    [self.buttonLogin.layer setCornerRadius:25.0f];
    self.buttonLogin.clipsToBounds = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.buttonLogin.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(96/255.0) green:(214/255.0) blue:(140/255.0) alpha:1.00] CGColor], (id)[[UIColor colorWithRed:(74/225.0) green:(187/255.0) blue:(234/255.0) alpha:1.00] CGColor], nil];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
   [[self.buttonLogin layer] insertSublayer:gradient atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    //Create connection manager
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    manager.delegate = self;
    
    // request dictionary
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:self.textFieldUsername.text forKey:@"username"];
    [dictionary setObject:self.textFieldPassword.text forKey:@"password"];
    
    // send data to server
    [manager sendTranData:dictionary withKey:@"/api/login"];
    
}

#pragma mark: - ConnectionManagerDelegate

-(void)returnResult:(NSDictionary *)result{
    NSLog(@"%@", result);
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
