//
//  SocketOrignDemoViewController.m
//  SocketOCDemo
//
//  Created by Vicent on 2022/2/20.
//

#import "SocketOrignDemoViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//htons : 将一个无符号短整型的主机数值转换为网络字节顺序，不同cpu 是不同的顺序 (big-endian大尾顺序 , little-endian小尾顺序)
#define SocketPort htons(8040) //端口
//inet_addr是一个计算机函数，功能是将一个点分十进制的IP转换成一个长整数型数
#define SocketIP   inet_addr("127.0.0.1") // ip

@interface SocketOrignDemoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (nonatomic, assign) int clinenId;


@end

@implementation SocketOrignDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)connectSocket:(id)sender {
    //1.创建socket AF_INET:IPV4 流式Socket（SOCK_STREAM）是一种面向连接的Socket，针对于面向连接的TCP服务应用。 当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。
    int socketID = socket(AF_INET, SOCK_STREAM, 0);
    self.clinenId = socketID;
    if (socketID == -1) {
        NSLog(@"创建socket失败");
        return;
    }
    
    /**
     sa_family_t    sin_family;     一般来说AF_INET（地址族）PF_INET（协议族）
     in_port_t    sin_port;         // 端口
     struct    in_addr sin_addr;    // ip
     */
    struct sockaddr_in socketAddr;
    socketAddr.sin_family = AF_INET;
    socketAddr.sin_port = SocketPort;
    struct in_addr socketIn_addr;
    socketIn_addr.s_addr = SocketIP;
    socketAddr.sin_addr = socketIn_addr;
    //2:连接socket
    /**
     sockfd：标识一个已连接套接口的描述字，就是我们刚刚创建的那个_clinenId。
     addr：指针，指向目的套接字的地址。
     addrlen：接收返回地址的缓冲区长度。
     返回值：成功则返回0，失败返回非0，错误码GetLastError()。
     */
    int result = connect(socketID, (const struct sockaddr *)&socketAddr, sizeof(socketAddr));
    if (result != 0) {
        NSLog(@"连接失败");
        return;
    }
    // 调用开始接受信息的方法
    // while 如果主线程会造成堵塞
    NSLog(@"连接成功");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self recvMsg];
    });
}

- (IBAction)sendMsg:(id)sender {
    //3:发送消息
    if (self.contentTextField.text.length == 0) {
        return;
    }
    const char *msg = self.contentTextField.text.UTF8String;
    /**
     sockfd：一个用于标识已连接套接口的描述字。
     buff：包含待发送数据的缓冲区。
     nbytes：缓冲区中数据的长度。
     flags：调用执行方式。
     返回值：如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR，一个中文UTF8 编码对应 3 个字节。所以上面发送了3*4字节。
     */
    ssize_t sendLen = send(self.clinenId, msg, strlen(msg), 0);
    NSLog(@"发送 %ld 字节", sendLen);
}


#pragma mark - 接受数据
- (void)recvMsg{
    //4.接收数据
    while (1) {
        uint8_t buffer[1024];
        /**
         sockfd：一个用于标识已连接套接口的描述字。
         buff：包含待发送数据的缓冲区。
         nbytes：缓冲区中数据的长度。
         flags：调用执行方式。
         返回值：如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR。
         */
        ssize_t recvLen = recv(self.clinenId, buffer, sizeof(buffer), 0);
        NSLog(@"接收到了:%ld字节", recvLen);
        if (recvLen == 0) {
            continue;;
        }
        //buffer->data->string
        NSData *data = [NSData dataWithBytes:buffer length:recvLen];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@---%@",[NSThread currentThread], str);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contentLabel.text = [NSString stringWithFormat:@"内容为:%@",str];
        });
    }
}

@end
