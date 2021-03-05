//
//  GMTableViewProtocol.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//


#import "GMTableViewProtocol.h"
 
@interface GMTableViewProtocol ()
 
@property(nonatomic, strong) NSArray* items;/**< array */
@property(nonatomic, copy) NSString* cellIdentifier;/**< cellIdentifier */
@property(nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;/**< block */
 
@end
 
@implementation GMTableViewProtocol
 
- (instancetype)init {
    return  nil;
}
 
- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return  self;
}
 
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isDoubleDimensionalArray]) {
        NSArray *sectionArr = self.items[indexPath.section];
        return sectionArr.count > indexPath.row ? sectionArr[(NSUInteger) indexPath.row] : 0;
    }else{
        return self.items.count > indexPath.section ? self.items[(NSUInteger) indexPath.section] : 0;
    }
}
 
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count > 0 ? self.items.count : 0;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self isDoubleDimensionalArray]) {
        NSArray *sectionArr = self.items[section];
        return sectionArr.count;
    }else{
        return 1;
    }
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}
 
///判断数组是否为二维数组
- (BOOL)isDoubleDimensionalArray
{
    if (self.items.count == 0) return NO;
    if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        return YES;
    }else{
        return NO;
    }
}
 
@end


