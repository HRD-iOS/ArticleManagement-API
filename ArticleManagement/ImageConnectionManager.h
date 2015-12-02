//
//  ImageConnectionManager.h
//  ArticleManagement
//
//  Created by Yin Kokpheng on 12/2/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  ImageConnectionManagerDelegate;
@interface ImageConnectionManager : NSObject
//Request Method
-(void)sendTranData;

@property (nonatomic, weak) id<ImageConnectionManagerDelegate>delegate;

@end

@protocol ImageConnectionManagerDelegate <NSObject>
@optional
//Get Result Method
-(void)returnResult:(NSDictionary *) result;
@end
