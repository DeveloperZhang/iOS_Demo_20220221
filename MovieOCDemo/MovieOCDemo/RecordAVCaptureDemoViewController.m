//
//  RecordAVCaptureDemoViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "RecordAVCaptureDemoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>


@interface RecordAVCaptureDemoViewController ()<AVCaptureFileOutputRecordingDelegate> {
    BOOL isRecording;
}

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureMovieFileOutput *output;



@end

@implementation RecordAVCaptureDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *camera = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:&error];
    AVCaptureDevice *micDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *mic = [AVCaptureDeviceInput deviceInputWithDevice:micDevice error:&error];
    
    if (error || !camera || !mic) {
        NSLog(@"Input Error");
    }else {
        [self.session addInput:camera];
        [self.session addInput:mic];
    }
    
    self.output = [[AVCaptureMovieFileOutput alloc] init];
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 - 50);
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    [self.session startRunning];
    isRecording = NO;
    self.myLabel.text = @"";
}

- (IBAction)recordAction:(id)sender {
    if (!isRecording) {
        [self.myButton setTitle:@"停止" forState:(UIControlStateNormal)];
        self.myLabel.text = @"录制中";
        isRecording = YES;
        NSURL *fileURL = [self fileURL];
        [self.output startRecordingToOutputFileURL:fileURL recordingDelegate:self];
    }else {
        [self.myButton setTitle:@"录制" forState:(UIControlStateNormal)];
        self.myLabel.text = @"停止";
        [self.output stopRecording];
        isRecording = NO;
    }
}

- (NSURL *)fileURL {
    NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@",NSTemporaryDirectory(),@"movie.mov"];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
    NSFileManager *manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:outputPath]) {
        [manager removeItemAtPath:outputPath error:nil];
    }
    return outputURL;
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error {
    if (error == nil) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"写入错误");
            }
        }];
    }
}

@end
