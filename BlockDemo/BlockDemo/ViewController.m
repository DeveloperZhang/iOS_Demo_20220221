//
//  ViewController.m
//  BlockDemo
//
//  Created by Vicent on 2022/4/5.
//

#import "ViewController.h"


@interface AddCalculator : NSObject

@property (nonatomic, assign) NSInteger sumresult;
- (AddCalculator * (^)(NSInteger sumresult))add;

@end

@implementation AddCalculator

- (AddCalculator * (^)(NSInteger sumresult))add
{
    return ^(NSInteger sumresult) {
      
        self.sumresult += sumresult;
        
        return self;
    };
}

@end

@interface Person : NSObject

// 函数链式编程
@property (nonatomic, assign) NSInteger result;
- (Person *)makecalculator:(void (^)(AddCalculator *addcalculator))block;

@end

@implementation Person

- (Person *)makecalculator:(void (^)(AddCalculator *addcalculator))block
{
    AddCalculator *add = [[AddCalculator alloc] init];
    if (block) {
        block(add);
    }
    
    self.result = add.sumresult;
    return self;
}

@end

@interface ViewController ()

@property (nonatomic, assign) int count;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self allocMethod];
//
//    [self paramMethod:^int(int num) {
//        return num * 3;
//    }];
//    [self paramMethod1:^int(int num) {
//        return num * 4;
//    }];
    
//    int(^returnBlock)(int num) = [self returnMethod1:3];
//    int result = returnBlock(4);
//    NSLog(@"result is:%d",result);
//
//    self.returnMethod(1).returnMethod(2);
    
    
    Person *person = [[Person alloc] init];
    [person makecalculator:^(AddCalculator *addcalculator) {
       
        addcalculator.add(10).add(30);
    }];
    
    NSLog(@"person : %ld", person.result);

    
}

//block表达式语法
- (void)expressionMethod {
//    ^返回值类型(参数列表){表达式}
    ^int(int count) {
        return count + 1;
    };
}

//声明类型变量的语法
- (void)allocMethod {
//    返回值类型(^变量名)(参数列表) = block表达式
    
    int (^sum)(int count) = ^(int count) {
      return count + 1;
    };
    int (^sum1)(int) = ^(int count) {
      return count + 1;
    };
    int result = sum(1);
    int result1 = sum1(1);
    NSLog(@"result is:%d",result);
    NSLog(@"result1 is:%d",result1);
}

//作为函数参数的语法
- (void)paramMethod:(int(^)(int num))block {
    int result = block(3);
    NSLog(@"result is:%d",result);
}

//定义block简写
typedef int (^Sumblock)(int num);

- (void)paramMethod1:(Sumblock)block {
    int result = block(3);
    NSLog(@"result is:%d",result);
}


//作为返回值的语法,相当于get方法，不允许带参数
- (ViewController* (^)(int num))returnMethod {
    return ^(int num){
        self.count = num * 3;
        NSLog(@"self.count is:%d",self.count);
        return self;
    };
}

- (int(^)(int num))returnMethod1:(int)count {
    return ^(int num){
        int result = num * 3;
        return result;
    };
}

@end


