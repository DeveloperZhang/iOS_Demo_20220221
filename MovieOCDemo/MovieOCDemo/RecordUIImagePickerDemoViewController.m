//
//  UIImagePickerDemoViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "RecordUIImagePickerDemoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartZCore/QuartZCore.h>

@interface RecordUIImagePickerDemoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;


@end

@implementation RecordUIImagePickerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"123");
}

- (IBAction)videoAction:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        //高质量
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        //最多只允许录制30秒
        imagePickerController.videoMaximumDuration = 30.0f;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        self.imagePickerController = imagePickerController;
    }else {
        NSLog(@"摄像头不可用");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSString *tempFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(tempFilePath)) {
        UISaveVideoAtPathToSavedPhotosAlbum(tempFilePath, self, @selector(video:didFinishSavingWithError:contextInfo:), (__bridge  void *)tempFilePath);
        [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(NSString *)contextInfo {
    NSString *title;
    NSString *message;
    if (!error) {
        title = @"视频保存";
        message = @"视频已经保存到设备的相机胶卷中";
    }else {
        title = @"视频失败";
        message = [error description];
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"选择器将要显示");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"选择器显示结束");
}

@end
