//
//  XYNModel.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYNLog : NSObject
@property (nonatomic, copy)NSString *test;

//打印模型
+ (NSString *)logPrintWithModel:(NSObject *)model;

//将字典中unicode打印为中文
+ (NSString *)logChineseByDic:(NSDictionary *)dic;
+ (NSString *)logChineseByString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
