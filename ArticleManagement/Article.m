//
//  Article.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/29/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "Article.h"

@implementation Article

-(id)initWithData:(NSArray *)array{
    self = [super init];
    
    if (self != nil) {
        self.articleID = [array valueForKey:@"id"];
        self.title = [array valueForKey:@"title"];
        self.descriptions = [array valueForKey:@"description"];
        self.publishDate = [array valueForKey:@"publishDate"];
        self.imageUrlString = [array valueForKey:@"image"];
        self.enabled = [array valueForKey:@"enabled"];
        self.userID = [array valueForKey:@"userId"];
    }
    return self;
}

@end