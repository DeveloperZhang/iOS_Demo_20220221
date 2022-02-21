//
//  CAAnimationGroupViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/18.
//

#import "CAAnimationGroupViewController.h"

@interface CAAnimationGroupViewController ()

@property (nonatomic, strong) UIView *redView;


@end

@implementation CAAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [UIView new];
    [self.view addSubview:view];
    view.frame = CGRectMake(100, 100, 100, 200);
    view.backgroundColor = [UIColor redColor];
    self.redView = view;
    
    
    //移动
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath =  @"position.y";
    anim.toValue = @500;

    //缩放
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath =  @"transform.scale";
    anim2.toValue = @0.5;

    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    //会执行数组当中每一个动画对象
    groupAnim.animations = @[anim,anim2];
    groupAnim.removedOnCompletion = NO;
    groupAnim.fillMode = kCAFillModeForwards;
    groupAnim.duration = 3;
    [self.redView.layer addAnimation:groupAnim forKey:nil];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
