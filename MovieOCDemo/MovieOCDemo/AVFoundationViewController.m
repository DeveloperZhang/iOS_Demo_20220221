//
//  AVFoundationViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "AVFoundationViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVFoundationViewController () {
    id timeObserver;
    BOOL isPlaying;
}

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *layer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation AVFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"mov"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    // 6、设置拉伸模式
    self.layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //加到最底层
    [self.view.layer insertSublayer:self.layer atIndex:0];
    //将CMTime转化成秒
    double duration = CMTimeGetSeconds(asset.duration);
    self.slider.maximumValue = duration;
    self.slider.minimumValue = 0.0;
    isPlaying = NO;
}


- (void)addObserver {
    if (timeObserver == nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        __weak typeof(self) weakSelf = self;
        timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float duration = CMTimeGetSeconds(weakSelf.avPlayer.currentTime);
            NSLog(@"duration=%f",duration);
            weakSelf.slider.value = duration;
        }];
    }
}

- (void)playerItemDidReachEnd:(NSNotification *) notification {
    NSLog(@"播放完成");
    if (timeObserver) {
        [self.avPlayer removeTimeObserver:timeObserver];
        timeObserver = nil;
        self.slider.value = 0.0;
        isPlaying = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemPlay) target:self action:@selector(playAction:)];
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolbar items]];
        [items replaceObjectAtIndex:0 withObject:item1];
        [self.toolbar setItems:items];
    }
}

- (IBAction)playAction:(id)sender {
    UIBarButtonItem *item1;
    if (!isPlaying) {
        [self addObserver];
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.avPlayer play];
        isPlaying = YES;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playAction:)];
    }else {
        isPlaying = NO;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playAction:)];
        [self.avPlayer pause];
    }
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolbar items]];
    [items replaceObjectAtIndex:0 withObject:item1];
    [self.toolbar setItems:items];
}

- (IBAction)seekAction:(id)sender {
    float value = [self.slider value];
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(value, 10)];
}

@end
