//
//  AFHTTPRequestOperation+CustomProperties.m
//  iOSTemplate
//
//  Created by Waheeda on 6/18/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "AFHTTPRequestOperation+CustomProperties.h"
#import <objc/runtime.h>

@implementation AFHTTPRequestOperation (CustomProperties)


-(void) setOnSuccessCallback:(successCallback)onSuccessCallback {

  objc_setAssociatedObject(self, @selector(onSuccessCallback), onSuccessCallback, OBJC_ASSOCIATION_COPY);
}
-(successCallback) onSuccessCallback {

     return objc_getAssociatedObject(self, @selector(onSuccessCallback));
}

-(void) setOnFailureCallback:(failureCallback)onFailureCallback {

     objc_setAssociatedObject(self, @selector(onFailureCallback), onFailureCallback, OBJC_ASSOCIATION_COPY);
}

-(failureCallback) onFailureCallback {

 return objc_getAssociatedObject(self, @selector(onFailureCallback));
}

@end
