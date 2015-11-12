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
#import "Enum.h"

@implementation WatchServiceCalls


+(void)httpRequest:(NSString*)path onCompletion:(CompletionCallBack)completion{
    
    NSString *URL = [NSString stringWithFormat:@"%@/%@",SERVICE_URL,path];
    
    NSURLRequest* requestForMatchData = [NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:150.0f];
    [[[NSURLSession sharedSession] dataTaskWithRequest:requestForMatchData completionHandler:completion] resume];
}

+(void)getMatches:(successCallback)success andfailure:(failureCallback)failure{
    HttpRequestManager *http = [HttpRequestManager new];
    [http setResponseContentType:ContentTypeJSON];
    [http get:@"http://cricscore-api.appspot.com/csa" success:success failure:false response:nil];
}

+(void)getMatchDetailsWithID:(int)matchID withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    HttpRequestManager *http = [HttpRequestManager new];
    [http setResponseContentType:ContentTypeJSON];
    [http get:[NSString stringWithFormat:@"http://cricscore-api.appspot.com/csa?id=%d",matchID] success:success failure:false response:nil];
}

+(void)getXMLwithSuccess:(successCallback)success andfailure:(failureCallback)failure{
    HttpRequestManager *http = [HttpRequestManager new];
    [http setResponseContentType:ContentTypeXML];
    [http get:@"http://static.espncricinfo.com/rss/livescores.xml" success:success failure:false response:nil];
}

@end
