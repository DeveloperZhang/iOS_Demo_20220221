//
//  RootTableViewController.m
//  AnimationDemo
//
//  Created by Vicent on 2022/2/14.
//

#import "RootTableViewController.h"
#import "OldAnimationViewController.h"
#import "ViewController.h"
#import "ConstantAnimationViewController.h"
#import "AnchorPointViewController.h"
#import "CAAnimationViewController.h"
#import "CATransitionViewController.h"
#import "CAAnimationGroupViewController.h"
#import "CAEmitteViewController.h"

@interface RootTableViewController ()

@property (nonatomic, strong) NSArray *dataSourceArray;


@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSourceArray = @[@"OldFrameAnimation", @"BlockFrameAnimation", @"BlockConstraintAnimation", @"AnchorPoint", @"CAAnimation", @"CATransition", @"CAAnimationGroup", @"CAEmitte"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OldAnimationViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"OldAnimationViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ConstantAnimationViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ConstantAnimationViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            AnchorPointViewController *vc = [AnchorPointViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            CAAnimationViewController *vc = [CAAnimationViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CATransitionViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CATransitionViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:
        {
            CAAnimationGroupViewController *vc = [CAAnimationGroupViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        //CAEmitteViewController
        case 7:
        {
            CAEmitteViewController *vc = [CAEmitteViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
