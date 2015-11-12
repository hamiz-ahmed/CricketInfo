//
//  InterfaceController.m
//  WatchApp Extension
//
//  Created by Waheeda on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "InterfaceController.h"
#import "HttpRequestManager.h"
#import "InterfaceRowController.h"
#import "WatchServiceCalls.h"
@interface InterfaceController()

@end


@implementation InterfaceController

-(instancetype)init{
    self = [super init];
    if(self){
        if(WCSession.isSupported){
            WCSession* session = WCSession.defaultSession;
            session.delegate = self;
            [session activateSession];
        }
        [self getMatchListData];
        
        [[HttpRequestManager new] get:@"http://static.espncricinfo.com/rss/livescores.xml" success:^(id response) {
            NSLog(@"%@", response);
        } failure:^(NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        } entity:nil];
    }
        
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    if(message){
//        _matchList = [[NSArray alloc] init];
//        _matchList = (NSArray*)message;
//        [self loadTableRows];
    }
    
    
}

- (void)handleUserActivity:(NSDictionary *)userInfo {
    // Use data from the userInfo dictionary passed in to push to the appropriate controller with detailed info.
    [self pushControllerWithName:@"MatchDetail" context:userInfo];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    //NSDictionary *rowData = self.elementsList[rowIndex];
    NSDictionary *data = @{@"id":[[_matchList objectAtIndex:rowIndex] objectForKey:@"id"],@"t1":[[_matchList objectAtIndex:rowIndex] objectForKey:@"t1"],@"t2":[[_matchList objectAtIndex:rowIndex] objectForKey:@"t2"]};
    
    [self pushControllerWithName:@"MatchDetail" context:data];
}

- (void)loadTableRows {
    [self.interfaceTable setNumberOfRows:_matchList.count withRowType:@"default"];
    [_matchList enumerateObjectsUsingBlock:^(NSDictionary *rowData, NSUInteger idx, BOOL *stop) {
        InterfaceRowController *elementRow = [self.interfaceTable rowControllerAtIndex:idx];
        [elementRow.elementLabel setText:[NSString stringWithFormat:@"%@ vs %@",[rowData objectForKey:@"t1"],[rowData objectForKey:@"t2"]]];
        elementRow.matchID = (int)[rowData objectForKey:@"id"];
    }];
}


-(void)initializeMatchList:(NSArray*)data{
    _matchList = [[NSArray alloc] initWithArray:data];
}

-(void)getMatchListData{
    [WatchServiceCalls httpRequest:@"csa" onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data){
            NSMutableDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            [self initializeMatchList:(NSArray*)allData];
            [self loadTableRows];
        }
        else if(error){
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}
    



@end



