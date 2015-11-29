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
        self.articleID = [array valueForKeyPath:@"id"];
        self.title = [array valueForKeyPath:@"title"];
        self.descriptions = [array valueForKeyPath:@"description"];
        self.publishDate = [array valueForKeyPath:@"publishDate"];
        self.imageUrlString = [array valueForKeyPath:@"image"];
        self.enabled = [array valueForKeyPath:@"enabled"];
        self.userID = [array valueForKeyPath:@"userId"];
    }
    return self;
}

@end