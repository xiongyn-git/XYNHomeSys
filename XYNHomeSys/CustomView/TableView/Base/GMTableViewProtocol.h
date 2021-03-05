//
//  GMTableViewProtocol.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
 
NS_ASSUME_NONNULL_BEGIN
 
typedef void (^TableViewCellConfigureBlock)(id cell, id items, NSIndexPath * indexPath);
 
@interface GMTableViewProtocol : NSObject<UITableViewDataSource>//UICollectionViewDataSource
 
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;
 
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
 
@end

NS_ASSUME_NONNULL_END
