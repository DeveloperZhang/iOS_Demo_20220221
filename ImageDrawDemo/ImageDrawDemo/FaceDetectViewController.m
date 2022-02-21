//
//  FaceDetectViewController.m
//  ImageDrawDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "FaceDetectViewController.h"

@interface FaceDetectViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *inputImageView;
@property (weak, nonatomic) IBOutlet UIImageView *outputImageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation FaceDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)detect:(id)sender {
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *imageInput = self.inputImageView.image;
    CIImage *image = [CIImage imageWithCGImage:imageInput.CGImage];
    
    ////缩小图片，默认照片的图片像素很高，需要将图片的大小缩小为我们现实的ImageView的大小，否则会出现识别五官过大的情况
    float factor = self.inputImageView.bounds.size.width/imageInput.size.width;
    image = [image imageByApplyingTransform:CGAffineTransformMakeScale(factor, factor)];
    
    //设置识别参数
    NSDictionary *param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyLow forKey:CIDetectorAccuracy];
    //声明一个CIDetector,并设定识别类型
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    //取得识别结果
    NSArray *detectResult = [faceDetector featuresInImage:image];
    
    UIView *resultView = [[UIView alloc] initWithFrame:self.inputImageView.frame];
    [self.view addSubview:resultView];
    
    for (CIFaceFeature *faceFeature in detectResult) {
        //脸部
        UIView *faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [UIColor orangeColor].CGColor;
        [resultView addSubview:faceView];
        
        //左眼
        if (faceFeature.hasLeftEyePosition) {
            UIView *leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            leftEyeView.layer.borderWidth = 1;
            leftEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:leftEyeView];
        }
        
        //右眼
        if (faceFeature.hasRightEyePosition) {
            UIView *rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [rightEyeView setCenter:faceFeature.rightEyePosition];
            rightEyeView.layer.borderWidth = 1;
            rightEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:rightEyeView];
        }
        
        //嘴巴
        if (faceFeature.hasMouthPosition) {
            UIView *mouthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
            [mouthView setCenter:faceFeature.mouthPosition];
            mouthView.layer.borderWidth = 1;
            mouthView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:mouthView];
        }
    }
    
    [resultView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    if ([detectResult count] > 0) {
        CIImage *faceImage = [image imageByCroppingToRect:((CIFaceFeature *)[detectResult objectAtIndex:0]).bounds];
        UIImage *face = [UIImage imageWithCGImage:[context createCGImage:faceImage fromRect:faceImage.extent]];
        self.outputImageView.image = face;
        [self.button setTitle:[NSString stringWithFormat:@"识别 人脸数%lu", (unsigned long)[detectResult count]] forState:UIControlStateNormal];
    }
    
    NSLog(@"");
}


@end
