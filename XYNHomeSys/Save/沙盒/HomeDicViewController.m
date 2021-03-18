//
//  HomeDicViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//

#import "HomeDicViewController.h"

@interface HomeDicViewController ()

@end

@implementation HomeDicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //应用程序的程序包目录。
    //由于应用程序必须经过签名，所以不能在运行时对这个目录中的内容进行修改，否则会导致应用程序无法启动。
    //获取包文件 [mainBundle pathForResource:@"logo" ofType:@"png"];
    NSLog(@"bundlePath:%@",[[NSBundle mainBundle] bundlePath]);

    //获取程序的根目录（home）目录
    NSString *homePath = NSHomeDirectory();
    
    //获取Document目录
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [documentPaths lastObject];
    
    //获取Library目录
    //Library/Preferences 保存应用程序的偏好设置文件（使用 NSUserDefaults 类设置时创建，不应该手动创建）。
    //Library/Caches 保存应用程序使用时产生的支持文件和缓存文件，还有日志文件最好也放在这个目录。iTunes 同步时不会备份该目录。
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libraryPaths lastObject];

    //获取Library中的Cache
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths lastObject];

    //获取tmp路径，保存应用运行时所需要的临时数据，iphone 重启时，会清除该目录下所有文件。
    NSString *temp = NSTemporaryDirectory();
    NSLog(@"homePath:%@\ndocPath:%@\nlibPath:%@\ncachePath:%@\ntemp:%@",homePath, docPath, libPath, cachePath, temp);

    [self editPathString];
}
#pragma mark - pathComponent常用操作-文件路径的处理
- (void)editPathString {
    NSString *path = @"/Uesrs/apple/testfile.txt";
    //获得组成此路径的各个组成部分，结果：（"/","User","apple","testfile.txt"）
    NSArray * pathComponents = [path pathComponents];
    //提取路径的最后一个组成部分，结果：testfile.txt
    NSString * lastPathComponent = [path lastPathComponent];
    //删除路径的最后一个组成部分，结果：/Users/apple
    NSString * delPath = [path stringByDeletingLastPathComponent];
    //将path添加到先邮路径的末尾，结果：/Users/apple/testfile.txt/app.txt
    NSString * appendPath = [path stringByAppendingPathComponent:@"app.txt"];
    //取路径最后部分的扩展名，结果：txt
    NSString * pathExtension = [path pathExtension];
    //删除路径最后部分的扩展名，结果：/Users/apple/testfile
    NSString * delPathExtension = [path stringByDeletingPathExtension];
    //路径最后部分追加扩展名，结果：/User/apple/testfile.txt.api
    NSString * appendPathExtension = [path stringByAppendingPathExtension:@"api"];
    NSLog(@"path:%@\npathComponents:%@\nlastPathComponent:%@\ndelPath:%@\nappendPath:%@\npathExtension:%@\ndelPathExtension:%@\nappendPathExtension:%@\n",path,pathComponents,lastPathComponent,delPath,appendPath,pathExtension,delPathExtension,appendPathExtension);
}

@end
