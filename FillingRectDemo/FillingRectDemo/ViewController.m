//
//  ViewController.m
//  FillingRectDemo
//
//  Created by Vicent on 2022/2/10.
//

#import "ViewController.h"
#import "DrawAnnulusView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DrawAnnulusView *gradeView = [[DrawAnnulusView alloc] init];
    gradeView.grade = 0.8;
    [gradeView setNeedsDisplay];
    gradeView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:gradeView];
}


@end
