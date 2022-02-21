//
//  ViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH 50

@interface ViewController () {
    int flag;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
    self.imageView.frame = CGRectMake((SCREEN_WIDTH - WIDTH)/2, 100, WIDTH, WIDTH);
}

- (IBAction)click:(id)sender {
    NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
//    [UIView animateWithDuration:1.5 animations:^{
//        CGRect frame = self.imageView.frame;
//        frame.origin.y += 100 * self->flag;
//        self->flag *= -1;
//        self.imageView.frame = frame;
//        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
//    } completion:^(BOOL finished) {
//        NSLog(@"动画结束了");
//        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
//    }];
    
    /*
     [UIView animateWithDuration:(NSTimeInterval)//动画持续时间
                       delay:(NSTimeInterval)//动画延迟执行的时间
      usingSpringWithDamping:(CGFloat)//震动效果，范围0~1，数值越大震动效果越明显
       initialSpringVelocity:(CGFloat)//初始速度，数值越大初始速度越快
                     options:(UIViewAnimationOptions)//动画的过渡效果
                  animations:^{
                     //执行的动画
     }
                      completion:^(BOOL finished) {
                     //动画执行提交后的操作
     }];
     */
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect frame = self.imageView.frame;
        frame.origin.y += 100 * self->flag;
        self->flag *= -1;
        self.imageView.frame = frame;
        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
    } completion:^(BOOL finished) {
        NSLog(@"动画结束了");
        NSLog(@"imageView的frame为%@",NSStringFromCGRect(self.imageView.frame));
    }];
}

@end
