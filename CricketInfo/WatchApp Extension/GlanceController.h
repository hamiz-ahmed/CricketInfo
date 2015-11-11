//
//  GlanceController.h
//  WatchApp Extension
//
//  Created by Waheeda on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
@import UIKit;

@interface GlanceController : WKInterfaceController{
    NSArray *_allData;
    int _MatchID;
    NSString *_team1;
    NSString *_team2;
    NSTimer *_timer;

}
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *matchSummary;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *flagTeam2;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *flagTeam1;
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *flagGroup;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *initialLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *oversLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *summaryLabel;

@end
