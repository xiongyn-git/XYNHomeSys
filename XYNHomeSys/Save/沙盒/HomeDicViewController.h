//
//  HomeDicViewController.h
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//

#import <UIKit/UIKit.h>

/**
 iOS应用程序只能对自己创建的文件系统读取文件，这个独立、封闭、安全的空间，叫做沙盒。
 它一般存放着程序包文件（可执行文件）、图片、音频、视频、plist文件、sqlite数据库以及其他文件。
 每个应用程序都有自己的独立的存储空间（沙盒）
 一般来说应用程序之间是不可以互相访问
  
 当我们创建应用程序时，在每个沙盒中含有三个文件，分别是Document、Library和temp。
 Document：一般需要持久的数据都放在此目录中，可以在当中添加子文件夹，iTunes备份和恢复的时候，会包括此目录。
 Library：设置程序的默认设置和其他状态信息
 temp：创建临时文件的目录，当iOS设备重启时，文件会被自动清除

 */

NS_ASSUME_NONNULL_BEGIN

@interface HomeDicViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
