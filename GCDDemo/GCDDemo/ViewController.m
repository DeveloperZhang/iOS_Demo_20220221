//
//  ViewController.m
//  GCDDemo
//
//  Created by Vicent on 2022/3/27.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self syncSerial];

}

- (void)groupAsync {
    dispatch_queue_t concurrent = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"0---%@",[NSThread currentThread]);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, concurrent, ^{
        NSLog(@"执行完毕---%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"函数结束---%@",[NSThread currentThread]);
}

- (void)barrierAsync {
    dispatch_queue_t concurrent = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"0---%@",[NSThread currentThread]);
    NSLog(@"追加任务1");
    dispatch_async(concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"追加barrier_async任务");
    dispatch_barrier_async(concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"barrier---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"追加任务2");
    dispatch_async(concurrent, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"函数结束---%@",[NSThread currentThread]);
}

- (void)asyncConcurrent {
    dispatch_queue_t global_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"%@-1",[NSThread currentThread]);
    dispatch_async(global_queue, ^{
        NSLog(@"%@-2",[NSThread currentThread]);
    });
    NSLog(@"%@-3",[NSThread currentThread]);
}

- (void)asyncSerial {
    NSLog(@"%@-1",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@-2",[NSThread currentThread]);
    });
    NSLog(@"%@-3",[NSThread currentThread]);
}

- (void)syncConcurrent {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"%@-1",[NSThread currentThread]);
    dispatch_sync(globalQueue, ^{
        NSLog(@"%@-2",[NSThread currentThread]);
        dispatch_sync(globalQueue, ^{
            NSLog(@"%@-3",[NSThread currentThread]);
        });
        NSLog(@"%@-4",[NSThread currentThread]);
    });
    NSLog(@"%@-5",[NSThread currentThread]);
}

- (void)syncSerial {
    dispatch_queue_t serial = dispatch_queue_create("SERIAL", DISPATCH_QUEUE_SERIAL);
    NSLog(@"%@-1",[NSThread currentThread]);
    dispatch_sync(serial, ^{
        NSLog(@"%@-2",[NSThread currentThread]);
    });
    NSLog(@"%@-3",[NSThread currentThread]);
}

@end
