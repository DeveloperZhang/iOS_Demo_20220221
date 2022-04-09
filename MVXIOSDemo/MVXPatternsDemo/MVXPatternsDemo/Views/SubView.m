//
//  SubView.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import "SubView.h"

@interface SubView ()

@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation SubView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //在这添加所有子控件但不设置子控件的frame或约束
        self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20 * 2)];
        [self addSubview:self.showLabel];
    }
    return self;
}

- (void)configWithData:(NSString *)name age:(NSInteger)age {
    self.showLabel.text = [NSString stringWithFormat:@"学生姓名:%@,年龄:%ld岁",name,age];
}

@end
