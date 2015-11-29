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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
      [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *jsonObject = [NSJSONSerialization dataWithJSONObject:reqDictionary options:0 error:nil];
    
    NSString *urlString = [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
    
    NSData *requestBodyData = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = requestBodyData;
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!connection){
        responseData = nil;
    }
    [connection start];
}

#pragma mark - Connection Deleage

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
    NSError *error;
    NSDictionary *dicObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
    [self.delegate returnResult:dicObject];
}
    
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [NSMutableData data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
@end

