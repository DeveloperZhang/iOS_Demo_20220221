//
//  DrawUIBezierPathView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/11.
//

#import "DrawUIBezierPathView.h"

#define kMargin 10
#define kWidth [UIScreen mainScreen].bounds.size.width-10*2



@implementation DrawUIBezierPathView

- (void)drawRect:(CGRect)rect {
    [[UIColor orangeColor] set];
    
    //1.绘制直线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(kMargin, kMargin)];
    [path addLineToPoint:CGPointMake(kWidth, kMargin)];
    [path stroke];
    
    //绘制三角形
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 moveToPoint:CGPointMake(kMargin, kMargin * 2)];
    [path1 addLineToPoint:CGPointMake(kWidth, kMargin * 2)];
    [path1 addLineToPoint:CGPointMake(kWidth, kMargin * 3)];
    [path1 closePath];
    [path1 stroke];
    
    //绘制矩形
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 moveToPoint:CGPointMake(kMargin, kMargin * 4)];
    [path2 addLineToPoint:CGPointMake(kWidth, kMargin * 4)];
    [path2 addLineToPoint:CGPointMake(kWidth, kMargin * 5)];
    [path2 addLineToPoint:CGPointMake(kMargin, kMargin * 5)];
    [path2 closePath];
    [path2 stroke];
    
    //填充方式绘制矩形
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRect:CGRectMake(kMargin, kMargin * 6, kWidth, kMargin * 5)];
    [path3 fill];
    [path3 stroke];
    
    //绘制圆角矩形
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kMargin, kMargin*13, kWidth, kMargin * 5) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kMargin, kMargin)];
    [path4 fillWithBlendMode:kCGBlendModeMultiply alpha:0.3];
    [path4 stroke];

    // 5. 绘制椭圆
    UIBezierPath *path5 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x - 100, kMargin * 20, 200, 50)];
    [path5 fillWithBlendMode:kCGBlendModeOverlay alpha:0.5];
    [path5 stroke];
    
    // 6. 绘制圆形
    UIBezierPath *path6 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kMargin * 5, kMargin * 26, 100, 100)];
    [path6 stroke];
        
    // 7. 绘制一段圆弧
    UIBezierPath *path7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kMargin * 23, kMargin * 31) radius:50 startAngle:270. * M_PI/180 endAngle:M_PI clockwise:YES];
    [path7 stroke];
    
    // 8.绘制扇形
    UIBezierPath *path8 = [UIBezierPath bezierPath];
    [path8 moveToPoint:CGPointMake(100, kMargin * 45)];
    [path8 addArcWithCenter:CGPointMake(100, kMargin*45) radius:50 startAngle:0 endAngle:M_PI/2 clockwise:NO];
    [path8 closePath];
    [path8 stroke];
    
    // 9. 绘制竖直虚线
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    //{长度,间隙}
    CGFloat dash[] = {3.0, 3.0};
    [verticalLinePath setLineDash:dash count:2 phase:0.0];
    [verticalLinePath moveToPoint: CGPointMake(5, 0)];
    [verticalLinePath addLineToPoint: CGPointMake(5, [UIScreen mainScreen].bounds.size.height*2)];
    [verticalLinePath stroke];
    
    
    // 10.绘制二次贝塞尔曲线
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(200, 450)];
    [path9 addQuadCurveToPoint:CGPointMake(310, 450) controlPoint:CGPointMake(280, 550)];
    [path9 stroke];
    
    // 11.绘制三次贝塞尔曲线
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(50, 550)];
    [path10 addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(150, 450) controlPoint2:CGPointMake(250, 600)];
    [path10 stroke];
    
}

@end
