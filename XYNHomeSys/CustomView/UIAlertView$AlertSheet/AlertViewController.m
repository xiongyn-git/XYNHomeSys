//
//  AlertViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/26.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统定位尚未打开，请到【设置-隐私-定位服务】中手动打开" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:alert completion:nil];
//        [self creatActionSheet];
//        NSLog(@"点击取消了");
//    }];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
    [self creatActionSheet];
}

-(void)creatActionSheet {
    /*
     先创建UIAlertController，preferredStyle：选择UIAlertControllerStyleActionSheet，这个就是相当于创建8.0版本之前的UIActionSheet；

     typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
     UIAlertControllerStyleActionSheet = 0,
     UIAlertControllerStyleAlert
     } NS_ENUM_AVAILABLE_IOS(8_0);
     */
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);

     */
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }];
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"destructive clicked");
    }];
    UIAlertAction* firstAction = [UIAlertAction actionWithTitle:@"使用相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用相机拍照");
    }];
    UIAlertAction* secondAction = [UIAlertAction actionWithTitle:@"使用相册照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用相册照片");
        }];
    [alert addAction:cancelAction];
    [alert addAction:firstAction];
    [alert addAction:destructiveAction];
    [alert addAction:secondAction];
    [self presentViewController:alert animated:YES completion:^{
        nil;
    }];
}


@end
