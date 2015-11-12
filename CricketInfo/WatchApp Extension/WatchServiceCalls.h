//
//  ServiceCalls.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);

@interface WatchServiceCalls : NSObject
typedef void (^CompletionCallBack)(NSData *data, NSURLResponse *response, NSError *error);
//typedef void (^failureCallback)(NSError *error);

+(void)httpRequest:(NSString*)path onCompletion:(CompletionCallBack)completion;
+(void)getMatches:(successCallback)success andfailure:(failureCallback)failure;
+(void)getMatchDetailsWithID:(int)matchID withSuccess:(successCallback)success andfailure:(failureCallback)failure;
+(void)getXMLwithSuccess:(successCallback)success andfailure:(failureCallback)failure;
@end
