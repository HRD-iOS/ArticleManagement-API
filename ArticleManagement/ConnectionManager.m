//
//  ConnectionManager.m
//  ArticleManagement
//
//  Created by Kokpheng on 11/29/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ConnectionManager.h"

@interface ConnectionManager()

@end

@implementation ConnectionManager{
    NSMutableData *responseData;
}

-(void)sendTranData:(NSDictionary *)reqDictionary withKey:(NSString *)key{
    NSString *baseURL = @"http://hrdams.herokuapp.com";
    NSString *strURL = [NSString stringWithFormat:@"%@%@", baseURL, key];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSData *jsonObject = [NSJSONSerialization dataWithJSONObject:reqDictionary options:0 error:nil];
    
    NSString *urlString = [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
    
    NSData *requestBodyData = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = requestBodyData;
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            if ([request.URL isEqual:url] ) {
                NSData *data = [NSData dataWithContentsOfURL:localfile];
                responseData = [NSMutableData data];
                [responseData appendData:data];
                NSDictionary *dicObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
                
                [self.delegate returnResult:dicObject];
           }
        }
    }];
    [task resume];
}

@end