//
//  MatchList.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchListView.h"

@implementation MatchListView


-(void)awakeFromNib{
        static NSUserDefaults *appGroupDefaults = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            appGroupDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cricketinfo.com"];
        });
      //  NSString *firstName = @"Hamiz";
      //  [appGroupDefaults setObject:firstName forKey:@"name"];
        NSLog(@"%@",[appGroupDefaults objectForKey:@"name"]);
    [_label setText:[appGroupDefaults objectForKey:@"name"]];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
