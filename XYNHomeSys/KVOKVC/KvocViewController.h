//
//  kvocViewController.h
//  XYNHomeSys
//
//  1、测试不安全的kvo，以及实现安全kvo封装
//  2、kvo手动通知
//
//  Created by xyn on 2021/2/19.
//

//封装见https://www.jianshu.com/p/f8bb89aad2df

#import <UIKit/UIKit.h>
#import "BankObject.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^KvoDeallocTestBlock)(BankObject * obj);

@interface KvocViewController : UIViewController

@property (nonatomic, copy) KvoDeallocTestBlock block;


@end

NS_ASSUME_NONNULL_END
