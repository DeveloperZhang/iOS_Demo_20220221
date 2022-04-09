//
//  ViewController.m
//  KeyPointOCDemo
//
//  Created by Vicent on 2022/2/22.
//

#import "ViewController.h"
#import "BlockDemoViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *vcArray;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"BlockDemo"];
    self.vcArray = @[[BlockDemoViewController new]];
}

#pragma tableView--delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = self.vcArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
