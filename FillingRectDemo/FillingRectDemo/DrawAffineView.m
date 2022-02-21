//
//  DrawAffineView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/11.
//

#import "DrawAffineView.h"

@implementation DrawAffineView

- (void)drawRect:(CGRect)rect {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    CGImageRef image = img.CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform myAffine = CGAffineTransformMakeTranslation(0, img.size.height * 200 / img.size.width);
    myAffine = CGAffineTransformScale(myAffine, 1, -1);
    CGContextConcatCTM(context, myAffine);
    
    CGRect touchRect = CGRectMake(0, 0, 200, img.size.height * 200 / img.size.width);
    CGContextDrawImage(context, touchRect, image);

}

@end
