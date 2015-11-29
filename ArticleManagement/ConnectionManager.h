//
//  ConnectionManager.h
//  ArticleManagement
//
//  Created by Kokpheng on 11/29/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  ConnectionManagerDelegate;

@interface ConnectionManager : NSObject
-(void)sendTranData:(NSDictionary *)reqDictionary withKey:(NSString *)key;

@property (nonatomic, weak) id<ConnectionManagerDelegate>delegate;

@end

@protocol ConnectionManagerDelegate <NSObject>
@optional
-(void)returnResult:(NSDictionary *) result;

@end
