//
//  CSToastStyle.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSToastStyle : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIColor *shadowColor;

@property (nonatomic, assign) CGFloat maxWidthPercentage;
@property (nonatomic, assign) CGFloat maxHeightPercentage;
@property (nonatomic, assign) CGFloat horizontalPadding;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, assign) NSInteger titleNumberOfLines;
@property (nonatomic, assign) NSInteger messageNumberOfLines;
@property (nonatomic, assign, getter=isDisplayShadow) BOOL displayShadow;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize activitySize;
@property (nonatomic, assign) CGFloat fadeDuration;

- (instancetype)initWithDefaultStyle;
- (void)setMaxWidthPercentage:(CGFloat)maxWidthPercentage;
- (void)setMaxHeightPercentage:(CGFloat)maxHeightPercentage;

@end

NS_ASSUME_NONNULL_END
