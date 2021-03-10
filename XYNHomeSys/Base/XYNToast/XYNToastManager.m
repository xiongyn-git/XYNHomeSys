//
//  XYNToastManager.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/5.
//

#import "XYNToastManager.h"

//@interface XYNToastManager()
//@property (nonatomic, copy)NSArray *toastsArr;
//@end

@implementation XYNToastManager

+ (instancetype)manager {
    static XYNToastManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] initWith];
    });
    return manager;
}
- (instancetype)initWith {
    self = [super init];
    if(!self) {
        return nil;
    }
    return self;
}

#pragma mark - 阻止alloc init
//禁用init
- (instancetype)init {
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"`-init` unavailable. Use `-initWithReachability:` instead"
                                 userInfo:nil];
    return nil;
}
/**
 以下方法，也能保证alloc唯一，但只是alloc走一次，init还是多次调用
 导致init逻辑里的其他属性，被多次初始化
 */
//防止外部调用alloc 或者 new
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    static Toast *instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [super allocWithZone:zone];
//    });
//    return instance;
//}

#pragma mark - public method
- (XYNToastView *)toastViewWithStyle:(XYNToastStyle)style {
    XYNToastView *toast = [[[self toastClassWithStyle:style] alloc] init];
    return toast;;
}

#pragma mark - private method
- (Class)toastClassWithStyle:(XYNToastStyle)style {
    switch (style) {
        case XYNToastStyleDefault:
            return [XYNToastDefaultView class];
            break;
            
        default:
            break;
    }
    return [XYNToastDefaultView class];
}

@end
