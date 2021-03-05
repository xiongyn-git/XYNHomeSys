//
//  CSToastManager.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/3.
//

#import <Foundation/Foundation.h>
#import "CSToastStyle.h"
#import "UIView+Toast.h"


NS_ASSUME_NONNULL_BEGIN

@interface CSToastManager : NSObject

@property (strong, nonatomic) CSToastStyle *sharedStyle;
@property (assign, nonatomic, getter=isTapToDismissEnabled) BOOL tapToDismissEnabled;
@property (assign, nonatomic, getter=isQueueEnabled) BOOL queueEnabled;
@property (assign, nonatomic) NSTimeInterval defaultDuration;
@property (strong, nonatomic) id defaultPosition;

+ (void)setSharedStyle:(CSToastStyle *)sharedStyle;
+ (CSToastStyle *)sharedStyle;
+ (void)setTapToDismissEnabled:(BOOL)tapToDismissEnabled;
+ (BOOL)isTapToDismissEnabled;
+ (void)setQueueEnabled:(BOOL)queueEnabled;
+ (BOOL)isQueueEnabled;
+ (void)setDefaultDuration:(NSTimeInterval)duration;
+ (NSTimeInterval)defaultDuration;
+ (void)setDefaultPosition:(id)position;
+ (id)defaultPosition;

@end

NS_ASSUME_NONNULL_END
