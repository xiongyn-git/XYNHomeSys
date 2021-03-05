//
//  FirstCell.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstCell : UITableViewCell

@property (nonatomic, copy) void(^appendBlock)(NSString * str);
- (void)loadModel:(FirstModel *)model;


@end

NS_ASSUME_NONNULL_END
