//
//  EditUserDetailsViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 12/4/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "EditUserDetailsViewController.h"
#import "ConnectionManager.h"

@interface EditUserDetailsViewController ()<ConnectionManagerDelegate>{
    NSUserDefaults *userDefault;
    NSMutableDictionary *user;
}

@end

@implementation EditUserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    userDefault = [NSUserDefaults standardUserDefaults];
    user = [[NSMutableDictionary alloc]initWithDictionary:[userDefault valueForKey:@"user"]];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://hrdams.herokuapp.com/%@",[user valueForKey:@"photo"]];
    
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(concurrentQueue, ^{
        __block NSData *dataImage = nil;
        
        dispatch_sync(concurrentQueue, ^{
            NSURL *urlImage = [NSURL URLWithString:imageURL];
            dataImage = [NSData dataWithContentsOfURL:urlImage];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:dataImage];
            self.profileImageView.image = image;
            
        });
    });
    
    self.usernameTextField.text = [user valueForKey:@"username"];
    
    self.passwordTextField.text = [user valueForKey:@"password"];
    
    
}
- (IBAction)saveEditAction:(id)sender {
    
    [user setValue:self.usernameTextField.text forKey:@"username"];
    [user setValue:self.passwordTextField.text forKey:@"password"];
    
    [userDefault setObject:user forKey:@"user"];
    
    
    //Create connection object
    ConnectionManager *manager = [[ConnectionManager alloc] init];
    
    //Set delegate
    manager.delegate = self;
    
    
    //Send data to server and insert it
    [manager sendTranData:[userDefault valueForKey:@"user"] withKey:@"/api/user/hrd_u001"];
    
    //[self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
    
}
- (IBAction)deleteUserAction:(id)sender {

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
                                                                             @"id": [user valueForKey:@"id"]
                                                                             };
                                          
                                          //Send data to server and insert it
                                          [manager sendTranData:dictionaryObject withKey:@"/api/user/hrd_d001"];
                                           [userDefault removeObjectForKey:@"user"];
//                                          [self performSegueWithIdentifier:@"segueSaveEditDetail" sender:nil];
                                      }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:resetAction];
        
      [self presentViewController:alertController animated:YES completion:nil];
    }

-(void)returnResult:(NSDictionary *)result{
    NSLog(@"+++++++++++++ %@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
