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

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
    }

    [[HttpRequestManager new] get:@"https://cricscore-api.appspot.com/csa" success:^(id response) {
        NSLog(@"%@", response);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    } entity:nil];
    
    [self getMatchListData];
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
    _matchList = [[NSArray alloc] init];
    _matchList = data;
}

-(void)getMatchListData{
    [WatchServiceCalls httpRequest:@"csa" onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [self initializeMatchList:(NSArray*)allData];
        [self loadTableRows];
    }];
}
    



@end



