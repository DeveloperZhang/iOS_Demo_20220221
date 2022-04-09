//
//  MVVMViewController.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import "MVVMViewController.h"
#import "SubView.h"
#import "Student.h"
#import "MVVMViewModel.h"
#import "ReactiveObjC/ReactiveObjC.h"

@interface MVVMViewController ()

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (nonatomic, strong) SubView *subView;
@property (nonatomic, strong) id<MVVMViewModelDelegate> viewModelDelegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (nonatomic, strong) MVVMViewModel *viewModel;


@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Student *student = [Student new];
    self.viewModelDelegate = [[MVVMViewModel alloc] initWithObj:student];
    self.viewModel = self.viewModelDelegate;
    [self configSubViews];
    [self bindMVVMViewModel];
}

- (void)configSubViews {
    self.subView = [[SubView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 10 * 2, 150)];
    [self.view addSubview:self.subView];
}

- (void)bindMVVMViewModel {
    RACChannelTo(self.viewModel, nameLabelStr) = RACChannelTo(self.nameLabel,text);
    RACChannelTo(self.viewModel, ageLabelStr) = self.ageTextField.rac_newTextChannel;
    
    RACSignal *signalA = RACObserve(self.viewModel, nameLabelStr);
    RACSignal *signalB = RACObserve(self.viewModel, ageLabelStr);
    RACSignal *signalCombineLatest = [signalA combineLatestWith:signalB];

    [signalCombineLatest subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
        int age = 0;
        if ([x.second isKindOfClass:[NSString class]]) {
            NSString *ageStr = x.second;
            age = ageStr.intValue;
            [self.subView configWithData:x.first age:age];
        }
    }];
}

- (void)configWithData:(NSString *)name age:(NSInteger)age {
    [self.subView configWithData:name age:age];
}

- (IBAction)clickAction:(id)sender {
    self.promptLabel.text = @"加载中...";
    [self.viewModelDelegate fetchObj:^(BOOL isSuccessed) {
        self.promptLabel.text = @"加载完毕";
    }];
}

@end
