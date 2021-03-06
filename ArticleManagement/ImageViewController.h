//
//  ImageViewController.h
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ImageViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) Article *article;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewImage;

@end
