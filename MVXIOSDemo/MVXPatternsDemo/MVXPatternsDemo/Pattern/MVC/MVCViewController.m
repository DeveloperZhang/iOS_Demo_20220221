//
//  MVCViewController.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import "MVCViewController.h"
#import "Student.h"
#import "SubView.h"

typedef void (^SuccessCallBack)(BOOL isSuccessed);

@interface MVCViewController ()

@property (nonatomic, strong) Student *student;
@property (nonatomic, strong) SubView *subView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MVC");
    self.student = [[Student alloc] init];
    [self configSubViews];
}

- (void)configSubViews {
    self.subView = [[SubView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 10 * 2, 150)];
    [self.view addSubview:self.subView];
}


- (IBAction)clickAction:(id)sender {
    self.promptLabel.text = @"加载中...";
    [self fetchStudent:^(BOOL isSuccessed) {
        self.promptLabel.text = @"MVC模式加载完毕";
        [self.subView configWithData:self.student.name age:self.student.age];
    }];
}

- (void)fetchStudent:(SuccessCallBack)successCallBack {
    //模拟数据请求操作
    self.student.name = @"张三";
    self.student.age = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //2.0秒后追加任务代码到主队列，并开始执行
        if (successCallBack) {
            successCallBack(true);
        }
    });
}

@end
