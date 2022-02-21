//
//  ViewController.m
//  SocketOCDemo
//
//  Created by Vicent on 2022/2/20.
//

#import "ViewController.h"
#import "SocketOrignDemoViewController.h"
#import "CocoaAsyncSocketDemoViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = @[@"SocketOrignDemo", @"CocoaAsyncSocketDemo"];
}

#pragma tableView--delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            SocketOrignDemoViewController *vc = [[SocketOrignDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        //CocoaAsyncSocketDemoViewController
        case 1: {
            CocoaAsyncSocketDemoViewController *vc = [[CocoaAsyncSocketDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
