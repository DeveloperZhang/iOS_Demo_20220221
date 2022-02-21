//
//  DrawView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "DrawView.h"

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 75, 10);
    CGContextAddLineToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 160, 150);
    
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
