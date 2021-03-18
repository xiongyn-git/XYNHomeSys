//
//  RunloopViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/16.
//

#import "RunloopViewController.h"

@interface RunloopViewController ()

@end

@implementation RunloopViewController
/**
 Core Foundation框架下关于 RunLoop 的 5 个类：
 CFRunLoopRef：代表 RunLoop 的对象
 CFRunLoopModeRef：代表 RunLoop 的运行模式
 CFRunLoopSourceRef：就是 RunLoop 模型图中提到的输入源 / 事件源
 CFRunLoopTimerRef：就是 RunLoop 模型图中提到的定时源
 CFRunLoopObserverRef：观察者，能够监听 RunLoop 的状态改变

 
 运行模式（CFRunLoopModeRef），如下：
 kCFRunLoopDefaultMode：App的默认运行模式，通常主线程是在这个运行模式下运行
 UITrackingRunLoopMode：跟踪用户交互事件（用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他Mode影响）
 UIInitializationRunLoopMode：在刚启动App时第进入的第一个 Mode，启动完成后就不再使用
 GSEventReceiveRunLoopMode：接受系统内部事件，通常用不到
 kCFRunLoopCommonModes：伪模式，不是一种真正的运行模式（后边会用到）

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     调用了scheduledTimer返回的定时器，NSTimer会自动被加入到了RunLoop的NSDefaultRunLoopMode模式下
     */
//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 定义一个定时器，约定两秒之后调用self的run方法
    NSTimer *timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
    /**
     当我们拖动Text View滚动时，run方法不打印了，因为NSTimer不工作了。
     而当我们松开鼠标的时候，NSTimer就又开始正常工作了。
     
     当我们不做任何操作的时候，RunLoop处于NSDefaultRunLoopMode下。
     而当我们拖动TextView的时候，RunLoop就结束NSDefaultRunLoopMode，
     切换到了UITrackingRunLoopMode模式下，这个模式下没有添加NSTimer，所以我们的NSTimer就不工作了。
     但当我们松开鼠标的时候，RunLoop就结束UITrackingRunLoopMode模式，又切换回NSDefaultRunLoopMode模式，所以NSTimer就又开始正常工作
     */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    /**
     UITrackingRunLoopMode下，你就会发现定时器只会在拖动Text View的模式下工作，而不做操作的时候定时器就不工作
     */
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    /**
     要在这两种模式下让NSTimer都能正常工作
     */
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    [self observer];

}

- (void)run {
    NSLog(@"aaaaa");
}
- (IBAction)click:(id)sender {
    NSLog(@"bbbb");
}
/**
 kCFRunLoopCommonModes：
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),               // 即将进入Loop：1
     kCFRunLoopBeforeTimers = (1UL << 1),        // 即将处理Timer：2
     kCFRunLoopBeforeSources = (1UL << 2),       // 即将处理Source：4
     kCFRunLoopBeforeWaiting = (1UL << 5),       // 即将进入休眠：32
     kCFRunLoopAfterWaiting = (1UL << 6),        // 即将从休眠中唤醒：64
     kCFRunLoopExit = (1UL << 7),                // 即将从Loop中退出：128（触摸松开的时候）
     kCFRunLoopAllActivities = 0x0FFFFFFFU       // 监听全部状态改变
 };
 */
- (void)observer {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
}

@end
