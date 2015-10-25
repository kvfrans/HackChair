//
//  MeetViewController.m
//  MXMeetSample
//
//  Created by KenYu on 7/8/14.
//  Copyright (c) 2014 Moxtra. All rights reserved.
//

#import "MeetViewController.h"
#import "AVFoundation/AVFoundation.h"
#import <ImageIO/CGImageProperties.h>
#import "Moxtra.h"

@interface MeetViewController ()
{
    UIImageView* v;
    AVCaptureStillImageOutput* stillImageOutput;
    UIButton* b;
    UITextField* t;
}

@end

@implementation MeetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) tick:(NSTimer*)timer
{
    [self capture];
}

-(void) capture
{
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
             // Do something with the attachments.
             //             NSLog(@"attachements: %@", exifAttachments);
         } else {
             NSLog(@"no attachments");
         }
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         v.image = image;
     }];
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetHigh;
    AVCaptureDevice *device = [self frontCamera];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [session addInput:input];
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    newCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    newCaptureVideoPreviewLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //    newCaptureVideoPreviewLayer.la
    [self.view.layer addSublayer:newCaptureVideoPreviewLayer];
    [session startRunning];
    
    v = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:v];
    
    t = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    t.text = @"990997824";
    [self.view addSubview:t];
    
    [self.view endEditing:YES];
    
    b = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    b.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:b];
    
    [b addTarget:self action:@selector(startMeet:) forControlEvents:UIControlEventTouchUpInside];
    
    //    capturedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    //    //    capturedView.image = image;
    //    [self.view addSubview:capturedView];
    
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:stillImageOutput];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    
    
    
    
    
    
    
    // Add a start meet button for testing
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"Start Meet" style:UIBarButtonItemStyleBordered target:self action:@selector(startMeet:)],nil];
    
	
    
}


- (void)startMeet:(id)sender
{
    
    [self.view endEditing:YES];
//    if ([[Moxtra sharedClient] isMeetStarted])
//		return;
//    
//    [[Moxtra sharedClient] startMeet:@"Moxtra Meet" withDelegate:nil inviteAttendeesBlock:nil success:^(NSString *meetID) {
//        NSLog(@"Start meet success with MeetID [%@]", meetID);
//    } failure:^(NSError *error) {
//        NSLog(@"Start meet failed, %@", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
//    }];

    [[Moxtra sharedClient]
      joinMeet: t.text
      withUserName:@"kev" withDelegate: nil
      inviteAttendeesBlock: nil
      success: ^(NSString *meetID) {
          NSLog(@"Join meet success with MeetID [%@]", meetID);
      } failure: ^(NSError *error) {
          NSLog(@"Join meet failed, %@", [NSString stringWithFormat:@"error code [%ld] description: [%@] info [%@]", (long)[error code], [error localizedDescription], [[error userInfo] description]]);
      }];
    
    self.navigationItem.rightBarButtonItems = nil;
    
    t.textColor = [UIColor clearColor];
    b.backgroundColor = [UIColor clearColor];
//    self.navigationItem.
    
//    []
}

@end
