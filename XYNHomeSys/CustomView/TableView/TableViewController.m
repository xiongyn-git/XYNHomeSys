//
//  TableViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import "TableViewController.h"
#import "FirstCell.h"
#import "UIView+Frame.h"
#import "Masonry.h"
#import "MJRefresh.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy)NSMutableArray *dataArr;
@property (nonatomic, weak)UITableView *tabView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}

- (void)addTableView {
 
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    
    [tabView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FirstCell class])];
    tabView.rowHeight = 60;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.delegate = self;
    tabView.dataSource = self;
//    tabView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tabView];
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kScreenHeight);
    }];
    self.tabView = tabView;
    
    
    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshTableView];
    }];
    [self.tabView.mj_header beginRefreshing];
    self.tabView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refreshTableView];
    }];
    [self.tabView.mj_footer resetNoMoreData];
}

- (void)refreshTableView {
    if([self.tabView.mj_header isRefreshing]) {
        //    page = 1;
            [self net];
    }
    if([self.tabView.mj_footer isRefreshing]) {
        //    page++;
            [self net];
    }
}
- (void)endRefresh {
    if([self.tabView.mj_header isRefreshing]) {
        [self.tabView.mj_header endRefreshing];
    }
    if([self.tabView.mj_footer isRefreshing]) {
        [self.tabView.mj_footer endRefreshingWithNoMoreData];

//        [self.tabView.mj_footer endRefreshing];
    }
}
- (void)net {
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    sleep(2);
    [manage GET:@"" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self endRefresh];
//            if(page <= 1) {
//                self.dataArr = [FirstModel arrayOfModelsFromDictionaries:responseObject[data] error:nil];
//            }else {
//                NSArray *arr = [FirstModel arrayOfModelsFromDictionaries:responseObject[data] error:nil];
//                [self.dataArr addObjectsFromArray:arr];
//            }
            [self.tabView reloadData];
            [self.tabView.mj_footer resetNoMoreData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self endRefresh];
            
            
        }];
}

#pragma mark - tableview datasounce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArr.count;
    return self.dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FirstCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadModel:self.dataArr[indexPath.row]];
    __weak typeof(self) weakSelf = self;
    cell.appendBlock = ^(NSString * _Nonnull str) {
        FirstModel * model = weakSelf.dataArr[indexPath.row];
        model.name = [NSString stringWithFormat:@"%@%@",model.name,str];
        [weakSelf.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        [tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstModel * model = self.dataArr[indexPath.row];
    
    CGRect rect =[model.name boundingRectWithSize:CGSizeMake(kScreenWidth - 120, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height + 40;
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - lasy
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
        FirstModel *model = [[FirstModel alloc] init];
        model.name = @"李焕英";
        model.appendStr = @"上映大卖";
        [_dataArr addObject:model];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        [_dataArr addObject:[model copy]];
        FirstModel *model2 = [[FirstModel alloc] init];
        model2.name = @"唐人街探案3";
        model2.appendStr = @"再接再厉";
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];
        [_dataArr addObject:[model2 copy]];

    }
    return _dataArr;
}




@end
