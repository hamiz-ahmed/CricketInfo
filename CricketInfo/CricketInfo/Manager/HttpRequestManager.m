//
//  HttpRequestManager.m
//  10Pearls
//
//  Created by mohsin on 4/4/14.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "HttpRequestManager.h"
#import "ParserUtils.h"
#import "BaseEntity.h"
#import "StringUtils.h"
#import "BaseResponse.h"
#import "AppDelegate.h"
#import "Alert.h"

@implementation HttpRequestManager


- (id)init {
    if (self = [super init]) {
        __unsafe_unretained typeof(self) weakSelf = self;
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setTimeoutIntervalForRequest:REQUEST_TIMEOUT];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

        _manager= [[HttpRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
        _manager.requestSerializer  = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [_manager.operationQueue setMaxConcurrentOperationCount:1];
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [weakSelf manageReachabilityUpdates:status];
        }];
        [_manager.reachabilityManager startMonitoring];
        self.queue = _manager.operationQueue;
    }
    return self;
}

-(void) setHttpHeader:(NSDictionary *) headers {

    [_manager setHttpHeaders:headers];
}

-(void) setAccessToken:(NSString *)accessToken {

    _accessToken = accessToken;
    if(accessToken != nil){
        [_manager setHttpHeaders:@{KEY_ACCESS_TOKEN: accessToken}];
    }
    else
        [_manager clearAuthorizationHeader];
}

-(void) cancelAllOperations {

    [self.manager.operationQueue cancelAllOperations];
}

-(void) manageReachabilityUpdates:(AFNetworkReachabilityStatus) status {

    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
//            [self.queue setSuspended:NO];
            break;
        case AFNetworkReachabilityStatusNotReachable:
        default:
//            [self.queue setSuspended:YES];
//            [Alert showNetworkError];
            break;
    }
}


- (void)put:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity{
    [self makeRequestWithPath:path httpMethod:HttpMethodPUT parameters:parameters success:^(id response) {
       [self onSuccessWithEntity:entity successBlock:success response:response];
    } failure:^(NSError *error) {
         failure(error);
    }];
}

- (void)put:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject{
    [self makeRequestWithPath:path httpMethod:HttpMethodPUT parameters:parameters success:^(id response) {
      [self onSuccessWithResponse:responseObject successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)post:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity{
    [self makeRequestWithPath:path httpMethod:HttpMethodPOST parameters:parameters success:^(id response) {
        [self onSuccessWithEntity:entity successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)post:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject{
    [self makeRequestWithPath:path httpMethod:HttpMethodPOST parameters:parameters success:^(id response) {
      [self onSuccessWithResponse:responseObject successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];

}


- (void)get:(NSString *)string success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity {

    [self makeRequestWithPath:string httpMethod:HttpMethodGET parameters:nil success:^(id response) {
        [self onSuccessWithEntity:entity successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)get:(NSString *)string success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject{

    [self makeRequestWithPath:string httpMethod:HttpMethodGET parameters:nil success:^(id response) {
        [self onSuccessWithResponse:responseObject successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)delete:(NSString *)string success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity {
    [self makeRequestWithPath:string httpMethod:HttpMethodDELETE parameters:nil success:^(id response) {
        [self onSuccessWithEntity:entity successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)delete:(NSString *)string success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject{
    [self makeRequestWithPath:string httpMethod:HttpMethodDELETE parameters:nil success:^(id response) {
        [self onSuccessWithResponse:responseObject successBlock:success response:response];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void) onSuccessWithEntity:(BaseEntity *) entity successBlock:(successCallback)success response:(id)responseDictionary {

    if(entity) {
        [entity set:responseDictionary];
        success(entity);
    }
    else {
        success(responseDictionary);
    }
}
-(void) onSuccessWithResponse:(BaseResponse *) response successBlock:(successCallback)success response:(id)responseDictionary {

    if(response) {
        [response set:responseDictionary];
        success(response);
    }
    else {
        success(responseDictionary);
    }
}

// For full URLS
-(void) makeRequestWithURL:(NSString *)url httpMethod:(HttpMethod)method parameters:(NSDictionary *)parameters success:(successCallback)success failure:(failureCallback)failure {

    HttpRequestOperationManager *manager = [HttpRequestOperationManager manager];
    [manager makeHttpRequestWithMethod:method URLString:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setCallbacksForOperation:operation success:success failure:failure];
        [self onLoaded:operation responseObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setCallbacksForOperation:operation success:success failure:failure];
        [self onLoadFailed:operation error:error];
    }];
}


#pragma mark -
#pragma mark - Private
#pragma makr -

-(AFHTTPRequestOperation *) makeRequestWithPath:(NSString *)path httpMethod:(HttpMethod)method parameters:(NSDictionary *)parameters success:(successCallback)success failure:(failureCallback)failure {
    AFHTTPRequestOperation *operation = [self.manager makeHttpRequestWithMethod:method URLString:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self setCallbacksForOperation:operation success:success failure:failure];
            [self onLoaded:operation responseObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self setCallbacksForOperation:operation success:success failure:failure];
            [self onLoadFailed:operation error:error];
        }];

    return operation;
}


-(void) setCallbacksForOperation:(AFHTTPRequestOperation *)operation success:(successCallback)success failure:(failureCallback)failure {

    [operation setOnSuccessCallback:success];
    [operation setOnFailureCallback:failure];
}

-(void) onLoaded:(AFHTTPRequestOperation *) operation responseObject:(id)responseObject {

    // CHECK FOR ERROR IN RESPONSE OBJECT
    if(operation.response.statusCode >= 200 && operation.response.statusCode < 300)
        operation.onSuccessCallback(responseObject);
    else
        [self onLoadFailed:operation error:nil];

}
-(void) onLoadFailed:(AFHTTPRequestOperation *) operation error:(NSError *)error {
    operation.onFailureCallback(error);
}
@end
