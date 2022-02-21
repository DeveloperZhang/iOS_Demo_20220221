//
//  MediaPlayerViewController.m
//  MovieOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerView;

@end

@implementation MediaPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"enter MediaPlayerViewController");
}


- (IBAction)useMPMoviePlayerControllerAction:(id)sender {
    if (_moviePlayer == nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished4MoviePlayerController:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClick:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self movieURL]];
        //保持宽高比,适应屏幕
        _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        //全屏播放
        _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//        _moviePlayer.view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.view addSubview:_moviePlayer.view];
    }
    [_moviePlayer play];
    [_moviePlayer setFullscreen:YES animated:YES];
}

- (IBAction)useMPMoviePlayerViewControllerAction:(id)sender {
    if (_moviePlayerView == nil) {
        _moviePlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:[self movieURL]];
        _moviePlayerView.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        _moviePlayerView.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished4MoviePlayerViewController:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        [self presentMoviePlayerViewControllerAnimated:_moviePlayerView];
    }
    
}

- (void)playbackFinished4MoviePlayerViewController:(NSNotification *)notification {
    NSLog(@"播放完成");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_moviePlayerView dismissMoviePlayerViewControllerAnimated];
    _moviePlayerView = nil;
}

- (void)playbackFinished4MoviePlayerController:(NSNotification *)notification {
    NSLog(@"使用MPMoviePlayerController播放完成");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_moviePlayer stop];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
}


- (void)doneButtonClick:(NSNotification *)notification {
    NSLog(@"退出全屏");
    if (_moviePlayer.playbackState == MPMoviePlaybackStateStopped) {
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
}


- (NSURL *)movieURL {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"test1" ofType:@"mov"];
    if (moviePath) {
        return [NSURL fileURLWithPath:moviePath];
    }else {
        return nil;
    }
}

@end
