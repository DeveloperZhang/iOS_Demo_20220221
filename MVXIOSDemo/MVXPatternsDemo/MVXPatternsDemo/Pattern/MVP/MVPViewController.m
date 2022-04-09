//
//  MVPViewController.m
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import "MVPViewController.h"
#import "MVPPresenter.h"
#import "SubView.h"
#import "MVPUIViewDelegate.h"
#import "MVPPresenterDelegate.h"
#import "MVPPresenterDelegate.h"

@interface MVPViewController ()

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (nonatomic, strong) SubView *subView;
@property (nonatomic, strong) id<MVPPresenterDelegate> presenterDelegate;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Student *student = [Student new];
    self.presenterDelegate = [[MVPPresenter alloc] initWithViewDelegate:self obj:student];
    [self configSubViews];
}

- (void)configSubViews {
    self.subView = [[SubView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 10 * 2, 150)];
    [self.view addSubview:self.subView];
}


- (void)configWithData:(NSString *)name age:(NSInteger)age {
    [self.subView configWithData:name age:age];
}

- (IBAction)clickAction:(id)sender {
    self.promptLabel.text = @"加载中...";
    [self.presenterDelegate fetchObj:^(BOOL isSuccessed) {
        self.promptLabel.text = @"加载完毕";
    }];
}

@end
