//
//  KVCObject.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/20.
//

#import <Foundation/Foundation.h>
#import "BankObject.h"
#import "XYNLog.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVCObject : NSObject
{
    NSString * memberPublic;
}

@property (nonatomic, copy)BankObject *test;
@property (nonatomic, copy)NSString *propertyPublic;
@property (nonatomic, strong) BankObject *model;
@property (nonatomic, strong)NSArray<BankObject *>  *modelList;
- (id)initWithDic:(NSDictionary *)modelDic;

@end

NS_ASSUME_NONNULL_END
