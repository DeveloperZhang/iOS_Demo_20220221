//
//  ViewController.m
//  RACDemo
//
//  Created by Vicent on 2022/4/5.
//

#import "ViewController.h"
#import "ReactiveObjC/ReactiveObjC.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (nonatomic, strong) NSString *name;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test9];
}

//自定义RAC
- (void)test9 {
    //1 信号被创建
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //3 信号被激活,开始发送事件
        [subscriber sendNext:@"😄"];
//        [subscriber sendError:[NSError errorWithDomain:@"www.vicent.com" code:202 userInfo:nil]];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            //6 订阅流程结束,可以清理资源
            NSLog(@"信号被销毁");
            
        }];
    }];
    //2 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        //4 接收next事件
        NSLog(@"当前线程:%@",[NSThread currentThread]);
        NSLog(@"接收到next类型事件:%@",x);
    } error:^(NSError * _Nullable error) {
        //5 接收error类型事件
        NSLog(@"接收到error事件:%@",error);
    } completed:^{
        //5 接收completed类型事件
        NSLog(@"接收到completed事件");
    }];
}

//Delegate
- (void)test8 {
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"textFieldShouldEndEditing 回调");
    }];
    self.myTextField.delegate = self;

}


- (IBAction)changeValueAction:(id)sender {
    self.name = @"新的名称";
}

//KVO
- (void)test7 {
//    [RACObserve(self, name) subscribeNext:^(id x) {
//
//        // 属性值变化回调
//
//    }];
    [RACObserve(self, name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"name值变化为:%@",x);
    }];
}

//Block
- (void)test6 {
//      [[self asyncDataRequest] subscribeNext:^(id x) {
//
//            // 请求成功回调
//
//        } error:^(NSError *error) {
//
//            // 请求错误回调
//
//        }];
    
    
}

//Notification
- (void)test5 {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘弹出事件");
    }];

}


//T-A
- (void)test4 {
    [[self.myButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"Button被点击");
    }];

}

//数组遍历---开辟子线程操作
- (void)test1 {
    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"当前线程为:%@",[NSThread currentThread]);
        NSLog(@"数组内容为:%@",x);
    }];

}
//构造新数组--主线程操作
- (void)test2 {
    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6"];
        /*
         NSArray * newArray = [[array.rac_sequence mapReplace:@"99"] array];
         NSLog(@"%@",newArray);
         */
    NSArray * newArray = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"当前线程为:%@",[NSThread currentThread]);
        NSLog(@"原数组内容%@",value);
        return @"99";
    }] array];
    NSLog(@"原数组为:%@",array);
    NSLog(@"新数组为:%@",newArray);
}
//字典遍历--子线程操作
- (void)test3 {
    NSDictionary * dic = @{@"name":@"Tom",@"age":@"20"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString * value) = x; //X为为一个元组，RACTupleUnpack能够将key和value区分开
        NSLog(@"当前线程为:%@",[NSThread currentThread]);
        NSLog(@"数组内容：%@--%@",key,value);
    }];
}





@end
