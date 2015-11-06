//
//  MatchDetailController.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchDetailController.h"
#import "WatchServiceCalls.h"
@interface MatchDetailController ()

@end

@implementation MatchDetailController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    _MatchID=[(NSNumber*)[context objectForKey:@"id"] intValue];
    NSLog(@"%d",_MatchID);
    [self getMatchDetails];
    // Configure interface objects here.
}



-(void)getMatchDetails{
    
    NSString *getMatchDetailsURL = [NSString stringWithFormat:@"csa?id=%d",_MatchID];
    [WatchServiceCalls httpRequest:getMatchDetailsURL onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        _allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [self modifyDescriptionString:[[_allData firstObject] objectForKey:@"de"]];
        [_matchSummaryLabel setText:[[_allData firstObject] objectForKey:@"si"]];
      //  [self initializeMatchList:(NSArray*)allData];
     //   [self loadTableRows];
    }];
}

-(void)modifyDescriptionString:(NSString*)description{
    NSArray *descriptionList = [description componentsSeparatedByString:@","];
    NSString *score = [descriptionList firstObject];
    NSString *batsman1 = [descriptionList objectAtIndex:1];
    NSString *batsman2 = [descriptionList objectAtIndex:2];
    NSString *bowler = [descriptionList objectAtIndex:3];
    score=[score stringByReplacingOccurrencesOfString:@"(" withString:@""];
    bowler=[bowler stringByReplacingOccurrencesOfString:@")" withString:@""];
    [_scoreLabel setText:score];
    [_batsmenLabel setText:[NSString stringWithFormat:@"%@, %@",batsman1,batsman2]];
    [_bowlerLabel setText:bowler];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



