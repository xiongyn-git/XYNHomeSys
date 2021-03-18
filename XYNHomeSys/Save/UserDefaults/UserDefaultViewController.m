//
//  UserDefaultViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/13.
//

#import "UserDefaultViewController.h"
#import "UserModel.h"
#import "HomeDicViewController.h"


@interface UserDefaultViewController ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation UserDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self savetoUserDefault];
    [self getInfo];
}

- (void)savetoUserDefault {
    /*
     1、支持NSString、 NSNumber、NSDate、NSArray、NSDictionary、BOOL、NSInteger、NSFloat等系统定义的数据类型
     */
    [self.userDefaults setValue:@"XYN" forKey:@"name"];
    [self.userDefaults setValue:@[@{@"1":@"2"},@"2"] forKey:@"array"];
    NSMutableArray * muArr = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
    [muArr addObject:@"3"];
    [self.userDefaults setValue:muArr forKey:@"muArr"];
    [self.userDefaults setValue:@{@"1":muArr} forKey:@"dic"];
    
    /*
     2、如果要存放其他数据类型或者自定义的对象,
        *必须将其转换成 NSData 存储,
        *自定义对象的归档时需要实现NSCoding、NSSecureCoding协议
        *NSSecureCoding协议在之前基础上添加转换类型，不匹配，会报数据被篡改的错误
     */
    UserModel *model = [[UserModel alloc] init];
    model.name = @"王";
    model.age = 27;
    NSError *error;
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:&error];
    [self.userDefaults setValue:data forKey:@"model"];
    
    //它是定时把缓存中的数据写入磁盘的，非即时，为了防止在写完NSUserDefaults后程序退出导致的数据丢失
    //可以在写入数据后使用synchronize强制立即将数据写入磁盘
    [self.userDefaults synchronize];
}
- (void)getInfo {
    NSString *name = [self.userDefaults valueForKey:@"name"];
    NSArray *arr = [self.userDefaults valueForKey:@"array"];
    //可变取出来变成不可变
    NSMutableArray *muArr = [[self.userDefaults valueForKey:@"muArr"] mutableCopy];
    [muArr addObject:@"4"];
    NSDictionary *dic = [self.userDefaults valueForKey:@"dic"];
    NSData *modelData = [self.userDefaults valueForKey:@"model"];
    UserModel *model = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserModel class] fromData:modelData error:nil];
    NSLog(@"name:%@\narray:%@\nmuArr:%@\ndic:%@\nmodel:%@",name,arr,muArr,dic,[XYNLog logPrintWithModel:model]);
}

- (NSUserDefaults *)userDefaults {
    if(!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}
- (IBAction)toHomeDic:(id)sender {
    HomeDicViewController *vc= [[HomeDicViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
