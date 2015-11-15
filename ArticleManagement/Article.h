//
//  Article.h
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *content;
@property (weak, nonatomic) NSString *image;

-(id)initWithTitle:(NSString *)title Content:(NSString *)content ImagePath:(NSString *)image;

@end
