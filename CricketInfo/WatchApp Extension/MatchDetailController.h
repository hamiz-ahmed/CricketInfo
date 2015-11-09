//
//  MatchDetailController.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface MatchDetailController : WKInterfaceController{
    int _MatchID;
    NSArray *_allData;
}
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *loadingLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *matchDetailsLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *matchSummaryLabel;

@end
