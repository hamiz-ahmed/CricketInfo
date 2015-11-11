//
//  UserDefaults.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/10/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject
+(NSString*)getMatchScore;
+(void)setMatchScore:(NSString*)score;
+ (NSUserDefaults*)appGroupDefaults;
+(NSString*)getSecondTeam;
+(NSString*)getFirstTeam;
+(void)setTeamNames:(NSString*)team1 andSecondTeam:(NSString*)team2;
+(void)setFollowedMatchTeams:(NSDictionary*)details;
+(NSDictionary*)getFollowedMatchTeams;
@end
