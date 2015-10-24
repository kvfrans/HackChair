//
//  AppDelegate.h
//  HackChair
//
//  Created by Kevin Frans on 10/24/15.
//  Copyright © 2015 Kevin Frans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Muse/Muse.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<IXNMuse> muse;

- (void)sayHi;
- (void)reconnectToMuse;


@end

