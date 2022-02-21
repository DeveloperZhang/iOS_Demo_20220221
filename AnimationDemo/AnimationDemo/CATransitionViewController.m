//
//  CATransitionViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/18.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickAction:(id)sender {
    NSString *dir = @"";
    if (self.myImageView.tag == 0) {
        self.myImageView.image = [UIImage imageNamed:@"head1"];
        self.myImageView.tag = 1;
        dir = @"fromLeft";
    }else {
        self.myImageView.image = [UIImage imageNamed:@"head"];
        self.myImageView.tag = 0;
        dir = @"fromRight";
    }
    //添加动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
    anim.type = @"cube";
    //设置转场的方向
    anim.subtype = dir;
    anim.duration = 0.5;
    [self.myImageView.layer addAnimation:anim forKey:nil];
}

@end
