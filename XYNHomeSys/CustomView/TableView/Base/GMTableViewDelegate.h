//
//  GMTableViewDelegate.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
 
NS_ASSUME_NONNULL_BEGIN
 
typedef void(^GMTableViewDidSelectBlock)(UITableView *GMTableView, NSIndexPath *GMIndexPath);
 
@interface GMTableViewDelegate : NSObject<UITableViewDelegate>
 
- (id)initWithHeaderV_section:(UIView *_Nullable)headerV footerV_section:(UIView *_Nullable)footerV rowHeight:(CGFloat)rowH headerH_section:(CGFloat)headerH footerH_section:(CGFloat)footerH didSelectBlock:(GMTableViewDidSelectBlock)didSelectBlock;
 
@end

NS_ASSUME_NONNULL_END
