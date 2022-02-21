//
//  DrawBezierView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "DrawBezierView.h"

@implementation DrawBezierView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
    //二阶贝塞尔
    CGContextMoveToPoint(context, 100, 200);
//    CGContextAddCurveToPoint(context, 100, 200, 250, 200, 50, 40);
    CGContextAddQuadCurveToPoint(context, 50, 40, 250, 200);
    */
    
    //三阶贝塞尔曲线
//    CGContextMoveToPoint(context, 50, 550);
//    CGContextAddCurveToPoint(context, 150, 450, 250, 600, 300, 550);

    
    //绘制圆弧
    //设置路径
    /*
     CGContextRef c:上下文
     CGFloat x ：x，y圆弧所在圆的中心点坐标
     CGFloat y ：x，y圆弧所在圆的中心点坐标
     CGFloat radius ：所在圆的半径
     CGFloat startAngle ： 圆弧的开始的角度  单位是弧度  0对应的是最右侧的点；
     CGFloat endAngle  ： 圆弧的结束角度
     int clockwise ： 顺时针（0） 或者 逆时针(1)
     */
    CGContextAddArc(context, 100, 100, 100, 45. * M_PI/180, - M_PI_2, 0);
    
    
    
    CGContextStrokePath(context);
    
    
    
}

@end
