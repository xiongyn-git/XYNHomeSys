//
//  XYNUtils.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYNUtils : NSObject
/*
 * 十六进制颜色值转换成UIColor对象
 */
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;
/*
 *  UIColor对象转换成十六进制颜色值字符串
 */
+ (NSString *)changeUIColorToRGB:(UIColor *)color;
/*
 *  使用UIColor创建UIImage
 */
+ (UIImage *) createImageWithColor: (UIColor *)color;

@end

NS_ASSUME_NONNULL_END
