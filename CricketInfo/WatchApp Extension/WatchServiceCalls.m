//
//  ServiceCalls.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "WatchServiceCalls.h"
#import "Constant.h"
#import "HttpRequestManager.h"

@implementation WatchServiceCalls


+(void)httpRequest:(NSString*)path onCompletion:(CompletionCallBack)completion{
    
    NSString *URL = [NSString stringWithFormat:@"%@/%@",SERVICE_URL,path];
    
    NSURLRequest* requestForMatchData = [NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:150.0f];
    [[[NSURLSession sharedSession] dataTaskWithRequest:requestForMatchData completionHandler:completion] resume];
}

+(void)getMatches:(successCallback)success andfailure:(failureCallback)failure{
    [[HttpRequestManager new] get:@"csa" success:success failure:false response:nil];
}

+(void)getMatchDetailsWithID:(int)matchID withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    [[HttpRequestManager new] get:[NSString stringWithFormat:@"csa?id=%d",matchID] success:success failure:false response:nil];
}

@end
