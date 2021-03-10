//
//  XYNToastManager.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/5.
//

#import <Foundation/Foundation.h>
#import "XYNToastView.h"
#import "XYNToastDefaultView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYNToastStyle)
{
    XYNToastStyleDefault = 0,
    XYNToastStyleImg
};



@interface XYNToastManager : NSObject

+ (instancetype)manager;
- (XYNToastView *)toastViewWithStyle:(XYNToastStyle)style;

@end

NS_ASSUME_NONNULL_END
