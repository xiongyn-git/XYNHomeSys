//
//  ScoketViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/7.
//

#import "ScoketViewController.h"
#import "GCDSocketManager.h"
#import "RocketSocketManager.h"

@interface ScoketViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *msg;

@end

@implementation ScoketViewController

- (void)viewDidLoad {
    //开源一款 IM UI组件:ChatKit-OC
    //https://www.jianshu.com/p/4818009fcebf
    [super viewDidLoad];
    [self.msg setText:@"dsdada"];
    [self.msg becomeFirstResponder];;
    self.msg.delegate = self;
    [[RocketSocketManager share] connect];

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 此处编写弹出日期选择器的代码。
    NSLog(@"hahah");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)sendMag:(id)sender {
//    [[RocketSocketManager share] ping];

    [[RocketSocketManager share] sendMsg:self.msg.text];
//    BOOL sta = [[GCDSocketManager cocoaAsync_share] cocoaAsync_connect];
//    if(sta) {
//        [[GCDSocketManager cocoaAsync_share] cocoaAsync_sendMsg:self.msg.text];
//    }
}


@end
