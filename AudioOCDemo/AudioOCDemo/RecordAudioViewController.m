//
//  RecordAudioViewController.m
//  AudioOCDemo
//
//  Created by Vicent on 2022/2/19.
//

#import "RecordAudioViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface RecordAudioViewController () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;



@end

@implementation RecordAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLabel.text = @"停止";
}

//获取doc目录
- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (IBAction)recordAction:(id)sender {
    if (recorder == nil) {
        NSString *filePath = [NSString stringWithFormat:@"%@/rec_audio.caf",[self documentsDirectory]];
        NSLog(@"文件路径为:%@", filePath);
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        NSError *error = nil;
        //输入音频
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:&error];
        //关闭后台的其他系统声音
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        NSMutableDictionary *settings = [NSMutableDictionary dictionary];
        //设置音频编码格式为PCM--对声音进行采样、量化过程被称为脉冲编码调制（Pulse Code Modulation），简称PCM
        [settings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        //设置音频采样频率(精度),采样精度就是每秒计算机对模拟信号进行采样的次数,44100.0(44.1khz/s)是CD,VCD,SVCD和MP3常用的采样频率
        [settings setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
        //设置声道数量 取值为1或者2
        [settings setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        //设置采样位数, 8,16,24,32, 16是默认值--采样位数可以理解为采集卡处理声音的解析度,每一个离散的脉冲信号被以一定的量化精度量化成一串二进制编码流，这串编码流的位数即为采样位数，也称为量化精度。
        [settings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        //设置音频解码是大字节序还是小字节序,字节存储以及输入(出)时候的序列,大字节是将高位字节存储在起始位置,小字节则相反
        [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        //音频解码是否为浮点数
        [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:fileUrl settings:settings error:&error];
        recorder.delegate = self;
    }
    
    if (recorder.isRecording) {
        return;;
    }
    if (player && player.isPlaying) {
        [player stop];
    }
    [recorder record];
    self.myLabel.text = @"录制中...";
}



- (IBAction)stopAction:(id)sender {
    self.myLabel.text = @"停止...";
    
    if (recorder.isRecording) {
        [recorder stop];
        recorder.delegate = nil;
        recorder = nil;
    }
    if (player.isPlaying) {
        [player stop];
    }
    
}

- (IBAction)playAction:(id)sender {
    if (recorder.isRecording) {
        [recorder stop];
        recorder.delegate = nil;
        recorder = nil;
    }
    if (player.isPlaying) {
        [player stop];
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/rec_audio.caf", [self documentsDirectory]];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    //输出音频
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    //关闭后台的其他系统声音
    [[AVAudioSession sharedInstance]  setActive:YES error:&error];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
    }else {
        [player play];
        self.myLabel.text = @"播放...";
    }
}

#pragma mark--实现AVAudioRecordDelegate协议方法
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"录制完成");
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    NSLog(@"录制发生错误%@:",[error localizedDescription]);
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder {
    NSLog(@"录制中断");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withFlags:(NSUInteger)flags {
    NSLog(@"中断返回");
}

#pragma mark--实现AVAudioPlayerDelegate协议方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"播放完成");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"播放错误");
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    NSLog(@"播放中断");
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    NSLog(@"中断返回");
}



@end
