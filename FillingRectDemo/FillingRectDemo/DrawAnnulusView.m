#import "DrawAnnulusView.h"

@implementation DrawAnnulusView

//计算度转弧度
static inline float radians(double degrees) {
    return degrees * M_PI / 180;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.grade = 0.8;
    
    CGFloat borderWidth = 20;
    CGFloat radius = self.bounds.size.height / 2;
    CGFloat grade = self.grade ? self.grade : 1;
    grade = grade > 0 ? grade : 0;
    UIColor *bgColor = [UIColor whiteColor];
    UIColor *tintColor = [UIColor blueColor];
    UIColor *onTintColor = [UIColor greenColor];
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

    //填充当区域内的颜色与父视图相同
    [bgColor set];
    CGContextFillRect(context, rect);
    CGContextFillPath(context);

    //绘制两个扇形
    float angle_start = radians(0.0);
    float angle_end = radians(360 * grade);
    CGContextMoveToPoint(context, center.x, center.y);
    [onTintColor setFill];
    CGContextAddArc(context, center.x, center.y, radius, angle_start, angle_end, 0);
    CGContextFillPath(context);

    angle_start = angle_end;
    angle_end = radians(360.0);
    CGContextMoveToPoint(context, center.x, center.y);
//    CGContextSetFillColor(context, CGColorGetComponents(tintColor.CGColor));
    [tintColor setFill];
    CGContextAddArc(context, center.x, center.y, radius, angle_start, angle_end, 0);
    CGContextFillPath(context);

    //绘制圆颜色与父视图相同
    CGFloat w = (self.bounds.size.width)/ 2 - borderWidth;
    CGContextAddEllipseInRect(context, CGRectMake(center.x - w, center.y - w, w * 2, w * 2));
    [bgColor set];
    CGContextFillPath(context);//实心的
    CGContextStrokePath(context);//空心的

    //调整方向
    self.layer.transform = CATransform3DMakeRotation(M_PI * -0.5, 0, 0, 1);
    self.layer.shadowRadius = radius;
    self.layer.masksToBounds = YES;
}

@end

