//
//  FileUtils.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//
/**
 tools：
 1、当前项目中通用的业务类的组合；仅能当前项目使用，业务助手
 2、方法或属性不限
 3、用户校验工具类,支付工具类等
 utils：
 1、通用的且与项目业务无关的类的组合；可供其他项目使用
 2、方法通常是public static的；一般无类的属性，如果有，也是public static的
 3、字符串工具类,文件工具类等
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUtils : NSObject

@end

NS_ASSUME_NONNULL_END
