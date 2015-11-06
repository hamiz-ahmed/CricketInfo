//
//  ServiceCalls.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "WatchServiceCalls.h"
#import "Constant.h"

@implementation WatchServiceCalls


+(void)httpRequest:(NSString*)path onCompletion:(CompletionCallBack)completion{
    
    NSString *URL = [NSString stringWithFormat:@"%@/%@",SERVICE_URL,path];
    
    NSURLRequest* requestForMatchData = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:requestForMatchData completionHandler:completion] resume];
}

@end
