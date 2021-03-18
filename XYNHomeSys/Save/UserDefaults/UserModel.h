//
//  UserModel.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property (class, readonly) BOOL supportsSecureCoding;

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
