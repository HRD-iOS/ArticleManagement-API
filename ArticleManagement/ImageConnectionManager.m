//
//  ImageConnectionManager.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 12/2/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ImageConnectionManager.h"
#import <UIKit/UIKit.h>
@interface ImageConnectionManager()
@end

@implementation ImageConnectionManager
//responseData object
NSMutableData *responseData;

-(void)sendTranData{
    NSString *urlString = @"http://hrdams.herokuapp.com/api/article/upload_image";

    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Convert your UIImage to NSDate
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"logo.jpg"],.3);
    
    if (imageData != nil)
    {
        NSString *filenames = [NSString stringWithFormat:@"SelfieName"];      //set name here
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"filenames\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[filenames dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //I use a method called randomStringWithLength: to create a unique name for the file, so when all the aapps are sending files to the server, none of them will have the same name:
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n",[self randomStringWithLength:10]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        //Create session
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
       
        //Create download task for download content
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                if ([request.URL isEqual:url] ) {
                    
                    NSLog(@"\n\n----------------%@", response);
                    NSData *data = [NSData dataWithContentsOfURL:localfile];
              
                    //init responseData object
                    responseData = [NSMutableData data];
                    [responseData appendData:data];
                     NSLog(@"responseData!%@", responseData);
                    
                    //convert from json to dictionary
                    NSDictionary *dicObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
             
                    NSLog(@"data recieved!%@", dicObject);

                    //call return result method
                    [self.delegate returnResult:dicObject];
                }
            }
        }];
        [task resume];
        

    }}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}



@end
