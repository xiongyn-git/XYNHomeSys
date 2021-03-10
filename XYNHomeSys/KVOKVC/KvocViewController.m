//
//  kvocViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/19.
//

#import "KvocViewController.h"
#import "ViewController.h"
#import "KVCObject.h"
#import "XYNLog.h"

@interface KvocViewController ()
@property (nonatomic, strong) BankObject *obj;
@end

@implementation KvocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testKvo];
    [self testKVC];
}
- (void)dealloc {
    /**
      会崩溃的3个原因：
     1、监听者dealloc时，监听关系还存在。当监听值发生变化时，会给监听者的野指针发送消息，报野指针Crash。（猜测底层是保存了unsafe_unretained指向监听者的指针）；
     2、被监听者dealloc时，监听关系还存在。在监听者内存free掉后，直接会报监听者还存在监听关系而Crash；
     3、移除监听次数大于添加监听次数。报出多次移除的错误；

          
     */
    [self.obj removeObserver:self forKeyPath:NSStringFromSelector(@selector(bankName))];
    [self.obj removeObserver:self forKeyPath:@"accountForBank"];
    [self.obj removeObserver:self forKeyPath:NSStringFromSelector(@selector(accountName))];

}

#pragma mark - kvc
- (void)testKVC {
    /**
        点方法只能取到公有属性，kvc能取到另外3种：成员变量、私有属性
     */
//    KVCObject *model = [[KVCObject alloc] init];
//    [model setValue:@"memberPublic" forKey:@"memberPublic"];
//    [model setValue:@"11" forKey:@"public"];
//    [model setValue:@"propertyPrivate" forKey:@"propertyPrivate"];
//    [model setValue:@"memberPrivate" forKey:@"memberPrivate"];
//    NSString *memberPublic = [model valueForKey:@"memberPublic"];
//    NSString *propertyPublic = [model valueForKey:@"propertyPublic"];
//    NSString *propertyPrivate = [model valueForKey:@"propertyPrivate"];
//    NSString *memberPrivate = [model valueForKey:@"memberPrivate"];
//    NSArray<BankObject *> *arr = [model valueForKey:@"modelList"];
//    BankObject *mod = [model valueForKey:@"model"];
    
    
    /**
        kvc解析
     */
    NSDictionary *dic = @{@"memberPublic":@"1",
                          @"a":@"aa",
                          @"public":@"2",
                          @"propertyPrivate":@"3",
                          @"memberPrivate":@"4",
                          @"modelList":@[@{
                                  @"bankName":@"5",
                                  @"accountForBank":@"6",
                                  @"accountName":@"7"
                          }],
                          @"model":@{
                                  @"bankName":@"55",
                                  @"accountForBank":@"66",
                                  @"accountName":@"77",
                                  @"sonModel":@{
                                          @"bankName":@"55",
                                          @"accountForBank":@"66"
                                  }
                          }
    };
    KVCObject *kvcModel = [[KVCObject alloc] initWithDic:dic];
    NSLog(@"%@",[XYNLog logPrintWithModel:kvcModel]);


}

#pragma mark - kvo:只能一对一
- (void)testKvo {
    self.obj = [[BankObject alloc] init];
   
    //自动通知
    [self.obj addObserver:self forKeyPath:NSStringFromSelector(@selector(bankName)) options:NSKeyValueObservingOptionNew context:@"自动通知bankName"];
    
    //手动通知
    [self.obj addObserver:self forKeyPath:NSStringFromSelector(@selector(accountName)) options:NSKeyValueObservingOptionNew context:@"手动通知accountName"];
    
    
    //参数关联通知：监听参数C = A+B，AB改变的时候，C的观察者不会通知
    [self.obj addObserver:self forKeyPath:@"accountForBank" options:NSKeyValueObservingOptionNew context:@"关联通知accountForBank"];
    
    self.obj.bankName = @"aaa";
    self.obj.accountName = @"账号名字";
    
    
    //测试崩溃1
//    self.block(self.obj);
    
}
//通知回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    BankObject *obj = [[BankObject alloc] init];
//    void *context  = (__bridge void *)obj;
//
//    id ob = (__bridge id)context;
//    if([ob isKindOfClass:[BankObject class]]) {
//        BankObject *obj = (BankObject *)ob;
//    }

    NSLog(@"%@context：%@",[change description], context);
}

#pragma mark - 通知：一对多
- (void)test {
    
}

@end
