//
//  FilterEffectsViewController.m
//  ImageDrawDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "FilterEffectsViewController.h"

@interface FilterEffectsViewController () {
    int flag; //0为CISepiaTone 1为CIGaussianBlur
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, strong) UIImage *image;


@end

@implementation FilterEffectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image = [UIImage imageNamed:@"sky.png"];
    [self filterSepiaTone];
}

- (void)filterSepiaTone {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *cImage = [CIImage imageWithCGImage:[self.image CGImage]];
    CIImage *result;
    CIFilter *sepiaTone = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaTone setValue:cImage forKey:@"inputImage"];
    double value = self.slider.value;
    NSString *text = [[NSString alloc] initWithFormat:@"旧色调 Intensity:%.2f", value];
    self.label.text = text;
    [sepiaTone setValue:[NSNumber numberWithFloat:value] forKey:@"inputIntensity"];
    result = [sepiaTone valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.width)];
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    self.imageView.image = image;
    flag = 0;
}

- (void)filterGaussianBlur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *cImage = [CIImage imageWithCGImage:[self.image CGImage]];
    CIImage *result;
    CIFilter *gaussianBlur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlur setValue:cImage forKey:@"inputImage"];
    double value = self.slider.value;
    value *= 10;
    NSString *text = [[NSString alloc] initWithFormat:@"高斯模糊 Radius:%.2f", value];
    self.label.text = text;
    [gaussianBlur setValue:[NSNumber numberWithFloat:value] forKey:@"inputRadius"];
    result = [gaussianBlur valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.width)];
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    self.imageView.image = image;
    flag = 1;
}


- (IBAction)segmentSelected:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    self.image = [UIImage imageNamed:@"sky.png"];
    self.imageView.image = self.image;
    if (segmentControl.selectedSegmentIndex == 0) {
        [self filterSepiaTone];
    }else {
        [self filterGaussianBlur];
    }
}

- (IBAction)changeValued:(id)sender {
    self.slider = (UISlider *)sender;
    if (flag == 0) {
        [self filterSepiaTone];
    }else {
        [self filterGaussianBlur];
    }
}



@end
