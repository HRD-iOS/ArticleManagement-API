//
//  Article.h
//  ArticleManagement
//
//  Created by Kokpheng on 11/29/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

-(id)initWithData:(NSArray *)data;

@property(nonatomic,strong) NSNumber *articleID;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *descriptions;
@property(nonatomic,strong) NSString *publishDate;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *imageUrlString;
@property bool enabled;
@property(nonatomic,strong) NSNumber *userID;

@end
