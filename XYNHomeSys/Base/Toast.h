//
//  Toast.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastLabel : UILabel
- (void)setMessageText:(NSString *)text;
@end

@interface Toast : NSObject
//文字lab
@property (nullable, nonatomic,readonly,strong) ToastLabel *msgLabel;
//定时器
//@property (nullable, nonatomic,readonly,strong) NSTimer *countTime;
//持续时间
//@property (nonatomic,readonly,assign) CGFloat duration;


+ (instancetype)sharedSingleton;
- (void)makeToast:(NSString *)message duration:(CGFloat)duration;
- (void)makeToast:(NSString *)message;
@end

NS_ASSUME_NONNULL_END


