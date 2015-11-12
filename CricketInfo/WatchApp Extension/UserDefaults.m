//
//  UserDefaults.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/10/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults
+ (NSUserDefaults*)appGroupDefaults {
    static NSUserDefaults *appGroupDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appGroupDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cricketinfo.com"];
       // appGroupDefaults = [NSUserDefaults standardUserDefaults];
    });
    return appGroupDefaults;
}

+(void)setMatchScore:(NSString*)score{
    [[UserDefaults appGroupDefaults] setObject:score forKey:@"score"];
}

+(void)setTeamNames:(NSString*)team1 andSecondTeam:(NSString*)team2{
    [[UserDefaults appGroupDefaults] setObject:team1 forKey:@"team1"];
    [[UserDefaults appGroupDefaults] setObject:team2 forKey:@"team2"];
}

+(void)setFollowedMatchTeams:(NSDictionary*)details{
    [[UserDefaults appGroupDefaults] setObject:details forKey:@"followedMatchTeams"];
}

+(NSDictionary*)getFollowedMatchTeams{
    return [[UserDefaults appGroupDefaults] objectForKey:@"followedMatchTeams"];
}

+(NSString*)getFirstTeam{
    return [[UserDefaults appGroupDefaults] objectForKey:@"team1"];
}

+(NSString*)getSecondTeam{
    return [[UserDefaults appGroupDefaults] objectForKey:@"team2"];
}

+(NSString*)getMatchScore{
   return [[UserDefaults appGroupDefaults] objectForKey:@"score"];
}

@end
