//
//  FillingView.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "FillingView.h"

@implementation FillingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor brownColor] setFill];
    UIRectFill(rect);
    
    [[UIColor whiteColor] setStroke];
    CGRect frame = CGRectMake(20, 30, 100, 300);
    UIRectFrame(frame);
}

@end
