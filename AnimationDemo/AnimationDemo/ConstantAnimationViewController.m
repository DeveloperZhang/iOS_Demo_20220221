//
//  ConstantAnimationViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "ConstantAnimationViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH 50

@interface ConstantAnimationViewController () {
    int flag;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSLayoutConstraint *topCos;

@end

@implementation ConstantAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    flag = 1;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;

    
    self.topCos = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
    [self.view addConstraint:self.topCos];
    NSLayoutConstraint *centerCos = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:centerCos];
    NSLayoutConstraint *widthCos = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:widthCos];
    NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:heightCos];
//    self.imageView.frame = CGRectMake((SCREEN_WIDTH - WIDTH)/2, 100, WIDTH, WIDTH);
    [self.view layoutIfNeeded];
    NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
}

- (IBAction)click:(id)sender {
    NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
    [UIView animateWithDuration:1 animations:^{
        float constant = self.topCos.constant;
        [self.view removeConstraint:self.topCos];
        self.topCos = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:constant + 100 * self->flag];
        self->flag *= -1;
        [self.view addConstraint:self.topCos];
        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"动画结束了");
        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
    }];
}

@end
