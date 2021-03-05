//
//  Toast.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/28.
//

#import "Toast.h"

@implementation ToastLabel

- (instancetype)init {
    self = [super init];
    if(self) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}

- (void)setMessageText:(NSString *)text {
    [self setText:text];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 15;
    CGFloat x = (kScreenWidth - width)/2.0;
    CGFloat y = kScreenHeight / 4.0 * 3.5 - height;
    
    self.frame = CGRectMake(x, y, width, height);
}

@end
 

@implementation Toast

//静态变量只初始化一次：后面所有申明 同名变量 并 给初始值的情况，一律按原有值返回
//所以放局部放全局都一样
//static Toast *instance = nil;
//static dispatch_once_t onceToken;
////销毁
//+(void)attempDealloc{
//    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
//    instance = nil;
// }
#pragma mark -  单例
+ (instancetype)sharedSingleton {
    static Toast *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWith];
    });
    return instance;
}
#pragma mark -  防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static Toast *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
#pragma mark - 当类继承于字符数组字典，带有copy方法的类时，需要重写以下两个方法，遵守NSCopying协议
//// 防止外部调用copy
//- (id)copyWithZone:(nullable NSZone *)zone {
//    return instance;
//}
//// 防止外部调用mutableCopy
//- (id)mutableCopyWithZone:(nullable NSZone *)zone {
//    return instance;
//}
-(instancetype)init {
    self = [super init];
    if(self) {
        _msgLabel = [[ToastLabel alloc] init];
        _msgLabel.layer.masksToBounds = NO;
//        _countTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
//        _countTime.fireDate = [NSDate distantFuture];
    }
    return self;;
}

- (instancetype)initWith {
    self = [super init];
    if(self) {
        _msgLabel = [[ToastLabel alloc] init];
        _msgLabel.layer.masksToBounds = YES;
//        _countTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
//        _countTime.fireDate = [NSDate distantFuture];
    }
    return self;;
}


//- (void)changeTime {
//
//    if(_duration-- <= 0) {
//        _countTime.fireDate = [NSDate distantFuture];
//        [UIView animateWithDuration:0.2f animations:^{
//            self.msgLabel.alpha = 0;
//        } completion:^(BOOL finished) {
//            [self.msgLabel removeFromSuperview];
//        }];
//    }
//}
- (void)makeToast:(NSString *)message duration:(CGFloat)duration {
    if([message length] == 0) {
        return;
    }
    [self.msgLabel setMessageText:message];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.msgLabel];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CFRunLoopStop(CFRunLoopGetMain());
        [self.msgLabel removeFromSuperview];
    });

//    __weak typeof(self) weakSelf = self;
//
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized(self) {
//
//        }
//    });
    
    
//    _duration = duration;
//    _countTime.fireDate = [NSDate distantPast];
    
}

@end
