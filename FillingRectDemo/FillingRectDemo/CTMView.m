//
//  CTMView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "CTMView.h"

@implementation CTMView

- (void)drawRect:(CGRect)rect {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    CGImageRef image = img.CGImage;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //平移
//    CGContextTranslateCTM(context, 100, 50);
    //缩放
//    CGContextScaleCTM(context, .5, .75);
    //旋转
    CGContextRotateCTM(context, -45. * M_PI / 180);
    
    CGRect touchRect = CGRectMake(0, 0, 100, img.size.height * 100 / img.size.width);
    CGContextDrawImage(context, touchRect, image);
}

@end
