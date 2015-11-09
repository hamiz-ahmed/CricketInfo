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
        [self.loadingLabel setText:@"Match Summary"];
        _allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [self setMatchDescriptionString:[[_allData firstObject] objectForKey:@"de"]];
        [_matchSummaryLabel setText:[[_allData firstObject] objectForKey:@"si"]];

    }];
}

-(void)setMatchDescriptionString:(NSString*)description{
    NSArray *descriptionList = [description componentsSeparatedByString:@","];
    NSString *score = [descriptionList firstObject];
    score=[score stringByReplacingOccurrencesOfString:@"(" withString:@""];
    [self.scoreLabel setText:score];
    [self.matchDetailsLabel setText:[self getMatchDetailsString:descriptionList]];
}



-(NSString*)getMatchDetailsString:(NSArray*)matchDetailsList{
    NSMutableString *details = [[NSMutableString alloc] init];
    for(int i=0;i<[matchDetailsList count];i++){
        if(i==[matchDetailsList count]-1)
            [details appendString:[NSString stringWithFormat:@"%@",[matchDetailsList objectAtIndex:i]]];
        else
            [details appendString:[NSString stringWithFormat:@"%@ \n",[matchDetailsList objectAtIndex:i]]];
            
    }
    return [details stringByReplacingOccurrencesOfString:@")" withString:@""];
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



