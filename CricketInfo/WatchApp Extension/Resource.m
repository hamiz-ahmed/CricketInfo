//
//  Resource.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/9/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "Resource.h"

@implementation Resource
+ (Resource *)instance {
    static Resource *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Resource alloc] init];
    });
    return sharedInstance;
}

-(void) loadPlist {
    
    if(_plist == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Flags" ofType:@"plist"];
        _plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
}

-(NSString *) getFlag:(NSString *)countryName {
    
    [self loadPlist];
    NSString *flag = (NSString*)[_plist objectForKey:countryName];
    
    return flag;
}

@end
