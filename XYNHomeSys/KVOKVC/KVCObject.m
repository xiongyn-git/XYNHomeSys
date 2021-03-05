//
//  KVCObject.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/20.
//

#import "KVCObject.h"

@interface KVCObject ()
{
    NSString * memberPrivate;
}
@property (nonatomic, copy)NSString *propertyPrivate;


@end

@implementation KVCObject

#pragma mark - 重写kvc方法
/**
 KVC机制会检查+ (BOOL)accessInstanceVariablesDirectly方法有没有返回YES，
 默认该方法会返回YES，如果你重写了该方法让其返回NO的话，
 那么在这一步KVC会执行setValue：forUndefinedKey：方法
 */
//+(BOOL)accessInstanceVariablesDirectly {
//    return NO;;
//}
//
////成员变量才有用
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//
//}
//
//- (id)valueForUndefinedKey:(NSString *)key {
//    return @"1";
//}




- (void) setValue:(id)value forKey:(NSString*)key{
    if ([value isKindOfClass:[NSNull class]]) {
        value=nil;
    } else if ([key isEqualToString:@"mobile"])  {
        //去空格
        NSArray *arr = [(NSString*)value componentsSeparatedByString:@"-"];
        value = [arr componentsJoinedByString:@""];
    } else if ([key isEqualToString:@"model"]) {
        BankObject *model = [[BankObject alloc] init];
        [model setValuesForKeysWithDictionary:value];


    } else if([key isEqualToString:@"modelList"]) {
        
        NSMutableArray * valueArr = [[NSMutableArray alloc] init];
        if([value isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray*)value;
            for (int i = 0; i < arr.count; i++)  {
                NSDictionary* dic  =  arr[i];
                BankObject *model = [[BankObject alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [valueArr addObject:model];
            }
        }
        value = valueArr;
    } else {
        // 将所有的Number数据类型转换为字符串
        value = [NSString stringWithFormat:@"%@",value];
    }
    [super setValue:value forKey:key];
}

// 对特殊字符 id 进行处理
- (void) setValue:(id)value forUndefinedKey:(NSString*)key {
    NSLog(@"Undefined Key: %@", key);
    if([key isEqual:@"public"]) {
        [self setValue:value forKey:@"propertyPublic"];
    }
}

// 字典转模型
- (id)initWithDic:(NSDictionary *)modelDic{

    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:modelDic];
    }
    return self;

}



@end
