//
//  CustomTableViewCell.h
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelPostDate;
@property (weak, nonatomic) IBOutlet UILabel *labelPostDateWithoutImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewImage;
@property (weak, nonatomic) IBOutlet UILabel *labelTitleWithoutImage;
@property (weak, nonatomic) IBOutlet UILabel *labelContentWithoutImage;
@end
