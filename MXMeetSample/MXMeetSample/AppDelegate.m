//
//  AppDelegate.m
//  MXMeetSample
//
//  Created by KenYu on 7/8/14.
//  Copyright (c) 2014 Moxtra. All rights reserved.
//

/*
 A simple sample shows how to start meet via Moxtra SDK.
 For simplicity, this sample does limited API calling and error handling.
 See http://developer.moxtra.com/moxo/docs-ios-sdk/ for more details.
 */

#import "AppDelegate.h"
#import "Moxtra.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Fill in the consumer Client ID and Client Secret with the values that you received from Moxtra
    // To get an app Cient ID, visit http://developer.moxtra.com
    NSString *CONSUMER_CLIENT_ID = @"vY86Cl-BouY";
    NSString *CONSUMER_CLIENT_SECRET = @"u46aYNSnQDc";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:CONSUMER_CLIENT_ID applicationClientSecret:CONSUMER_CLIENT_SECRET serverType:sandboxServer];
    
    // Fill in the user identity
    MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
    useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
    useridentity.userIdentity = @"JohnDoe";
    
    // Set up Moxtra User Account
    [[Moxtra sharedClient] initializeUserAccount:useridentity orgID:nil firstName:@"John" lastName:@"Doe" avatar:nil devicePushNotificationToken:nil withTimeout:0.0 success:^{
        NSLog(@"Setup user account success");
    } failure:^(NSError *error) {
        NSLog(@"Setup user account failed, %@", [NSString stringWithFormat:@"error code [%ld] description: [%@] info [%@]", (long)[error code], [error localizedDescription], [[error userInfo] description]]);
    }];
    
    // Create a MeetViewController instance where we will put a UIWebView
    self.meetViewController = [[MeetViewController alloc] init];
    
    // Create a UINavigationController instance where we will put the start meet button
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.meetViewController];
    [navController setNavigationBarHidden:YES];
    
    // Set navigationController as root view controller
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
