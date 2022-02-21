//
//  CAAnimationViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/18.
//

#import "CAAnimationViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface CAAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *movedLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation CAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self animationTest];
//    [self keyAnimationTest];
//    [self keyAnimationWithPathTest];
//    [self keyAnimation2Test];
    [self drawAnimationTest];
//    [self drawProgressTest];
}

- (void)animationTest {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.movedLayer = layer;
    
    //创建动画
    CABasicAnimation *anim = [CABasicAnimation animation];;
    //    设置动画对象
    //    keyPath决定了执行怎样的动画,调用layer的哪个属性来执行动画 position:平移
    anim.keyPath = @"position";
    //    包装成对象
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    anim.duration = 2.0;
    
    //    让图层保持动画执行完毕后的状态
    //    执行完毕以后不要删除动画
    anim.removedOnCompletion = NO;
    //    保持最新的状态
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    //    添加动画
    [self.movedLayer addAnimation:anim forKey:nil];
}

- (void)keyAnimationTest {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.movedLayer = layer;
    
    //创建动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //设置动画对象 keyPath决定了执行怎样的动画,调整哪个属性来执行动画
    anim.keyPath = @"position";
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    anim.values = @[v1, v2, v3, v4];
    anim.duration = 2.0;
    //让图层保持动画执行完毕后的状态,状态执行完毕后不删除动画
    anim.removedOnCompletion = NO;
    //保持最新的状态
    anim.fillMode = kCAFillModeForwards;
    //添加动画
    [self.movedLayer addAnimation:anim forKey:nil];
}

- (void)keyAnimationWithPathTest {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.movedLayer = layer;
    
    
    //根据路径创建动画
    //创建动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 2.0;
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    //路径的范围
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    //添加路径
    anim.path = path;
    //释放路径(带Create的函数创建的对象都需要手动释放,否则会内存泄露)
    CGPathRelease(path);
    //添加到View的layer
    [self.movedLayer addAnimation:anim forKey:nil];
}

- (void)keyAnimation2Test {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rocket80"]];
    CALayer *layer = imageView.layer;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.movedLayer = layer;
    
    //旋转帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(DEGREES_TO_RADIANS(-5)), @(DEGREES_TO_RADIANS(5)), @(DEGREES_TO_RADIANS(-5))];
    anim.repeatCount = MAXFLOAT;
    [self.movedLayer addAnimation:anim forKey:nil];
}

- (void)drawAnimationTest {
    
//    UIBezierPath *bezPath = [UIBezierPath bezierPathWithRect:CGRectMake(5, 64, kScreenWidth - 10, kScreenHeight - 64 - 5)];
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.lineWidth = 10;
//    layer.path = bezPath.CGPath;
//    layer.strokeColor = [UIColor greenColor].CGColor;
//    layer.fillColor = [UIColor clearColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anim.duration = 3;
//    anim.fromValue = @0;
//    anim.toValue = @1;
//    [layer addAnimation:anim forKey:nil];
    
    //圆环
//    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(300/2, 300/2) radius:150 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(270) + DEGREES_TO_RADIANS(360) clockwise:YES];
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = CGRectMake(10, 100, 300, 300);
//    layer.lineWidth = 10;
//    layer.path = bezPath.CGPath;
//    layer.strokeColor = [UIColor greenColor].CGColor;
//    layer.fillColor = [UIColor clearColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anim.duration = 3;
//    anim.fromValue = @0;
//    anim.toValue = @1;
//    [layer addAnimation:anim forKey:nil];
    
    
    //抛物线轨迹的关键帧动画
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(10, 100, 100, 100);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    CGPathMoveToPoint(path, NULL, layer.position.x, layer.position.y);//移动到起始点
    CGPathAddQuadCurveToPoint(path, NULL, 100, 100, 200, 200);
    keyframeAnimation.path = path;
//    keyframeAnimation.delegate = self;
    CGPathRelease(path);
    keyframeAnimation.duration = 3;
    [layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
    [self.view.layer addSublayer:layer];
}


- (void)drawProgressTest {
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(300/2, 300/2) radius:150 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(270) + DEGREES_TO_RADIANS(360) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(300/2, 300/2)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(10, 100, 300, 300);
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    shapeLayer.path = bezPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
    
    _progress = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(actionSectorTimer) userInfo:nil repeats:YES];
    [_timer fire];
    
}
 
- (void)actionSectorTimer {
    _progress +=1 ;
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(300/2, 300/2) radius:150 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(270) + DEGREES_TO_RADIANS(_progress) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(300/2, 300/2)];
    _shapeLayer.path = bezPath.CGPath;
    if (_progress >= 360) {
        [_timer invalidate];
        _timer = nil;
    }
    
}


//位置没变
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"start:movedLayer的frame为%@",NSStringFromCGRect(self.movedLayer.frame));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"stop:movedLayer的frame为%@",NSStringFromCGRect(self.movedLayer.frame));
}


- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
