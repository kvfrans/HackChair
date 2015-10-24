//
//  ViewController.m
//  HackChair
//
//  Created by Kevin Frans on 10/24/15.
//  Copyright © 2015 Kevin Frans. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

#define _width self.view.frame.size.width

@interface ViewController ()
{
    CMMotionManager* motionManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    gyro
    __block float yTotal = 0;
    UILabel* yLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, _width, 50)];
    [self.view addSubview:yLabel];
    yLabel.textAlignment = NSTextAlignmentCenter;
    motionManager = [[CMMotionManager alloc] init];
    if([motionManager isGyroAvailable])
    {
        if([motionManager isGyroActive] == NO)
        {
            [motionManager setGyroUpdateInterval:1.0f / 10.0f];
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMGyroData *gyroData, NSError *error)
             {
                 yTotal = yTotal + gyroData.rotationRate.y;
                 NSString *y = [[NSString alloc] initWithFormat:@"%.02f",yTotal];
                 yLabel.text = y;

             }];
        }
    }


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
