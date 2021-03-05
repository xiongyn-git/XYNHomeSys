//
//  GCDViewController.m
//  XYNHomeSys
//  文章见
//  https://www.jianshu.com/p/f419f850257d
//
//  Created by xyn on 2021/3/2.
//

#import "LockViewController.h"

@interface LockViewController ()

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self semaphoreLock];
    CFRunLoopRun();

    [self semaphoreLock];
    CFRunLoopRun();

}

#pragma mark - GCD dispatch_semaphore_wait
/*
 如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。
 dispatch_semaphore 是信号量，但当信号总量设为 1 时也可以当作锁来。在没有等待情况出现时，它的性能比 pthread_mutex还要高，但一旦有等待情况出现时，性能就会下降许多。相对于 OSSpinLock 来说，它的优势在于等待时不会消耗 CPU 资源。
 */
- (void)semaphoreLock {
//    dispatch_semaphore_t signal = dispatch_semaphore_create(1); //初始信号量为1
//    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC); //锁几秒
//    DISPATCH_QUEUE_CONCURRENT  并行
//    DISPATCH_QUEUE_SERIAL      串行
//    dispatch_sync              同步
//    dispatch_async             异步
    
    
    NSLog(@"需要线程同步的操作1 开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CFRunLoopStop(CFRunLoopGetMain());

        NSLog(@"延时2");
        
    });
    NSLog(@"需要线程同步的操作1 结束");

    
    
    
    
//    dispatch_queue_t sun = dispatch_queue_create("sss", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(sun, ^{
//
//        dispatch_semaphore_wait(signal, overTime); //信号量减1
//
//        NSLog(@"需要线程同步的操作1 开始");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), sun, ^{
//
//            dispatch_semaphore_wait(signal, overTime); //信号量减1
//            NSLog(@"延时2");
//            dispatch_semaphore_signal(signal); //信号量加1
//
//        });
//        NSLog(@"需要线程同步的操作1 结束");
//
//
//        dispatch_semaphore_signal(signal); //信号量加1
//    });
    
//    dispatch_queue_t sun = dispatch_queue_create("sss", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(sun, ^{
//
//
//        NSLog(@"需要线程同步的操作1 开始");
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), sun, ^{
//            NSLog(@"延时2");
//
//        });
//        NSLog(@"需要线程同步的操作1 结束");
//
//    });
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        dispatch_semaphore_wait(signal, overTime);
    //        NSLog(@"延时2");
    //        dispatch_semaphore_signal(signal); //信号量加1
    //    });
    //
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_wait(signal, overTime);
//
//        NSLog(@"需要线程同步的操作2");
//        dispatch_semaphore_signal(signal);
//    });
    /**
     需要线程同步的操作1 开始
     需要线程同步的操作1 结束
     需要线程同步的操作2
     
     如果超时时间overTime设置成>2，可完成同步操作。如果overTime<2的话，在线程1还没有执行完成的情况下，此时超时了，将自动执行下面的代码。
     需要线程同步的操作1 开始
     需要线程同步的操作2
     需要线程同步的操作1 结束
     */
}
- (void)abc:(NSString *)abc {
    NSLog(@"%@",abc);
}
#pragma mark - synchronized
/*
 @synchronized(obj)指令使用的obj为该锁的唯一标识，只有当标识相同时，才为满足互斥，如果线程2中的@synchronized(obj)改为@synchronized(self),刚线程2就不会被阻塞。
 @synchronized指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制，但作为一种预防措施，@synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象。
 */
- (void)synchronizedLock {
    NSObject * obj = NSObject.alloc.init;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作1 开始");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @synchronized(obj) {
                    NSLog(@"延时2");
                }
            });
            NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(1);
//        @synchronized(self) {
//            NSLog(@"需要线程同步的操作2");
//        }
//    });
    /**
     需要线程同步的操作1 开始
     需要线程同步的操作1 结束
     需要线程同步的操作2
     */
}

#pragma mark - NSRecursiveLock 递归锁
/*
 NSRecursiveLock是一个递归锁，这个锁可以被同一线程多次请求，而不会引起死锁。这主要是用在循环或递归操作中。
 这段代码是一个典型的死锁情况。在我们的线程中，RecursiveMethod是递归调用的。所以每次进入这个block时，都会去加一次锁，而从第二次开始，由于锁已经被使用了且没有解锁，所以它需要等待锁被解除，这样就导致了死锁，线程被阻塞住了。
 使用NSRecursiveLock。它可以允许同一线程多次加锁，而不会造成死锁。递归锁会跟踪它被lock的次数。每次成功的lock都必须平衡调用unlock操作。只有所有达到这种平衡，锁最后才能被释放，以供其它线程使用。
 */
- (void)recursiveLock {
    // NSLock * lock = NSLock.alloc.init; //使用nslock会产生死锁
    NSRecursiveLock * lock = NSRecursiveLock.alloc.init;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value) {
            [lock lock];
            if (value > 0) {
                NSLog(@"value = %@",@(value));
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        RecursiveMethod(6);
    });
    /**
     value = 6
     value = 5
     value = 4
     value = 3
     value = 2
     value = 1
     */
}

#pragma mark - NSConditionLock 条件锁
/*
 (void)lockWhenCondition:(NSInteger)condition;
 (void)unlockWithCondition:(NSInteger)condition;
 这两个condition一样的时候会相互通知。
 初始化 self.condition = [[NSConditionLock alloc]initWithCondition:0];
 获得锁 [self.condition lockWhenCondition:1];
 解锁 [self.condition unlockWithCondition:1];
 */
- (void)conditionLockLock {
    NSConditionLock * lock = [NSConditionLock.alloc initWithCondition:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            [lock lockWhenCondition:1];
            NSLog(@"需要线程同步的操作1 开始");
            sleep(2);
            NSLog(@"需要线程同步的操作1 结束");
            [lock unlockWithCondition:0];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            [lock lockWhenCondition:0];
            NSLog(@"需要线程同步的操作2 开始");
            sleep(1);
            NSLog(@"需要线程同步的操作2 结束");
            [lock unlockWithCondition:2];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            [lock lockWhenCondition:2];
            NSLog(@"需要线程同步的操作3 开始");
            sleep(1);
            NSLog(@"需要线程同步的操作3 结束");
            [lock unlockWithCondition:1];
        }
    });
    /**
     需要线程同步的操作2 开始
     需要线程同步的操作2 结束
     需要线程同步的操作3 开始
     需要线程同步的操作3 结束
     需要线程同步的操作1 开始
     需要线程同步的操作1 结束
     */
}

#pragma mark - NSContidion 最基本的条件锁
/*
 手动控制线程wait和signal。
 [condition lock];一般用于多线程同时访问、修改同一个数据源，保证在同一时间内数据源只被访问、修改一次，其他线程的命令需要在lock 外等待，只到unlock ，才可访问
 [condition unlock];与lock 同时使用
 [condition wait];让当前线程处于等待状态
 [condition signal];CPU发信号告诉线程不用在等待，可以继续执行
 */
- (void)contidionLock {
    NSCondition * condition = NSCondition.alloc.init;
    NSMutableArray * products = NSMutableArray.array;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            [condition lock];
            if (products.count == 0) {
                NSLog(@"wait for product");
                [condition wait];
            }
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [condition unlock];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            [condition lock];
            [products addObject:NSObject.alloc.init];
            NSLog(@"produce a product，总量：%ld",products.count);
            [condition signal];
            [condition unlock];
            sleep(2);
        }
    });
    
    /**
     wait for product
     produce a product，总量：1
     custome a product
     
     wait for product
     produce a product，总量：1
     custome a product
     */
}

@end
