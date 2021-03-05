//
//  ThreadViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/1/27.
//

#import "ThreadViewController.h"
#import "LockViewController.h"

@interface ThreadViewController ()
@property (nonatomic, strong) NSOperationQueue * queue;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation ThreadViewController

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSThread
    
    
    //NSOperationQueue
//    [self testNSOperationQueue];
    
    
}
- (IBAction)btn:(id)sender {
//    [self testNSOperationQueue];
    LockViewController *vc = [[LockViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - NSOperationQueue
- (void)testNSOperationQueue {
    /*
     * NSOperationQueue
     * 1、NSOperation添加到队列后自动启动，并发交替执行，可以控制顺序执行
     * 2、NSOperation单独star启动，没有开启子线程，依然跑在主线程
     */
    
//    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAction:) object:@"线程star"];
//    [operation start];
    
    NSLog(@"%@",[NSString stringWithFormat:@"当子队列：主线程，所在线程：%@",[NSThread currentThread]]);
    
    NSInvocationOperation * operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAction:) object:@"线程2"];
        NSBlockOperation * operationblock = [NSBlockOperation blockOperationWithBlock:^{
            
            for (int i = 0; i < 1200; i++) {
                NSLog(@"%@",[NSString stringWithFormat:@"2当子队列：block，所在线程：%@",[NSThread currentThread]]);
            }
            
    }];
    [self.queue addOperation:operation2];
    [self.queue addOperation:operationblock];
    
    NSLog(@"%@",[NSString stringWithFormat:@"当子队列：主线程，所在线程：%@",[NSThread currentThread]]);
}

- (void)invocationOperationAction:(NSString *)msg {
    //子线程修改UI会报错
//    _lab.backgroundColor = [UIColor redColor];
//    _lab.text = @"qqqq";
    for (int i = 0; i < 1200; i++) {
        NSString *info = [NSString stringWithFormat:@"1当子队列：%@，所在线程：%@",msg,[NSThread currentThread]];
        NSLog(@"%@",info);
    }
//    [self performSelectorOnMainThread:@selector(toMain) withObject:nil waitUntilDone:YES];
}

- (void)toMain {
    NSLog(@"%@",[NSString stringWithFormat:@"当子队列：to主线程，所在线程：%@",[NSThread currentThread]]);
}

#pragma mark - lazy
- (NSOperationQueue *)queue {
    if(!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
