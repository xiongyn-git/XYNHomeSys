//
//  UIView+Toast.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/3.
//

#import <UIKit/UIKit.h>
//#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "CSToastManager.h"


NS_ASSUME_NONNULL_BEGIN

// Positions
static const NSString * CSToastPositionTop                       = @"CSToastPositionTop";
static const NSString * CSToastPositionCenter                    = @"CSToastPositionCenter";
static const NSString * CSToastPositionBottom                    = @"CSToastPositionBottom";

// Keys for values associated with toast views
static const NSString * CSToastTimerKey             = @"CSToastTimerKey";
static const NSString * CSToastDurationKey          = @"CSToastDurationKey";
static const NSString * CSToastPositionKey          = @"CSToastPositionKey";
static const NSString * CSToastCompletionKey        = @"CSToastCompletionKey";

// Keys for values associated with self
static const NSString * CSToastActiveKey            = @"CSToastActiveKey";
static const NSString * CSToastActivityViewKey      = @"CSToastActivityViewKey";
static const NSString * CSToastQueueKey             = @"CSToastQueueKey";



@interface UIView (ToastPrivate)

/**
 These private methods are being prefixed with "cs_" to reduce the likelihood of non-obvious
 naming conflicts with other UIView methods.
 
 @discussion Should the public API also use the cs_ prefix? Technically it should, but it
 results in code that is less legible. The current public method names seem unlikely to cause
 conflicts so I think we should favor the cleaner API for now.
 */
- (void)cs_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position;
- (void)cs_hideToast:(UIView *)toast;
- (void)cs_hideToast:(UIView *)toast fromTap:(BOOL)fromTap;
- (void)cs_toastTimerDidFinish:(NSTimer *)timer;
- (void)cs_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)cs_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (NSMutableArray *)cs_toastQueue;

@end
NS_ASSUME_NONNULL_END
