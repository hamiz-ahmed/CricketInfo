//
//  AppDelegate.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "RegistrationController.h"
#import "MatchListController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MatchListController *c = [[MatchListController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];
    self.window.rootViewController = navigationController;


    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    [self setupLocalNotifications];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupLocalNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];

    // current time plus 10 secs
    NSDate *now = [NSDate date];
    NSDate *dateToFire = [now dateByAddingTimeInterval:10];

    NSLog(@"now time: %@", now);
    NSLog(@"fire time: %@", dateToFire);

    localNotification.fireDate = dateToFire;
    localNotification.alertBody = @"Time to get up!";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1; // increment

    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Object 1", @"Key 1", @"Object 2", @"Key 2", nil];
    localNotification.userInfo = infoDict;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+(AppDelegate*)getInstance{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    NSLog(@" local notification was received");
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
