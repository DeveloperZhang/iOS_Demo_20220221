//
//  ViewController.m
//  OCBridgeSwift
//
//  Created by Vicent on 2022/4/12.
//

#import "ViewController.h"
#import "OCBridgeSwift-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TestSwit *ts = [TestSwit new];
    [ts test];
}


@end
