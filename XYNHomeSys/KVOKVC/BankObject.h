//
//  BankObject.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankObject : NSObject

@property (nonatomic, copy) NSString * bankName;
@property (nonatomic, copy) NSString * accountName;
@property (nonatomic, strong) BankObject *sonModel;
@property (nonatomic, strong)NSArray<BankObject *>  *sonModelList;


@end


NS_ASSUME_NONNULL_END
