//
//  MQTTManager.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQTTManager : NSObject
+ (instancetype)share;
- (void)connect;
- (void)disConnect;
- (void)sendMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
