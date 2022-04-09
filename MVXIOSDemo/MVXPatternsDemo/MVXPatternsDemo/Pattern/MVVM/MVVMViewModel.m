//
//  MVVMViewModel.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/5.
//

#import "MVVMViewModel.h"
#import "Student.h"

@interface MVVMViewModel ()

@property (nonatomic, strong) NSObject *model;

@end

@implementation MVVMViewModel

- (instancetype)initWithObj:(NSObject *)obj {
    if (self = [super init]) {
        self.model = obj;
    }
    return self;
}

- (void)fetchObj:(nonnull SuccessCallBack)successCallBack { 
    Student *stu = [Student new];
    if ([self.model isKindOfClass:[Student class]]) {
        stu = (Student *)self.model;
    }
    //模拟数据请求操作
    stu.name = @"张三";
    stu.age = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.nameLabelStr = stu.name;
        self.ageLabelStr = [NSString stringWithFormat:@"%ld",stu.age];
        //2.0秒后追加任务代码到主队列，并开始执行
        if (successCallBack) {
            successCallBack(true);
        }
    });
}

- (void)setAgeLabelStr:(NSString *)ageLabelStr {
    _ageLabelStr = ageLabelStr;
    NSLog(@"年龄变化:%@",ageLabelStr);
}

@end
