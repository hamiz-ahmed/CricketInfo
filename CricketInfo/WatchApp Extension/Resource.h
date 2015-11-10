//
//  Resource.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/9/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resource : NSObject{
    
    NSDictionary *_plist;
}

+ (Resource *)instance;
-(NSString *) getFlag:(NSString *) countryName;
@end
