//
//  HttpRequestOperationManager.h
//  iOSTemplate
//
//  Created by Waheeda on 6/26/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "AFHTTPRequestOperationManager.h"
#import "Enum.h"

@interface HttpRequestOperationManager : AFHTTPRequestOperationManager


- (AFHTTPRequestOperation *)makeHttpRequestWithMethod:(HttpMethod)method
                                            URLString:(NSString *)URLString
                                           parameters:(id)parameters
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


-(void) setHttpHeaders:(NSDictionary *)headers;
-(void) clearAuthorizationHeader;
@end
