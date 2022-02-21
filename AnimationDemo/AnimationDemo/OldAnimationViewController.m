//
//  OldAnimationViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/14.
//

#import "OldAnimationViewController.h"

@interface OldAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation OldAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (IBAction)click:(id)sender {
    [UIView beginAnimations:@"test" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.redView cache:YES];
    [UIView commitAnimations];
}

@end
