//
//  GlanceController.m
//  WatchApp Extension
//
//  Created by Waheeda on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "GlanceController.h"
#import "UserDefaults.h"
#import "WatchServiceCalls.h"
#import "Resource.h"

@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [_initialLabel setText:[UserDefaults getMatchScore]];
    [self getMatchTeams];
    [self setFlags];
    [self getMatchDetails];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                  target: self
                                                selector:@selector(fetchingMatchInfo:)
                                                userInfo: nil repeats:YES];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [_timer invalidate];
}

-(void)fetchingMatchInfo:(NSTimer*)timer{
    [self getMatchDetails];
}

-(void)getMatchTeams{
    NSDictionary *teams = [UserDefaults getFollowedMatchTeams];
    _MatchID=[(NSNumber*)[teams objectForKey:@"id"] intValue];
    _team1 =[teams objectForKey:@"t1"];
    _team2 = [teams objectForKey:@"t2"];
}

-(void)getMatchDetails{
    if(_MatchID){
        NSString *getMatchDetailsURL = [NSString stringWithFormat:@"csa?id=%d",_MatchID];
        [WatchServiceCalls httpRequest:getMatchDetailsURL onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
            // [self.loadingLabel setText:@"Match Summary"];
            _allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            [self.matchSummary setText:@"Match Summary:"];
            [self setScoreAndOversLabel:[[_allData firstObject] objectForKey:@"de"]];
            [self setSummaryLabelText:[[_allData firstObject] objectForKey:@"si"]];
        }];
    }
}

-(void)setFlags{
    NSString *flag1 = [[Resource instance] getFlag:_team1];
    NSString *flag2 = [[Resource instance] getFlag:_team2];
    if(flag1 && flag2){
        [self.flagTeam1 setImage:[UIImage imageNamed:flag1]];
        [self.flagTeam2 setImage:[UIImage imageNamed:flag2]];
        [self.flagGroup setHidden:NO];
        return;
    }
    [self.flagGroup setHidden:YES];
}

-(void)setScoreAndOversLabel:(NSString*)data{
    NSArray *descriptionList = [data componentsSeparatedByString:@","];
    NSArray *scoreAndOvers = [[descriptionList firstObject] componentsSeparatedByString:@"(" ];
    NSString *score = [scoreAndOvers firstObject];
    NSString *overs = [scoreAndOvers lastObject];
    if([score isEqual:overs]){
        [self.oversLabel setText:@""];
        [self.scoreLabel setAttributedText:[self createVenueAttributedString:score]];
        return;
    }
    [self.scoreLabel setText:score];
    [self.oversLabel setText:overs];
}

-(NSMutableAttributedString*)createVenueAttributedString:(NSString*)text{
    NSMutableAttributedString *venue=[[NSMutableAttributedString alloc] initWithString:text];
    [venue addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:bold] range:NSMakeRange(0, [venue length])];
    return venue;
}

-(void)setSummaryLabelText:(NSString*)summary{
    //[self.summaryLabel setText:[NSString stringWithFormat:@"Match Summary:\n%@",summary]];
    [self.summaryLabel setText:summary];
}

@end



