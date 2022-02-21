//
//  SaveRestoreStateView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "SaveRestoreStateView.h"

@implementation SaveRestoreStateView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 75, 10);
    CGContextAddLineToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 160, 150);
    
    CGContextClosePath(context);
    
    [[UIColor blackColor] setStroke];
    [[UIColor greenColor] setFill];
    
    CGContextSaveGState(context);
    
    [[UIColor redColor] setFill];
    
    CGContextRestoreGState(context);
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
}

@end
