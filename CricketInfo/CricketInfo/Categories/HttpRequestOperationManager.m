//
//  HttpRequestOperationManager.m
//  iOSTemplate
//
//  Created by Waheeda on 6/26/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "HttpRequestOperationManager.h"

@implementation HttpRequestOperationManager


- (AFHTTPRequestOperation *)makeHttpRequestWithMethod:(HttpMethod)method
                                                     URLString:(NSString *)URLString
                                                    parameters:(id)parameters
                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    AFHTTPRequestOperation *operation;

    switch (method) {
        case HttpMethodGET:
            operation = [self GET:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodPOST:
            operation = [self POST:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodPUT:
            operation = [self PUT:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodDELETE:
            operation = [self DELETE:URLString parameters:parameters success:success failure:failure];
            break;
        default:
            break;
    }
    return operation;
}


-(void) setHttpHeaders:(NSDictionary *)headers  {

  for (NSString *key in headers) {
      if([headers objectForKey:key])
        [self.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
}

-(void) clearAuthorizationHeader {
    [self.requestSerializer clearAuthorizationHeader];
}

@end
