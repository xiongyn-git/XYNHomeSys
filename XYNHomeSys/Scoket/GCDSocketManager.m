//
//  TYHSocketManager.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/7.
//

#import "GCDSocketManager.h"
#import "GCDAsyncSocket.h" // for TCP
static  NSString * Khost = @"127.0.0.1";
static const uint16_t Kport = 6969;
//#import "GCDAsyncUdpSocket.h" // for UDP

#pragma mark - 系统库
//#import <sys/types.h>
//#import <sys/socket.h>
//#import <netinet/in.h>
//#import <arpa/inet.h>
//@interface TYHSocketManager()
//
//@property (nonatomic,assign)int clientScoket;
//
//@end

@interface GCDSocketManager()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *gcdSocket;
}
@end

@implementation GCDSocketManager
#pragma mark - CocoaAsyncSocket
+ (instancetype)cocoaAsync_share
{
    static dispatch_once_t onceToken;
    static GCDSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance cocoaAsync_initSocket];
    });
    return instance;
}

- (void)cocoaAsync_initSocket
{
    gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

}

#pragma mark - 对外的一些接口

//建立连接
- (BOOL)cocoaAsync_connect
{
    return  [gcdSocket connectToHost:Khost onPort:Kport error:nil];
}

//断开连接
- (void)cocoaAsync_disConnect
{
    [gcdSocket disconnect];
}

//发送消息
- (void)cocoaAsync_sendMsg:(NSString *)msg

{
    NSData *data  = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //第二个参数，请求超时时间
    [gcdSocket writeData:data withTimeout:-1 tag:110];

}

//监听最新的消息
- (void)cocoaAsync_pullTheMsg
{
    //监听读数据的代理  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    [gcdSocket readDataWithTimeout:-1 tag:110];

}

#pragma mark - GCDAsyncSocketDelegate
//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);

    [self cocoaAsync_pullTheMsg];

    //心跳写在这...
}

//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);

    //断线重连写在这...

}

//写成功的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
//    NSLog(@"写的回调,tag:%ld",tag);
}

//收到消息的回调
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{

    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);

    [self cocoaAsync_pullTheMsg];
}

//分段去获取消息的回调
//- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
//{
//
//    NSLog(@"读的回调,length:%ld,tag:%ld",partialLength,tag);
//
//}

//为上一次设置的读取数据代理续时 (如果设置超时为-1，则永远不会调用到)
//-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    NSLog(@"来延时，tag:%ld,elapsed:%f,length:%ld",tag,elapsed,length);
//    return 10;
//}
@end

#pragma mark - 系统
//+ (instancetype)share
//{
//    static dispatch_once_t onceToken;
//    static TYHSocketManager *instance = nil;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc]init];
//        [instance initScoket];
//        [instance pullMsg];
//    });
//    return instance;
//}
//
//- (void)initScoket
//{
//    //每次连接前，先断开连接
//    if (_clientScoket != 0) {
//        [self disConnect];
//        _clientScoket = 0;
//    }
//
//    //创建客户端socket
//    _clientScoket = CreateClinetSocket();
//
//    //服务器Ip
//    const char * server_ip="127.0.0.1";
//    //服务器端口
//    short server_port=6969;
//    //等于0说明连接失败
//    if (ConnectionToServer(_clientScoket,server_ip, server_port)==0) {
//        printf("Connect to server error\n");
//        return ;
//    }
//    //走到这说明连接成功
//    printf("Connect to server ok\n");
//}
//
//static int CreateClinetSocket()
//{
//    int ClinetSocket = 0;
//    //创建一个socket,返回值为Int。（注scoket其实就是Int类型）
//    //第一个参数addressFamily IPv4(AF_INET) 或 IPv6(AF_INET6)。
//    //第二个参数 type 表示 socket 的类型，通常是流stream(SOCK_STREAM) 或数据报文datagram(SOCK_DGRAM)
//    //第三个参数 protocol 参数通常设置为0，以便让系统自动为选择我们合适的协议，对于 stream socket 来说会是 TCP 协议(IPPROTO_TCP)，而对于 datagram来说会是 UDP 协议(IPPROTO_UDP)。
//    ClinetSocket = socket(AF_INET, SOCK_STREAM, 0);
//    return ClinetSocket;
//}
//static int ConnectionToServer(int client_socket,const char * server_ip,unsigned short port)
//{
//
//    //生成一个sockaddr_in类型结构体
//    struct sockaddr_in sAddr={0};
//    sAddr.sin_len=sizeof(sAddr);
//    //设置IPv4
//    sAddr.sin_family=AF_INET;
//
//    //inet_aton是一个改进的方法来将一个字符串IP地址转换为一个32位的网络序列IP地址
//    //如果这个函数成功，函数的返回值非零，如果输入地址不正确则会返回零。
//    inet_aton(server_ip, &sAddr.sin_addr);
//
//    //htons是将整型变量从主机字节顺序转变成网络字节顺序，赋值端口号
//    sAddr.sin_port=htons(port);
//
//    //用scoket和服务端地址，发起连接。
//    //客户端向特定网络地址的服务器发送连接请求，连接成功返回0，失败返回 -1。
//    //注意：该接口调用会阻塞当前线程，直到服务器返回。
//    if (connect(client_socket, (struct sockaddr *)&sAddr, sizeof(sAddr))==0) {
//        return client_socket;
//    }
//    return 0;
//}
//
//#pragma mark - 新线程来接收消息
//
//- (void)pullMsg
//{
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(recieveAction) object:nil];
//    [thread start];
//}
//
//#pragma mark - 对外逻辑
//
//- (void)connect
//{
//    [self initScoket];
//}
//- (void)disConnect
//{
//    //关闭连接
//    close(self.clientScoket);
//}
//
////发送消息
//- (void)sendMsg:(NSString *)msg
//{
//
//    const char *send_Message = [msg UTF8String];
//    send(self.clientScoket,send_Message,strlen(send_Message)+1,0);
//
//}
//
////收取服务端发送的消息
//- (void)recieveAction{
//    while (1) {
//        char recv_Message[1024] = {0};
//        recv(self.clientScoket, recv_Message, sizeof(recv_Message), 0);
//        printf("%s\n",recv_Message);
//    }
//}
//@end
