//
//  ArticleManager.h
//  ArticleManagement
//
//  Created by Kokpheng on 11/16/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleManager : NSObject
@property (strong, nonatomic) NSMutableArray *record;
@property NSInteger recordID;

+(ArticleManager *)sharedInstance;
@end
