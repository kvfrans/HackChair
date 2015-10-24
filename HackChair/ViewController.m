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
#import <Firebase/Firebase.h>
#import <ImageIO/CGImageProperties.h>
#import "Muse/Muse.h"
#import <AudioToolbox/AudioServices.h>

#define _width self.view.frame.size.width
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface ViewController ()
{
    CMMotionManager* motionManager;
    AVCaptureStillImageOutput* stillImageOutput;
    UIImageView* capturedView;
    UIButton* capture;
    UILabel* label;
    int count;
    float angle;
}

@end

@implementation ViewController

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

-(void) tick:(NSTimer*)timer
{
    count = count - 1;
    label.text = [NSString stringWithFormat:@"%d",count];
    if(count == 0)
    {
        count = 3;
        [self capture];
    }
}

-(void) capture
{
    
//    UIView* v = [[UIView alloc] initWithFrame: CGRectMake(0, 0, dWidth, dHeight)];
//    [self.view addSubview: v];
//    v.backgroundColor = [UIColor whiteColor];
//    [UIView animateWithDuration:0.2 delay:0.0 options:
//     UIViewAnimationOptionCurveEaseIn animations:^{
//         v.backgroundColor = [UIColor clearColor];
//     } completion:^ (BOOL completed) {
//         [v removeFromSuperview];
//     }];
    
    
//    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"snap"]+1 forKey:@"snap"];
    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"blinks"] intValue]);
    
    if(angle > 15)
    {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"blinks"] intValue])
        {
            [self vibrate];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"blinks"];
    
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
        CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
        if (exifAttachments)
        {
        }
        else
        {
         NSLog(@"no attachments");
        }

        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
         Firebase *myRootRef = [[[Firebase alloc] initWithUrl:@"https://hackchair.firebaseio.com"] childByAppendingPath:@"sitting"];
        if(isDarkImage(image))
        {
            [myRootRef setValue:[NSNumber numberWithBool:true]];
        }
        else
        {
            [myRootRef setValue:[NSNumber numberWithBool:false]];
        }

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Firebase *myRootRef = [[[Firebase alloc] initWithUrl:@"https://hackchair.firebaseio.com"] childByAppendingPath:@"lean"];
    // Write data to Firebase
    [myRootRef setValue:0];
    
//    gyro
    __block float yTotal = 0;
    UILabel* yLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _width, 50)];
    [self.view addSubview:yLabel];
    yLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel* yLabelChange = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, _width, 50)];
    [self.view addSubview:yLabelChange];
    yLabelChange.textAlignment = NSTextAlignmentCenter;
    
    motionManager = [[CMMotionManager alloc] init];
    if([motionManager isGyroAvailable])
    {
        if([motionManager isGyroActive] == NO)
        {
            [motionManager setGyroUpdateInterval:1.0f / 10.0f];
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMGyroData *gyroData, NSError *error)
             {
                 float degs = RADIANS_TO_DEGREES(gyroData.rotationRate.y) / 10;
                 degs = degs - 0.4;
                 if(degs > 0.2 || degs < -0.2)
                 {
                     yTotal = yTotal + degs;
                 }
                 NSString *y = [[NSString alloc] initWithFormat:@"%.02f",yTotal];
                 angle = yTotal;
                 yLabel.text = y;
                 yLabelChange.text = [[NSString alloc] initWithFormat:@"%.02f",degs];
                 [myRootRef setValue:[NSNumber numberWithFloat:yTotal]];
             }];
        }
    }
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetHigh;
    AVCaptureDevice *device = [self frontCamera];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [session addInput:input];
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    newCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    newCaptureVideoPreviewLayer.frame = CGRectMake(0, 0, _width, self.view.frame.size.height);
    //    newCaptureVideoPreviewLayer.la
    [self.view.layer addSublayer:newCaptureVideoPreviewLayer];
    [session startRunning];
    
    //    capturedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    //    //    capturedView.image = image;
    //    [self.view addSubview:capturedView];
    
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:stillImageOutput];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    count = 3;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, _width, 100)];
    label.text = @"3";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:60];
    [self.view addSubview:label];


    
}

- (void) vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


BOOL isDarkImage(UIImage* inputImage){
    
    BOOL isDark = FALSE;
    
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(inputImage.CGImage));
    const UInt8 *pixels = CFDataGetBytePtr(imageData);
    
    int darkPixels = 0;
    
    int length = CFDataGetLength(imageData);
    int const darkPixelThreshold = (inputImage.size.width*inputImage.size.height)*.75;
    
    for(int i=0; i<length; i+=4)
    {
        int r = pixels[i];
        int g = pixels[i+1];
        int b = pixels[i+2];
        
        //luminance calculation gives more weight to r and b for human eyes
        float luminance = (0.299*r + 0.587*g + 0.114*b);
        if (luminance<50) darkPixels ++;
    }
    
    if (darkPixels >= darkPixelThreshold)
        isDark = YES;
    
    CFRelease(imageData);
    
    return isDark;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
