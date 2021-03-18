//
//  main.m
//  XYNHomeSys
//
//  Created by xyn on 2021/1/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
/**
 AFNetworking（一）从一次请求了解AFHTTPSessionManager
 https://blog.csdn.net/weixin_33845881/article/details/87976073
 iOS崩溃保护方案
 https://www.jianshu.com/p/6e6b4f3da133
 关于KVO的那些事 之 KVO安全用法封装
 https://www.jianshu.com/p/f8bb89aad2df
 iOS-设计一个在dealloc中自动移除KVO的分类
 https://www.jianshu.com/p/0966d89fa035?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 kvo手动通知
 https://blog.csdn.net/quanqinyang/article/details/45226753
 NSURLSession笔记（一） 文件下载、断点下载
 https://www.jianshu.com/p/27e486118844
 NSURLSessionConfiguration属性、pch宏定义

 即时通讯
 http://www.cocoachina.com/articles/18544
 CoreLocation 框架
 https://www.cnblogs.com/mtystar/p/7049709.html
 iOS math.h 常用数学函数
 https://blog.csdn.net/gf771115/article/details/7860414
 YYKit
 https://www.jianshu.com/p/514ffb83868d
 透彻理解block中weakSelf和strongSelf
 https://www.jianshu.com/p/ae4f84e289b9
 iOS 高德地图SDK集成
 https://www.jianshu.com/p/0b1128615dc4
 iOS14：定位的授权配置总结
 https://www.jianshu.com/p/7616285c251d?utm_campaign=hugo&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 iOS设计模式详解
 https://www.jianshu.com/p/e5c69c7b8c00
 https://blog.csdn.net/qq_19678579/article/details/86162604
 Mac 安装 node.js 及环境配置
 https://blog.csdn.net/xujiuba/article/details/107223046
 iOS即时通讯详解
 https://www.jianshu.com/p/8d7fcb790df9
 ChatKit
 https://www.jianshu.com/p/4818009fcebf
 RunLoop
 https://www.jianshu.com/p/d260d18dd551
 流程
 https://www.jianshu.com/p/d63d0eccc7fb
 */
