//
//  Article.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "Article.h"

@implementation Article

-(id)initWithTitle:(NSString *)title Content:(NSString *)content ImagePath:(NSString *)image{
    if(self != [super init])
        return nil;
    
    _title = title;
    _content = content;
    _image = image;
    
    return self;
}

@end
