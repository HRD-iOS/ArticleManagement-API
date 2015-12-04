//
//  UserDetailsViewController.h
//  ArticleManagement
//
//  Created by Yin Kokpheng on 12/4/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UITableView *userDetailTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end
