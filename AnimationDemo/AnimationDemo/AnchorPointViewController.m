//
//  AnchorPointViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/18.
//

#import "AnchorPointViewController.h"

@interface AnchorPointViewController ()

@end

@implementation AnchorPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    view.frame = CGRectMake(100, 100, 100, 100);
    
//    UIView *view1 = [UIView new];
//    view1.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:view1];
//    view1.bounds = CGRectMake(0, 0, 100, 100);
    
    
//    UIView *view2 = [UIView new];
//    view2.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:view2];
//    view2.bounds = CGRectMake(100, 100, 100, 100);
    
    
    //bounds&frame
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 250)];
//    [view1 setBounds:CGRectMake(-20, -20, 280, 250)];
//    view1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view1];//添加到self.view
//    NSLog(@"view1 frame:%@========view1 bounds:%@",NSStringFromCGRect(view1.frame),NSStringFromCGRect(view1.bounds));
//
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view2.backgroundColor = [UIColor yellowColor];
//    [view1 addSubview:view2];//添加到view1上,[此时view1坐标系左上角起点为(-20,-20)]
//    NSLog(@"view2 frame:%@========view2 bounds:%@",NSStringFromCGRect(view2.frame),NSStringFromCGRect(view2.bounds));
    
    
    //anchorPoint & position
//    UIView *view1 = [UIView new];
//    view1.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:view1];
//    view1.bounds = CGRectMake(0, 0, 100, 100);
//    view1.layer.anchorPoint = CGPointMake(1, 1);
//    view1.layer.position = CGPointMake(100, 100);
//
//    UIView *view2 = [UIView new];
//    view2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view2];
//    view2.bounds = CGRectMake(0, 0, 100, 100);
//    view2.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    view2.layer.position = CGPointMake(100, 100);
//
//    UIView *view3 = [UIView new];
//    view3.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view3];
//    view3.bounds = CGRectMake(0, 0, 100, 100);
//    view3.layer.anchorPoint = CGPointMake(0, 0);
//    view3.layer.position = CGPointMake(100, 100);
    
    [self anchorPointTest];
}


- (void)anchorPointTest {
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    view2.bounds = CGRectMake(0, 0, 100, 100);
    view2.layer.position = CGPointMake(100, 200);
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor blackColor];
    view1.frame = CGRectMake(0, 0, 4, 4);
    [view2 addSubview:view1];
    
    
    
//    view2.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    view2.layer.anchorPoint = CGPointMake(0, 0);
    view2.layer.anchorPoint = CGPointMake(1, 1);
    [UIView animateWithDuration:3.0 animations:^{
        view2.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
