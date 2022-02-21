//
//  CocoaAsyncSocketDemoViewController.m
//  SocketOCDemo
//
//  Created by Vicent on 2022/2/20.
//

#import "CocoaAsyncSocketDemoViewController.h"
#import "GCDAsyncSocket.h"

#define SocketPort 8040 //端口
//inet_addr是一个计算机函数，功能是将一个点分十进制的IP转换成一个长整数型数
#define SocketIP @"192.168.100.2" // ip
//#define SocketIP @"127.0.0.1" // ip

@interface CocoaAsyncSocketDemoViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isClientSwitch;
@property (weak, nonatomic) IBOutlet UILabel *clientLabel;

/* 存储所有连接的客户端 socket*/
@property(nonatomic, strong) NSMutableArray *arrayClient;

@property(nonatomic, strong) NSTimer *heartbeatTimer;

// 子线程用于监听心跳包
@property(nonatomic, strong) NSThread *checkThread;
// 记录每个心跳缓存
@property (nonatomic, strong) NSMutableDictionary *heartbeatDateDict;

/**
 数据缓冲区
 */
@property (nonatomic, strong) NSMutableData *dataBuffer;

@end

@implementation CocoaAsyncSocketDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)connectAction:(id)sender {
    if (self.isClientSwitch.isOn == YES) { //客户端状态
        ////异步！
        NSError *err = nil;
        if (![self.clientSocket connectToHost:SocketIP onPort: SocketPort error:&err]) {
            //  如果有错误，很可能是"已经连接"或"没有委托集"
            NSLog(@"I goofed: %@", err);
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"连接失败" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }else {
            NSLog(@"连接成功");
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"连接成功" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }else {
        //  开放服务端的指定端口.
        NSError *error = nil;
        BOOL result = [self.serverSocket acceptOnPort:SocketPort error:&error];
        if (result) {
           NSLog(@"端口开启成功,并监听客户端请求连接...");
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"端口开启成功,并监听客户端请求连接..." preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }else {
           NSLog(@"端口开启失败...");
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"端口开启失败" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }

}

- (IBAction)sendMsgAction:(id)sender {
    NSData *data = [self.contentTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    if (self.isClientSwitch.isOn == YES) { //客户端状态
        NSLog(@"客户端发送内容为:%@",self.contentTextField.text);
        // -1表示超时时间无限大
        // tag:消息标记
        [self.clientSocket writeData:data withTimeout:-1 tag:0];
    }else {
        //error: 服务端不能主动发送数据给客户端,只能在接受数据后回复
//        NSLog(@"服务端发送内容为:%@",self.contentTextField.text);
//        NSData *respData = [@"固定的内容" dataUsingEncoding:NSUTF8StringEncoding];
//        [self.serverSocket writeData:respData withTimeout:-1 tag:0];
    }

}

- (IBAction)changeToClientAction:(id)sender {
    if (self.isClientSwitch.isOn == YES) {//客户端
        self.clientLabel.text = @"设置为客户端";
    }else {
        self.clientLabel.text = @"设置为服务端";
    }

}

// 客户端Socket连接成功会执行该方法
- (void)socket:(GCDAsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port{
    NSLog(@"--连接成功--");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"连接成功" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    [sock readDataWithTimeout:-1 tag:0];
    [self beginSendHeartbeat];
}

// 收到对应的Socket发送的数据会执行该方法
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    if (self.isClientSwitch.isOn == YES) { //客户端状态
        NSString *serverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"服务端回包了--回包内容--%@---长度%lu",serverStr,(unsigned long)data.length);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"接收到的服务器内容" message:serverStr preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            self.contentLabel.text = [NSString stringWithFormat:@"内容为:%@",serverStr];
        });
        [sock readDataWithTimeout:-1 tag:0];
    }else {
        [self handleData:data socket:sock];
        [sock readDataWithTimeout:-1 tag:0];
    }

}

