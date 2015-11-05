//
//  AFHTTPRequestOperation+CustomProperties.h
//  iOSTemplate
//
//  Created by Waheeda on 6/18/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "AFHTTPRequestOperation.h"

@interface AFHTTPRequestOperation (CustomProperties)

#if NS_BLOCKS_AVAILABLE
typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);
#endif

@property (copy) successCallback onSuccessCallback;
@property (copy) failureCallback onFailureCallback;
@end
