//
//  MVPPresenter.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import "MVPPresenter.h"
#import "Student.h"

@interface MVPPresenter ()

@property (nonatomic, strong) NSObject *model;


@end

@implementation MVPPresenter

- (instancetype)initWithViewDelegate:(id<MVPUIViewDelegate>)viewDelegate obj:(NSObject *)obj {
    if (self = [super init]) {
        self.viewDelegate = viewDelegate;
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
        //2.0秒后追加任务代码到主队列，并开始执行
        [self.viewDelegate configWithData:stu.name age:stu.age];
        if (successCallBack) {
            successCallBack(true);
        }
    });
}

@end
