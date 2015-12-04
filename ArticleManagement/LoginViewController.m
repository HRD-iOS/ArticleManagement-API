//
//  LoginViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/30/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "LoginViewController.h"
#import "ConnectionManager.h"
#import "ImageConnectionManager.h"

@interface LoginViewController ()<ConnectionManagerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set color for button login
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = self.viewTopbanner.bounds;
   gradient1.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(96/255.0) green:(214/255.0) blue:(140/255.0) alpha:1.00] CGColor], (id)[[UIColor colorWithRed:(74/225.0) green:(187/255.0) blue:(234/255.0) alpha:1.00] CGColor], nil];
    
    gradient1.startPoint = CGPointMake(0, 1);
    gradient1.endPoint = CGPointMake(0, 0);
    [self.viewTopbanner.layer insertSublayer:gradient1 atIndex:0];
    

    
    // border radius
    self.textFieldUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.textFieldUsername.frame.size.height - 1, self.textFieldUsername.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.textFieldUsername.layer addSublayer:bottomBorder];
    
    
    self.textFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.textFieldPassword.frame.size.height - 1, self.textFieldPassword.frame.size.width, 1.0f);
    bottomBorder1.backgroundColor = [UIColor whiteColor].CGColor;
    [self.textFieldPassword.layer addSublayer:bottomBorder1];
    
    [self.buttonLogin.layer setCornerRadius:self.buttonLogin.bounds.size.height/2];
    self.buttonLogin.clipsToBounds = YES;
    
    //Set color for button login
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.buttonLogin.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(96/255.0) green:(214/255.0) blue:(140/255.0) alpha:1.00] CGColor], (id)[[UIColor colorWithRed:(74/225.0) green:(187/255.0) blue:(234/255.0) alpha:1.00] CGColor], nil];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
   [[self.buttonLogin layer] insertSublayer:gradient atIndex:0];
    
    //set labelMessage property
    self.labelMessage.layer.masksToBounds = YES;
    self.labelMessage.layer.cornerRadius = self.labelMessage.bounds.size.height/2;
    self.labelMessage.hidden = true;
}

-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    if([userDefault valueForKey:@"user"]!=nil){
         [self performSegueWithIdentifier:@"loginSuccessSegue" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {


    [self.activityIndicatorLoading startAnimating];
    //Create connection manager
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    manager.delegate = self;
    
    // request dictionary
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:self.textFieldUsername.text forKey:@"username"];
    [dictionary setObject:self.textFieldPassword.text forKey:@"password"];
    
    // send data to server
    [manager sendTranData:dictionary withKey:@"/api/login"];
//        ImageConnectionManager *manager = [[ImageConnectionManager alloc] init];
//    
//        manager.delegate = self;
//    
//        // request dictionary
//    
//        // send data to server
//        [manager sendTranData];

}


#pragma mark: - ConnectionManagerDelegate

-(void)returnResult:(NSDictionary *)result{


    [self.activityIndicatorLoading stopAnimating];
    if([[result valueForKey:@"MESSAGE"] isEqualToString:@"LOGIN SUCCESS"]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[result valueForKey:@"RES_DATA"] forKey:@"user"];
        
        [self performSegueWithIdentifier:@"loginSuccessSegue" sender:nil];
    }
    else{
        self.labelMessage.hidden = false;
        [UIView animateWithDuration:1 animations:^(void){
            self.labelMessage.alpha = 0;
            self.labelMessage.alpha = 1;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0 animations:^(void){
                self.labelMessage.alpha = 1;
                self.labelMessage.alpha = 0;
                
            }];
        }];
    }
    
    
  //  NSLog(@"%@",result);
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
