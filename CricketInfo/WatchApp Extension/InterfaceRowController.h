//
//  InterfaceRowController.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;
@interface InterfaceRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *elementLabel;
@property (nonatomic) int matchID;
@end
