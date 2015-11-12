//
//  MatchDetailController.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchDetailController.h"
#import "WatchServiceCalls.h"
#import "Resource.h"
#import "UserDefaults.h"
#import "XMLDictionary.h"
@interface MatchDetailController () <NSXMLParserDelegate>

@end

@implementation MatchDetailController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    [self setDetailVariables:context];
    [UserDefaults setFollowedMatchTeams:context];
    [self getMatchDetails];
    [self setFlags];
    [WatchServiceCalls getXMLwithSuccess:^(id response) {
        [(NSXMLParser*)response setDelegate:self];
        [(NSXMLParser*)response parse];
    } andfailure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    NSLog(@"%@",elementName);
    if([elementName isEqualToString:@"title"]){
        flag = false;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    // just do this for item elements

    if([elementName isEqualToString:@"title"]){
        flag = true;
    }
    NSLog(@"%@",elementName);
    NSLog(@"%@",attributeDict);
    
    // then you just need to grab each of your attributes
    //NSString * name = [attributeDict objectForKey:@"url"];
    
    // ... get the other attributes
    
    // when we have our various attributes, you can add them to your arrays
    
    // ... same for the other arrays
}

-(void)setFlags{
    NSString *flag1 = [[Resource instance] getFlag:_team1];
    NSString *flag2 = [[Resource instance] getFlag:_team2];
    if(flag1 && flag2){
        [self.flagTeam1 setImage:[UIImage imageNamed:flag1]];
        [self.flagTeam2 setImage:[UIImage imageNamed:flag2]];
        return;
    }
    [self.flagGroup setHidden:YES];
}
-(void)setDetailVariables:(NSDictionary*)data{
    _MatchID=[(NSNumber*)[data objectForKey:@"id"] intValue];
    _team1 =[data objectForKey:@"t1"];
    _team2 = [data objectForKey:@"t2"];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    if(flag)
        NSLog(@"%@",string);
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
    
}

-(void)getMatchDetails{
    /*NSString *getMatchDetailsURL = [NSString stringWithFormat:@"csa?id=%d",_MatchID];
    [WatchServiceCalls httpRequest:getMatchDetailsURL onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self.loadingLabel setText:@"Match Summary"];
        _allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [self setMatchDescriptionString:[[_allData firstObject] objectForKey:@"de"]];
        [_matchSummaryLabel setText:[[_allData firstObject] objectForKey:@"si"]];
        NSString *matchSummary = [[_allData firstObject] objectForKey:@"si"];
        [UserDefaults setMatchScore:matchSummary];

    }];*/
    
    [WatchServiceCalls getMatchDetailsWithID:_MatchID withSuccess:^(id response) {
        [self.loadingLabel setText:@"Match Summary"];
        _allData = (NSArray*)response;
        [self setMatchDescriptionString:[[_allData firstObject] objectForKey:@"de"]];
        [_matchSummaryLabel setText:[[_allData firstObject] objectForKey:@"si"]];
        NSString *matchSummary = [[_allData firstObject] objectForKey:@"si"];
        [UserDefaults setMatchScore:matchSummary];
    } andfailure:^(NSError *error) {
        
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
    for(int i=1;i<[matchDetailsList count];i++){
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