- (void)handleData:(NSData *)data socket:(GCDAsyncSocket* ) sock{
    //  记录客户端心跳
    char heartbeat[4] = {0xab,0xcd,0x00,0x00}; // 心跳字节，和服务器协商
    NSData *heartbeatData = [NSData dataWithBytes:&heartbeat length:sizeof(heartbeat)];
    if ([data isEqualToData:heartbeatData]) {
        NSLog(@"*************心跳**************");
        self.heartbeatDateDict[sock.connectedHost] = [NSDate date];
    }else{
        NSString *clientStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"客户端内容--%@---长度%lu",clientStr,(unsigned long)data.length);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"接收到的客户端内容" message:clientStr preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK Action");
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            self.contentLabel.text = [NSString stringWithFormat:@"内容为:%@",clientStr];
        });
        NSData *respData = [[NSString stringWithFormat:@"内容为:%@",clientStr] dataUsingEncoding:NSUTF8StringEncoding];
        [sock writeData:respData withTimeout:-1 tag:1];
    }
}

- (void)beginSendHeartbeat{
    // 创建心跳定制器
    self.heartbeatTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(sendHeartbeat:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.heartbeatTimer forMode:NSRunLoopCommonModes];
}

- (void)sendHeartbeat:(NSTimer *)timer {
    if (timer != nil) {
        char heartbeat[4] = {0xab,0xcd,0x00,0x00}; // 心跳字节，和服务器协商
        NSData *heartbeatData = [NSData dataWithBytes:&heartbeat length:sizeof(heartbeat)];
        NSLog(@"客户端发送心跳包");
        [self.clientSocket writeData:heartbeatData withTimeout:-1 tag:0];
    }
}

// 断开连接会调取该方法
- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err{
    NSLog(@"--断开连接--");
    if (self.isClientSwitch.isOn == YES) {//客户端
        //  sokect断开连接时,需要清空代理和客户端本身的socket.
        self.clientSocket.delegate = nil;
        self.clientSocket = nil;
    }
}

//  监听到新的客户端socket连接，会执行该方法
- (void)socket:(GCDAsyncSocket *)serveSock didAcceptNewSocket:(GCDAsyncSocket *) newSocket{
    NSLog(@"%@ IP: %@: %hu 客户端请求连接...",newSocket,newSocket.connectedHost,newSocket.localPort);
    // 将客户端socket保存起来
    if (![self.arrayClient containsObject:newSocket]) {
        [self.arrayClient addObject:newSocket];
    }
    [newSocket readDataWithTimeout:-1 tag:0];
}

#pragma checkTimeThread

//  这里设置10检查一次 数组里所有的客户端socket 最后一次通讯时间,这样的话会有周期差（最多差10s），可以设置为1s检查一次，这样频率快
//  开启线程 启动runloop 循环检测客户端socket最新time
- (void)checkClientOnline{
    @autoreleasepool {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(repeatCheckClinetOnline) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];
    }
}

//  移除 超过心跳时差的 client
- (void)repeatCheckClinetOnline{
    if (self.arrayClient.count == 0) {
        return;
    }
    NSDate *date = [NSDate date];
    for (GCDAsyncSocket *socket in self.arrayClient ) {
        if ([date timeIntervalSinceDate:self.heartbeatDateDict[socket.connectedHost]]>10) {
            [self.arrayClient removeObject:socket];
        }
    }
}

- (IBAction)configSocketAction:(id)sender {
    if (self.isClientSwitch.isOn == YES) { //客户端状态
        //需要delegate和delegate_queue才能使GCDAsyncSocket调用您的委托方法。提供delegateQueue是一个新概念。delegateQueue要求必须是一个串行队列，使得委托方法在delegateQueue队列中执行。
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }else {
        self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        // 初始化子线程，并启动
        self.checkThread = [[NSThread alloc] initWithTarget:self selector:@selector(checkClientOnline) object:nil];
        [self.checkThread start];
    }
}

- (NSMutableData *)dataBuffer{
    if (!_dataBuffer) {
        _dataBuffer = [NSMutableData data];
    }
    return _dataBuffer;
}

- (NSMutableDictionary *)heartbeatDateDict{
    if (!_heartbeatDateDict) {
        _heartbeatDateDict = [NSMutableDictionary dictionary];
    }
    return _heartbeatDateDict;
}

- (NSMutableArray *)arrayClient{
    if (!_arrayClient) {
        _arrayClient = [NSMutableArray array];
    }
    return _arrayClient;
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    if (self.isClientSwitch.isOn == YES) {
        NSLog(@"客户端tag%ld",tag);
    }else {
        NSLog(@"服务端tag%ld",tag);
    }
}

- (IBAction)hideKeyBoardAction:(id)sender {
    [self.contentTextField resignFirstResponder];
}

@end
