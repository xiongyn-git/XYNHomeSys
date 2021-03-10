//
//  RocketSocketManager.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/8.
//

#import "RocketSocketManager.h"
#import "SocketRocket.h"


#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
static  NSString * Khost = @"127.0.0.1";
static const uint16_t Kport = 6969;

@interface RocketSocketManager()<SRWebSocketDelegate>

@property (nonatomic , strong)SRWebSocket *webSocket;
@property (nonatomic , strong)NSTimer *heartBeat;
@property (nonatomic , assign)NSTimeInterval reConnectTime;


@end

@implementation RocketSocketManager

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static RocketSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
    });
    return instance;
}

//初始化连接
- (void)initSocket
{
    if (self.webSocket) {
        return;
    }

    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:%d", Khost, Kport]]];

    self.webSocket.delegate = self;

    //设置代理线程queue
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;

    [self.webSocket setDelegateOperationQueue:queue];

    //连接
    [self.webSocket open];

}

//初始化心跳
- (void)initHeartBeat
{

    dispatch_main_async_safe(^{

        [self destoryHeartBeat];

        __weak typeof(self) weakSelf = self;
        //心跳设置为3分钟，NAT超时一般为5分钟
        self.heartBeat = [NSTimer scheduledTimerWithTimeInterval:3*60 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"heart");
            //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
            [weakSelf sendMsg:@"heart"];
        }];
        [[NSRunLoop currentRunLoop]addTimer:self.heartBeat forMode:NSRunLoopCommonModes];
    })

}

//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (self.heartBeat) {
            [self.heartBeat invalidate];
            self.heartBeat = nil;
        }
    })

}

#pragma mark - 对外的一些接口

//建立连接
- (void)connect
{
    [self initSocket];

    //每次正常连接的时候清零重连时间
    self.reConnectTime = 0;
}

//断开连接
- (void)disConnect
{

    if (self.webSocket) {
        [self.webSocket close];
        self.webSocket = nil;
    }
}

//发送消息
- (void)sendMsg:(NSString *)msg
{
    [self.webSocket send:msg];

}

//重连机制
- (void)reConnect
{
    [self disConnect];

    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (self.reConnectTime > 64) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.webSocket = nil;
        [self initSocket];
    });

    //重连时间2的指数级增长
    if (self.reConnectTime == 0) {
        self.reConnectTime = 2;
    }else{
        self.reConnectTime *= 2;
    }

}

//pingPong
- (void)ping{
//    if(self.webSocket.readyState == SR_OPEN) {
        [self.webSocket sendPing:nil];
//    }
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"服务器返回收到消息:%@",message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"连接成功");

    //连接成功了开始发送心跳
    [self initHeartBeat];
}

//open失败的时候调用
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"连接失败.....\n%@",error);

    //失败了就去重连
    [self reConnect];
}

//网络连接中断被调用
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{

    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);

    //如果是被用户自己中断的那么直接断开连接，否则开始重连
    if (code == disConnectByUser) {
        [self disConnect];
    }else{

        [self reConnect];
    }
    //断开连接时销毁心跳
    [self destoryHeartBeat];

}

//sendPing的时候，如果网络通的话，则会收到回调，但是必须保证ScoketOpen，否则会crash
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    NSLog(@"收到pong回调");

}

//将收到的消息，是否需要把data转换为NSString，每次收到消息都会被调用，默认YES
//- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket
//{
//    NSLog(@"webSocketShouldConvertTextFrameToString");
//
//    return NO;
//}

@end
