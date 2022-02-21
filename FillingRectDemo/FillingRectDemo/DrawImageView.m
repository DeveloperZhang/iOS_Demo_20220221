//
//  MyView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "DrawImageView.h"

@implementation DrawImageView

- (void)drawRect:(CGRect)rect {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
    UIImage *myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
    [myImageObj drawInRect:CGRectMake(0, 40, 320, 400)];
    
    NSString *s = @"我的小狗";
    UIFont *font = [UIFont systemFontOfSize:34.];
    NSDictionary *attr = @{NSFontAttributeName:font};
    [s drawAtPoint:CGPointMake(100, 20) withAttributes:attr];
}

@end
