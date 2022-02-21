//
//  VideoEditDemoViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "VideoEditDemoViewController.h"

@interface VideoEditDemoViewController ()<UIVideoEditorControllerDelegate, UINavigationControllerDelegate>

@end

@implementation VideoEditDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"test1" ofType:@"mov"];
    if ([UIVideoEditorController canEditVideoAtPath:moviePath]) {
        UIVideoEditorController *videoEditor = [[UIVideoEditorController alloc] init];
        videoEditor.delegate = self;
        videoEditor.videoPath = moviePath;
        [self presentViewController:videoEditor animated:YES completion:nil];
    }else {
        NSLog(@"不能编辑这个视频");
    }
}

- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath {
    [editor dismissViewControllerAnimated:YES completion:nil];
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(editedVideoPath)) {
        UISaveVideoAtPathToSavedPhotosAlbum(editedVideoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), (__bridge  void *)editedVideoPath);
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

- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error {
    NSLog(@"编辑视频出错");
    NSLog(@"Video editor error occurred=%@", error);
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor {
    NSLog(@"编辑视频取消");
    [editor dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)editAction:(id)sender {
}

@end
