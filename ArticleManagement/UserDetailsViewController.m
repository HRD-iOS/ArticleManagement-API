//
//  UserDetailsViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 12/4/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "SWRevealViewController.h"

@interface UserDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>{
   NSUserDefaults *userDefault;
}

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDetailTableView.delegate =self;
    self.userDetailTableView.dataSource =self;
    // Do any additional setup after loading the view.
    userDefault = [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.userDetailTableView reloadData];
    NSString *imageURL = [NSString stringWithFormat:@"http://hrdams.herokuapp.com/%@",[[userDefault valueForKey:@"user"] valueForKey:@"photo"]];
    
    
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
    
    //Sidebar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        revealViewController.rightViewRevealOverdraw = 0.0f;
        [self.backButton setTarget:self.revealViewController];
        [self.backButton setAction:@selector(rightRevealToggle: )];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [_userDetailTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"Username:\t\t%@", [[userDefault valueForKey:@"user"] valueForKey:@"username"]];
            break;
        case 1:
             cell.textLabel.text = [NSString stringWithFormat:@"Register Date:  %@", [[userDefault valueForKey:@"user"] valueForKey:@"registerDate"]];
            break;
            
        default:
            break;
    }
    
    return cell;
    
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
