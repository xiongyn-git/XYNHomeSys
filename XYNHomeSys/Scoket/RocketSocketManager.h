//
//  RocketSocketManager.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/8.
//

#import <Foundation/Foundation.h>
/**
 重连机制：采用的是2的指数级别增长，第一次立刻重连，第二次2秒，第三次4秒，第四次8秒，直到大于64秒就不再重连。
 而任意的一次成功的连接，都会重置这个重连时间。
 
 SocketRocket这个框架给我们封装的webscoket在调用它的sendPing方法之前，
 一定要判断当前scoket是否连接，如果不是连接状态，程序则会crash。

 webScoket服务端实现
 无法沿用之前的node.js例子了，因为这并不是一个原生的scoket，这是webScoket，所以我们服务端同样需要遵守webScoket协议，两者才能实现通信。
 */
typedef enum : NSUInteger {
    disConnectByUser ,
    disConnectByServer,
} DisConnectType;

NS_ASSUME_NONNULL_BEGIN

@interface RocketSocketManager : NSObject

+ (instancetype)share;
- (void)connect;
- (void)disConnect;
- (void)sendMsg:(NSString *)msg;
- (void)ping;

@end

NS_ASSUME_NONNULL_END
