//
//  XYNModel.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/20.
//

#import "XYNLog.h"
#import <objc/message.h>


@implementation XYNLog

+ (NSString *)logPrintWithModel:(NSObject *)model {
//    [[self alloc]init];
    // 初始化一个字典
    NSDictionary *dictionary = [XYNLog descriptionWithModel:model];
    return [NSString stringWithFormat:@"<%@: %p> --\n %@",[model class], model,[XYNLog logChineseByDic:dictionary]];

}
+ (NSString *)logChineseByDic:(NSDictionary *)dic; {
    NSString *desc = [NSString stringWithFormat:@"%@",dic];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}
+ (NSString *)logChineseByString:(NSString *)str {
    str = [NSString stringWithCString:[str cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return str;
}


+ (NSDictionary *)descriptionWithModel:(NSObject *)model {

    // 初始化一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    uint count;
    // 得到当前classs的所有成员属性，以及个数
    objc_property_t *properties = class_copyPropertyList([model class], &count);
//    // 获取类的所有成员变量
//    Ivar *members = class_copyIvarList([KVCObject class], &count);
//    const char *memberName = ivar_getName(i);
    for (int i = 0; i < count; i++) {
        // 循环并用kvc得到每个属性的值
        objc_property_t property = properties[i];
        // 获取属性名字
        NSString *name = @(property_getName(property));
        
        id value = [model valueForKey:name] ? : nil;  // 默认值为nil字符串
        
        if([value isKindOfClass:[NSArray class]] && [value count] > 0) {
            NSMutableArray *arr = [NSMutableArray array];
            for(int j = 0; j < [value count]; j++) {
                NSDictionary *sonDic = [XYNLog descriptionWithModel:value[j]];
                [arr addObject:sonDic];
            }
            value = arr;
        }
        
        //没有值的时候不打印属性
        if (value) {
            [dictionary setObject:value forKey:name];
        }
        
        
//        // 需要没有值的时候也打印
//        if([value isKindOfClass:[NSDictionary class]]) {
//            //获取属性类型
//            NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
//
//            NSRange rangeF = [propertyType rangeOfString:@"@\""];
//            NSRange rangeL = [propertyType rangeOfString:@"\","];
//            if(rangeF.location != NSNotFound && rangeL.location != NSNotFound) {
//                NSString *type = [propertyType substringWithRange:NSMakeRange(rangeF.length +rangeF.location, rangeL.location - rangeF.length - rangeF.location)];
//                Class sonClass = NSClassFromString(type);
//                NSObject *sonModel = [[sonClass alloc] init];
//                [sonModel setValuesForKeysWithDictionary:value];
//                NSDictionary *sonDic = [XYNLog descriptionWithModel:sonModel];
//                value = sonDic;
//            }
//        }
//        if(!value) {
//            //获取属性类型
//            NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
//            if([propertyType containsString:NSStringFromClass([NSArray class])] ||
//               [propertyType containsString:NSStringFromClass([NSMutableArray class])] ) {
//                value = [NSArray array];
//            }else if([propertyType containsString:NSStringFromClass([NSDictionary class])] ||
//                     [propertyType containsString:NSStringFromClass([NSMutableDictionary class])]) {
//                value = [NSDictionary dictionary];
//            }else {
//                //setObject不能设置nil
//                value = @"没有值";
//            }
//        }
//        [dictionary setObject:value forKey:name];
    }
    // 释放
    free(properties);
    return dictionary;
}

#pragma mark - NSlog输出打印模型
//- (NSString *)description {
//
//    // 初始化一个字典
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    // 得到当前classs的所有属性
//    uint count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i++) {
//        // 循环并用kvc得到每个属性的值
//        objc_property_t property = properties[i];
//        NSString *name = @(property_getName(property));
//        id value = [self valueForKey:name] ? : nil;  // 默认值为nil字符串
//        [dictionary setObject:value forKey:name];
//    }
//    // 释放
//    free(properties);
//    // return
//    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class], self, dictionary];
//}
//#pragma mark - po输出打印模型
//- (NSString *)debugDescription {
//    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]]) {
//        return  self.debugDescription;
//    }
//    // 初始化一个字典
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    // 得到当前classs的所有属性
//    uint count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i++) {
//        // 循环并用kvc得到每个属性的值
//        objc_property_t property = properties[i];
//        NSString *name = @(property_getName(property));
//        id value = [self valueForKey:name] ? : nil;  // 默认值为nil字符串
//        [dictionary setObject:value forKey:name];
//    }
//    // 释放
//    free(properties);
//    // return
//    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class], self, dictionary];
//}

@end
