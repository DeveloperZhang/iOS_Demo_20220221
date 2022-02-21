//
//  ViewController.m
//  ImageDrawDemo
//
//  Created by Vicent on 2022/2/12.
//

#import "ViewController.h"

#define FILE_NAME @"flower.png"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatEditableCopyOfDatabaseIfNeeded];
}


- (void)creatEditableCopyOfDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writablePath = [self applicationDocumentDirectoryFile];
    BOOL dbexites = [fileManager fileExistsAtPath:writablePath];
    if (!dbexites) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:FILE_NAME];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writablePath error:&error];
        if (!success) {
            NSAssert(0, @"错误写入文件: %@", [error localizedDescription]);
        }
    }
}

- (NSString *)applicationDocumentDirectoryFile {
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentDirectory stringByAppendingPathComponent:FILE_NAME];
    return path;
}

- (IBAction)loadBundle:(id)sender {
    //1.
//    self.myImageView.image = [UIImage imageNamed:@"sky.png"];
    //2.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sky" ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    self.myImageView.image = image;
}

- (IBAction)loadSandBox:(id)sender {
    NSString *path = [self applicationDocumentDirectoryFile];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.myImageView.image = image;
}

- (IBAction)loadWebService:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fm00%2Fe7%2Ff5%2F4be82635b9cf81ffdc1dd0e0f0204b51.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647240605&t=0902da7f5f5075c4444c0c0475500074"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.myImageView.image = image;
}


@end
