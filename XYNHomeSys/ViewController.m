//
//  ViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/1/27.
//

#import "ViewController.h"
#import "ThreadViewController.h"
#import "KvocViewController.h"
#import "AFNetViewController.h"
#import "BankObject.h"
#import "TableViewController.h"
#import "MapViewController.h"
#import "AlertViewController.h"
#import "GDMapViewController.h"
#import "Toast.h"
#import "ScoketViewController.h"
#import <objc/message.h>
#import "KVCObject.h"
#import "AppDelegate.h"
#import "UserDefaultViewController.h"
#import "RunloopViewController.h"

@interface ViewController ()
@property (nonatomic, strong) BankObject *obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建观察者
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        NSLog(@"监听到RunLoop发生改变---%zd",activity);
//    });
//    // 添加观察者到当前RunLoop中
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
//    // 释放observer，最后添加完需要释放掉
//    CFRelease(observer);
}


- (IBAction)toThreadVC:(id)sender {
    if(self.obj) {
        self.obj.bankName = @"111";
    }
    
    ThreadViewController *vc = [[ThreadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toKvo:(id)sender {
    KvocViewController *vc = [[KvocViewController alloc] init];
    __weak typeof(self) weakself = self;
    vc.block = ^(BankObject * _Nonnull obj) {
        __strong typeof(weakself) strongself = weakself;
        strongself.obj = obj;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toNetvc:(id)sender {
    AFNetViewController *vc = [[AFNetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toTableView:(id)sender {
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toMapVc:(id)sender {
    MapViewController *vc = [[MapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)AlertVc:(id)sender {
    AlertViewController *vc = [[AlertViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)allMap:(id)sender {
    GDMapViewController *vc = [[GDMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toSocket:(id)sender {
    ScoketViewController *vc = [[ScoketViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toSave:(id)sender {
    UserDefaultViewController *vc = [[UserDefaultViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toRunloop:(id)sender {
    RunloopViewController *vc = [[RunloopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
