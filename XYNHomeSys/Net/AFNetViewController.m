//
//  AFNetViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/18.
//

#import "AFNetViewController.h"



@interface AFNetViewController ()
<NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>
//NSURLSessionDownloadDelegate
@property (nonatomic, assign)long totalSize;
@property (nonatomic, assign)long currentSize;
@property (nonatomic, strong) NSFileHandle *fileHandle;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation AFNetViewController

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downloadFileWithURLSession];
//    [self getAFNetworking];
}


#pragma mark - AFNetworking
- (void)testAFNetworing {
    NSURL *baseUrl = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //[AFHTTPSessionManager manager]; manager方法使用的Configuration：defaultSessionConfiguration
    
    //+"defaultSessionConfiguration"返回标准配置，这实际上与NSURLConnection的网络协议栈是一样的，具有相同的共享NSHTTPCookieStorage，共享NSURLCache和共享NSURLCredentialStorage。
    //+"ephemeralSessionConfiguration"返回一个预设配置，没有持久性存储的缓存，Cookie或证书。这对于实现像"秘密浏览"功能的功能来说，是很理想的。
    //+"backgroundSessionConfiguration"：独特之处在于，它会创建一个后台会话。后台会话不同于常规的，普通的会话，它甚至可以在应用程序挂起，退出，崩溃的情况下运行上传和下载任务。初始化时指定的标识符，被用于向任何可能在进程外恢复后台传输的守护进程提供上下文。
    /*
     default:   缓存的文件存到磁盘中(一般)
     
     ephemeral: 缓存的文件存到内存
     
     background:启动后台线程执行task
     
     */
    NSURLSessionConfiguration *ephemeralSessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    ephemeralSessionConfig.URLCache;
    //    NSURLRequestUseProtocolCachePolicy = 0,
    //    NSURLRequestReloadIgnoringLocalCacheData = 1,
    //    NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4,
    //    NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
    //    NSURLRequestReturnCacheDataElseLoad = 2,
    //    NSURLRequestReturnCacheDataDontLoad = 3,
    //    NSURLRequestReloadRevalidatingCacheData = 5,
    ephemeralSessionConfig.requestCachePolicy;
    
    
    NSURLSessionConfiguration *backgroundSessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"af1"];
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:<#(nullable NSURLSessionConfiguration *)#>];
}
#pragma mark - AF-Get
- (void)getAFNetworking {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //给NSURLRequest设置键值
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *url = @"http://apis.juhe.cn/ip/ip2addr?ip=www.juhe.cn";
    [manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
}
- (void)postAFNetworking {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
    
    [manager.requestSerializer setValue:@"application/json;UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = @"http://xxx/app/user/login";
    NSDictionary *parameters = @{@"mobile":@"18672788083",
                                 @"password": @"password",
                                 @"DToken": @"537e8678186"};
    
#pragma mark - AF-post
    [manager POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印进度
        NSLog(@"%lf",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
#pragma mark - AF-上传
    [manager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传图片参数
        UIImage *iamge = [UIImage imageNamed:@"123.png"];
        NSData *data = UIImagePNGRepresentation(iamge);
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        
        //上传文件
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
}

#pragma mark - AF-下载
- (void)uploadAFNetworking {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:@""];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
    }];
    
    //开始启动任务
    [task resume];
}
#pragma mark - AF-网络监测
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;
}


#pragma mark - NSURLSession
- (void)testNSURLSession {
    //1.NSURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg"]];
    NSDictionary *headers = @{@"key":@"value"};
    //有header的情况，相当于给request设置键值
    for(NSString * key in headers.allKeys) {
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    // 请求方式
    request.HTTPMethod = @"POST";
    // 请求体
    NSDictionary *dic = @{@"UserName":@"qdx", @"UserPwd":@"123"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    
    //2.configuration对象
    /*default:   缓存的文件存到磁盘中，下载文件会保存在沙盒的tmp文件下，如果在回调方法中，不做任何处理，下载的文件会被删除
     ephemeral: 缓存的文件存到内存
     background: 启动后台线程执行task
     */
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //3.创建session对象
    //实现代理<NSURLSessionDataDelegate>
    /*delegateQueue:nil -> 非主队列(子线程)
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    //4.数据任务,代理
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    //5.执行
    [task resume];
    
#pragma mark - NSURLSession-block
    //普通请求,也可以小文件下载，如图片
    NSURLSessionDataTask *taskBlock = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //回到主线程刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIImage imageWithData:data];
        });
    }];
    [taskBlock resume];
    //上传
    NSDate *datas = [NSDate date];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:datas completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [uploadTask resume];
    NSURL *file = [NSURL fileURLWithPath:@"dsd"];
    NSURLSessionUploadTask *uploadTask2 = [session uploadTaskWithRequest:request fromFile:file completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [uploadTask2 resume];
    
    
    
}
#pragma mark - urlsession下载
- (void)downloadFileWithURLSession {
    //1 确定资源路径
    NSURL *url = [NSURL URLWithString:@"https://meiye-mbs.oss-cn-shenzhen.aliyuncs.com/mbsFiles/0e3d0e4a0d5d4da5963e9e7617e8de101565841097849.mp4"];
    //2 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3 创建会话对象:线程不传，默认在子线程中处理
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //4 创建下载请求Task
#pragma mark - 代理的方式能监听下载进度，不会将数据写入缓存，所以适合大文件，而block的方式将数据写入缓存，不适合大文件下载
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",location);//tmp路径
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // response.suggestedFilename ： 建议的文件名
//        NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
//        // 将临时文件move或者copy 到Caches文件夹
//        // AtPath : 剪切前的文件路径  ToPath : 剪切后的文件路径
//        [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:file error:nil];
//
//
//    }];
    //5 发送请求
    [dataTask resume];
//    [downloadTask resume];
}

#pragma mark - NSURLSessionDataDelegate
//1 接收到响应的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //得到文件的名称：得到请求的响应头信息，获取响应头信息中推荐的文件名称
    NSString *fileName = [response suggestedFilename];
    //拼接文件的存储路径（沙盒路径Cache + 文件名）
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //下载的路径
    NSString *fullPath = [cache stringByAppendingPathComponent:fileName];
    _videoUrl = fullPath;
    //(1)创建空的文件
    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil];
    //(2)创建文件句柄指针指向文件
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
    
    //得到本次请求的文件数据大小
    self.totalSize = response.expectedContentLength;
    
    //告诉系统应该接收数据
    completionHandler(NSURLSessionResponseAllow);
}

//2 接收到服务器返回数据的时候调用，可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    //写入文件
    [self.fileHandle writeData:data];
    
    //计算文件的下载进度并显示= 已经下载的数据/文件的总大小
    self.currentSize += data.length;
    CGFloat progress = 1.0 * self.currentSize / self.totalSize;
    self.progressView.progress = progress;
    NSLog(@"%f", progress);
}
//3 下载完成或者失败的时候调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    //(4)当所有的数据写完，应该关闭句柄指针
    [self.fileHandle closeFile];
}
#pragma mark - 断点续传-下载
//- (void) pause{
//    //暂停
//    NSLog(@"暂停下载");
//    [_task cancelByProducingResumeData:^(NSData *resumeData) {
//        _data=resumeData;
//    }];
//    _task=nil;
//
//}
//- (void) resume{
//    //恢复
//     NSLog(@"恢复下载");
//    if(!_data){
//        NSURL *url=[NSURL URLWithString:@src];
//        _request=[NSURLRequest requestWithURL:url]；
//        _task=[_session downloadTaskWithRequest:_request];
//
//    }else{
//        _task=[_session downloadTaskWithResumeData:_data];
//    }
//    [_task resume];
//}


#pragma mark - test加载下载视频
- (void)testDownloadMv {
    //播放地址
//    _videoUrl = @"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    //初始化视频播放器控制器
    _playerVC = [[AVPlayerViewController alloc] init];
    //初始化播放器
    _playerVC.player = [AVPlayer playerWithURL:[_videoUrl hasPrefix:@"http"] ? [NSURL URLWithString:_videoUrl]:[NSURL fileURLWithPath:_videoUrl]];
    //设置视频图像位置和大小
    _playerVC.view.frame = self.view.bounds;
    //显示播放控制按钮
    _playerVC.showsPlaybackControls = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(stopVc)];
    
//    _playerVC.navigationItem.backBarButtonItem =
    
//    [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(stopVc)];
    //self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
    //self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
    [self.view addSubview:_playerVC.view];
    
    //加载好之后，播放
    if (_playerVC.readyForDisplay) {
        [_playerVC.player play];
    }
}
- (IBAction)playerMv:(id)sender {
    //加载视频
    [self testDownloadMv];
}

@end
