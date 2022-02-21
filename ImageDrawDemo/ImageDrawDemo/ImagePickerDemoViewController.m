//
//  ImagePickerDemoViewController.m
//  ImageDrawDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "ImagePickerDemoViewController.h"

@interface ImagePickerDemoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ImagePickerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pickPhotoLibrary:(id)sender {
    if (self.imagePickerController == nil) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
    }
    self.imagePickerController.delegate = self;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)pickPhotoCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }else {
        NSLog(@"❤️当前设备不支持相机!");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.imagePickerController.delegate = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = originalImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imagePickerController.delegate = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
