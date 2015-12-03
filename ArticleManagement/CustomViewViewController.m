//
//  CustomViewViewController.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "CustomViewViewController.h"
#import "SWRevealViewController.h"

@interface CustomViewViewController ()

@end

@implementation CustomViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    
    
    [_imageViewLogo.layer setBorderColor: [[UIColor colorWithRed:76/255.0 green:149/255.0 blue:77/255.0 alpha:1] CGColor]];
    
    [_imageViewLogo.layer setBorderWidth: 2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(tableView == _tableView1){
        return @"Table View 1";
    }else{
       return @"Table View 2";
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //validate tableview 1 or 2
    if(tableView == _tableView1){
        UITableViewCell *cell = [_tableView1 dequeueReusableCellWithIdentifier:@"tableView1Cell"] ;
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Detail %ld", (long)indexPath.row];
        return  cell;
    }else{
        UITableViewCell *cell = [_tableView2 dequeueReusableCellWithIdentifier:@"tableView2Cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];;
        return  cell;
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    //Sidebar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        revealViewController.rightViewRevealOverdraw = 0.0f;
        [self.backButton setTarget:self.revealViewController];
        [self.backButton setAction:@selector(rightRevealToggle: )];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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
