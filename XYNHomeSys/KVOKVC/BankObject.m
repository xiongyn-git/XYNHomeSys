//
//  BankObject.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/19.
//

#import "BankObject.h"

@interface BankObject()
@property (nonatomic, copy) NSString * accountForBank;


@end

@implementation BankObject

#pragma mark - kvo手动通知，需要先取消自动通知
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    BOOL automatic = YES;
        if ([key isEqualToString:NSStringFromSelector(@selector(accountName))]) {
            automatic = NO;
        } else {
            automatic = [super automaticallyNotifiesObserversForKey:key];
        }
        return automatic;
}

#pragma mark - kvo:关联属性-手动通知
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
     NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:NSStringFromSelector(@selector(accountForBank))]) {
        /**
            关联通知：
            增加accountForBank的变化因素：accountName、bankName
         */
        keyPaths = [keyPaths setByAddingObjectsFromArray:@[NSStringFromSelector(@selector(accountName)), NSStringFromSelector(@selector(bankName))]];
    }
    return keyPaths;
}


#pragma mark - kvo：getter、setter方法重写
//accountForBank随另外两个参数变换而变化
- (NSString *)accountForBank {
    return [NSString stringWithFormat:@"%@ for %@",self.accountName,self.bankName];
}

//发送手动通知willChangeValueForKey：didChangeValueForKey：
- (void)setAccountName:(NSString *)accountName {
    //保持不重复
    if(accountName != _accountName) {
        //手动通知，将要改变值
        [self willChangeValueForKey:NSStringFromSelector(@selector(accountName))];
        _accountName = accountName;
        //手动通知，已经改变值
        [self didChangeValueForKey:NSStringFromSelector(@selector(accountName))];
    }
}


#pragma mark - 测试kvc模型解析、模型打印
- (void) setValue:(id)value forKey:(NSString*)key{
    
    if ([key isEqualToString:@"sonModel"]) {
        BankObject *model = [[BankObject alloc] init];
        [model setValuesForKeysWithDictionary:value];
    }else if([key isEqualToString:@"sonModelList"]) {
        
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
    }
    [super setValue:value forKey:key];
}

@end
