//
//  DrawImageLocationView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "DrawImageLocationView.h"

@implementation DrawImageLocationView

- (void)drawRect:(CGRect)rect {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    CGImageRef image = img.CGImage;
    CGContextRef context = UIGraphicsGetCurrentContext();

    //平移图像高度位置
    CGContextTranslateCTM(context, 0, img.size.height * 300 / img.size.width);
    //y轴对称变换
    CGContextScaleCTM(context, 1, -1);
    
    CGRect touchRect = CGRectMake(0, 0, 300, img.size.height * 300 / img.size.width);
    CGContextDrawImage(context, touchRect, image);
}

@end
