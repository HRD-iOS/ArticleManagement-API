//
//  ArticleDetailsNoImageViewController.h
//  ArticleManagement
//
//  Created by Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailsNoImageViewController : UIViewController

@property (strong, nonatomic) NSDictionary *dictionaryArticle;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

@end
