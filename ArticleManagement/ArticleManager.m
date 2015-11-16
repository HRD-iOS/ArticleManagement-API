//
//  ArticleManager.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/16/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ArticleManager.h"

@implementation ArticleManager
static ArticleManager *sharedInstance = nil;

+ (ArticleManager *)sharedInstance
{
    if(sharedInstance ==nil){
        sharedInstance = [[ArticleManager alloc] init];
        sharedInstance.record = [[NSMutableArray alloc]init];
    }
    return sharedInstance;
}
@end
