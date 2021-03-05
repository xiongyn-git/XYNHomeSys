//
//  GMTableViewDelegate.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import "GMTableViewDelegate.h"
 
@interface GMTableViewDelegate ()
 
@property (nonatomic, strong)UIView *headerV_section;
 
@property (nonatomic, strong)UIView *footerV_section;
 
@property (nonatomic, assign)CGFloat rowHeight;
 
@property (nonatomic, assign)CGFloat headerH_section;
 
@property (nonatomic, assign)CGFloat footerH_section;
 
@property (nonatomic, copy)GMTableViewDidSelectBlock didSelectBlock;
 
@end
 
@implementation GMTableViewDelegate
 
- (instancetype)init
{
    return nil;
}
 
- (id)initWithHeaderV_section:(UIView *)headerV footerV_section:(UIView *)footerV rowHeight:(CGFloat)rowH headerH_section:(CGFloat)headerH footerH_section:(CGFloat)footerH didSelectBlock:(GMTableViewDidSelectBlock)didSelectBlock
{
    self = [super init];
    if (self) {
        self.headerH_section = headerH;
        self.headerV_section = headerV;
        self.footerH_section = footerH;
        self.footerV_section = footerV;
        self.rowHeight       = rowH;
        self.didSelectBlock  = didSelectBlock;
    }
    return self;
}
 
#pragma mark - <delegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerH_section;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.footerH_section;
}
 
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    if (self.headerV_section) {
        self.headerV_section.frame = CGRectMake(0, 0, self.headerV_section.width, self.headerV_section.height);
        headerV.size = self.headerV_section.size;
        headerV.backgroundColor = [UIColor whiteColor];
        [headerV addSubview:self.headerV_section];
    }
    return headerV;
}
 
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerV = [[UIView alloc]init];
    if (self.footerV_section) {
        footerV = [self XC_copyAView:self.footerV_section];
    }
    return footerV;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelectBlock(tableView, indexPath);
}
 
 
///深复制UIView
- (UIView *)XC_copyAView:(UIView *)view
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
 
@end

