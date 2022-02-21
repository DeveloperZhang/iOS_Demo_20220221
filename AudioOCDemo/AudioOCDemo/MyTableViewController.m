//
//  MyTableViewController.m
//  AudioOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "MyTableViewController.h"
#import "RecordAudioViewController.h"

@interface MyTableViewController ()

@property (nonatomic, strong) NSArray *dataSourceArray;


@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

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
            RecordAudioViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RecordAudioViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }            
        default:
            break;
    }
}

- (NSArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = @[@"录音"];
    }
    return _dataSourceArray;
}

@end
