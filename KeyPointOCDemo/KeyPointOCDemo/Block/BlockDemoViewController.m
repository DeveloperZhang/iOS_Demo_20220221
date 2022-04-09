//
//  BlockDemoViewController.m
//  KeyPointOCDemo
//
//  Created by Vicent on 2022/2/22.
//

#import "BlockDemoViewController.h"

//typedef方式
typedef int (^Block5)(int);

@interface BlockDemoViewController ()

@end

@implementation BlockDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"BlockDemo";
    
    /**
     Block表达式一般形式：
     {
        返回值   (^Block名字)(参数列);
        如： int (^block)(int a)
     }
     */
    //普通的Block
    int (^block)(int);
    block = ^(int a) {
        return a * a;
    };
    NSLog(@"%d", block(3));
    
    //无参数Block
    void (^block1)(void);
    block1 = ^(void){
        NSLog(@"无参数的Block");
    };
    block1();
    
    //作为入参
    int (^block2)(int);
    block2 = ^(int a) {
        return a * a * a;
    };
    [self blockMethod:block2];
    
    //作为返回参数
    int (^block4)(int);
    block4 = [self blockMethod1];
    NSLog(@"block作为返回:%d",block4(3));
    
    //typedef方式
    Block5 block5 = ^(int a) {
        return a * a;
    };
    int result5 = block5(10);
    NSLog(@"typedef方式:%d", result5);
    
}

- (void)blockMethod:(int(^)(int))blockParam {
    int result = blockParam(2);
    NSLog(@"block2作为入参:%d", result);
}

- (int(^)(int))blockMethod1 {
    return ^(int a) {
        return a * a;
    };
}


- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
