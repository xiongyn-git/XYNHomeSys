//
//  XYNCycleView.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//
/**
 轮播视图
 */
@protocol XYNCycleViewDataSource, XYNCycleViewDelegate;
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYNCycleViewStyle) {
    XYNCycleViewStylePlain,          // regular table view
    XYNCycleViewStyleGrouped         // sections are grouped together
};
typedef void (^XYNCycleViewBlock)(NSInteger a, NSInteger b);


@interface XYNCycleView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(XYNCycleViewStyle)style;
- (nullable instancetype)initWithCoder:(NSCoder *)coder;

@property (nonatomic, readonly) XYNCycleViewStyle style;
@property (nonatomic, copy, nullable) void (^block)(void);
@property (nonatomic, weak, nullable) id <XYNCycleViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <XYNCycleViewDelegate> delegate;

@end

@interface XYNCycleViewItem : UIView

@end


@protocol XYNCycleViewDataSource <NSObject>
//@required
- (NSInteger)cycleView:( XYNCycleView *)cycleView numberOfPage:(NSInteger)page;
- (XYNCycleViewItem *)cycleView:(XYNCycleView *)cycleView itemForIndex:(NSInteger *)index;
@end

@protocol XYNCycleViewDelegate <NSObject>
@optional

@end
NS_ASSUME_NONNULL_END
