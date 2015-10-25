//
//  AppDelegate.h
//  MXMeetSample
//
//  Created by KenYu on 7/8/14.
//  Copyright (c) 2014 Moxtra. All rights reserved.
//

@import Accelerate;
@import AddressBook;
@import AddressBookUI;
@import AssetsLibrary;
@import AudioToolbox;
@import AVFoundation;
@import CFNetwork;
@import CoreBluetooth;
@import CoreGraphics;
@import CoreImage;
@import CoreLocation;
@import CoreMedia;
@import CoreText;
@import CoreVideo;
@import EventKit;
@import Foundation;
@import ImageIO;
@import MapKit;
@import MediaPlayer;
@import MessageUI;
@import MobileCoreServices;
@import OpenGLES;
@import QuartzCore;
@import Security;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import CoreTelephony;


#import "MeetViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MeetViewController *meetViewController;

@end
