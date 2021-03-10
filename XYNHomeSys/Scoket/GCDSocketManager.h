//
//  TYHSocketManager.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/7.
//
/**
 四种实现方式：
 基于Scoket原生：代表框架 CocoaAsyncSocket。
 基于WebScoket：代表框架 SocketRocket。 心跳，断线重连，以及PingPong机制进行
 基于MQTT：代表框架 MQTTKit。
 基于XMPP：代表框架 XMPPFramework。
 
 聊天协议  -  XMPP：优：协议开源，可拓展性强，接入方便。缺：xml表现力弱，太多冗余，流量大
 聊天协议  -  MQTT：优：协议简单，流量少；订阅+推送的模式，适合滴滴的小车轨迹移动。缺：不是专为IM设计的协议，多用于推送
 聊天协议  -  私有协议：优：高效，节约流量（二进制），安全性高，难以破解。缺：对设计者要求高
 而通常我们所说的腾讯IM的私有协议，就是基于WebScoket或者Scoket原生进行封装的一个  聊天协议。
 
 而WebScoket是传输通讯协议，它是基于Socket封装的一个协议。
 
 传输格式 - 选择传输格式的时候：ProtocolBuffer > Json > XML
 采用新的Protocol Buffer数据格式+Gzip压缩后的Payload大小降低了15%-45%。数据序列化耗时下降了80%-90%。
 
 ProtocolBuffer优点：
 采用高效安全的私有协议，支持长连接的复用，稳定省电省流量
 【高效】提高网络请求成功率，消息体越大，失败几率随之增加。
 【省流量】流量消耗极少，省流量。一条消息数据用Protobuf序列化后的大小是 JSON 的1/10、XML格式的1/20、是二进制序列化的1/10。同 XML 相比， Protobuf 性能优势明显。它以高效的二进制方式存储，比 XML 小 3 到 10 倍，快 20 到 100 倍。
 【省电】省电
 【高效心跳包】同时心跳包协议对IM的电量和流量影响很大，对心跳包协议上进行了极简设计：仅 1 Byte 。
 【易于使用】开发人员通过按照一定的语法定义结构化的消息格式，然后送给命令行工具，工具将自动生成相关的类，可以支持java、c++、python、Objective-C等语言环境。通过将这些类包含在项目中，可以很轻松的调用相关方法来完成业务消息的序列化与反序列化工作。语言支持：原生支持c++、java、python、Objective-C等多达10余种语言。 2015-08-27 Protocol Buffers v3.0.0-beta-1中发布了Objective-C(Alpha)版本， 2016-07-28 3.0 Protocol Buffers v3.0.0正式版发布，正式支持 Objective-C。
 【可靠】微信和手机 QQ 这样的主流 IM 应用也早已在使用它（采用的是改造过的Protobuf协议）
 
 缺点：
 可能会造成 APP 的包体积增大，通过 Google 提供的脚本生成的 Model，会非常“庞大”，Model 一多，包体积也就会跟着变大。

 =====================================================================
 
 心跳机制就起到作用了：
 我们客户端发起心跳Ping（一般都是客户端），假如设置在10秒后如果没有收到回调，那么说明服务器或者客户端某一方出现问题，这时候我们需要主动断开连接。
 服务端也是一样，会维护一个socket的心跳间隔，当约定时间内，没有收到客户端发来的心跳，我们会知道该连接已经失效，然后主动断开连接。
 TCP的KeepAlive机制只能保证连接的存在，但是并不能保证客户端以及服务端的可用性.
 =====================================================================
 IM的可靠性：
 心跳机制、PingPong机制、断线重连机制、还有我们后面所说的QOS机制。这些被用来保证连接的可用，消息的即时与准确的送达等等。
 大文件传输的时候使用分片上传、断点续传、秒传技术等来保证文件的传输。
 
 安全性：
 我们通常还需要一些安全机制来保证我们IM通信安全。例如：防止 DNS 污染、帐号安全、第三方服务器鉴权、单点登录等等
 
 其他的优化：
 微信，服务器不做聊天记录的存储，只在本机进行缓存，这样可以减少对服务端数据的请求，一方面减轻了服务器的压力，另一方面减少客户端流量的消耗。
 进行http连接的时候尽量采用上层API，类似NSUrlSession。而网络框架尽量使用AFNetWorking3。因为这些上层网络请求都用的是HTTP/2 ，我们请求的时候可以复用这些连接。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDSocketManager : NSObject

#pragma mark - CocoaAsyncSocket

+ (instancetype)cocoaAsync_share;
- (BOOL)cocoaAsync_connect;
- (void)cocoaAsync_disConnect;
- (void)cocoaAsync_sendMsg:(NSString *)msg;
- (void)cocoaAsync_pullTheMsg;

#pragma mark - 系统
//+ (instancetype)share;
//- (void)connect;
//- (void)disConnect;
//- (void)sendMsg:(NSString *)msg;

@end


NS_ASSUME_NONNULL_END
