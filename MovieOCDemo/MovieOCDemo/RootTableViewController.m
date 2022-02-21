//
//  RootTableViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "RootTableViewController.h"
#import "MediaPlayerViewController.h"
#import "AVFoundationViewController.h"
#import "RecordUIImagePickerDemoViewController.h"
#import "RecordAVCaptureDemoViewController.h"
#import "VideoEditDemoViewController.h"

@interface RootTableViewController ()

@property (nonatomic, strong) NSArray *sourceArray;


@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceArray = @[@"MediaPlayerDemo", @"AVFoundationPlayerDemo", @"UIImagePickerDemo", @"RecordAVCaptureDemo", @"VideoEditDemo"];
}


#pragma tableView--delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.textLabel.text = self.sourceArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            MediaPlayerViewController *vc = [[MediaPlayerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            AVFoundationViewController *vc = [[AVFoundationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            RecordUIImagePickerDemoViewController *vc = [[RecordUIImagePickerDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        //RecordAVCaptureDemoViewController
        case 3:{
            RecordAVCaptureDemoViewController *vc = [[RecordAVCaptureDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        //VideoEditDemoViewController
        case 4:{
            VideoEditDemoViewController *vc = [[VideoEditDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
