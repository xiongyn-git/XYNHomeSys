//
//  FirstModel.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstModel : JSONModel

@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * appendStr;

@end

NS_ASSUME_NONNULL_END
