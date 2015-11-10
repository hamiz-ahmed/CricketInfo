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
    NSString *_team1;
    NSString *_team2;
}
@property (strong, nonatomic) IBOutlet WKInterfaceImage *flagTeam2;
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *flagGroup;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *flagTeam1;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *loadingLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *matchDetailsLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *matchSummaryLabel;

@end
