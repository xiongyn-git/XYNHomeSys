//
//  YYImageViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//

#import "YYImageViewController.h"
#import <YYKit.h>
///UIImageView+YYWebImage

@interface YYImageViewController ()

@end

@implementation YYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self cache];
    [self image];
}

- (void)image {
    
    NSURL *url = [NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg"];
    //@"https://upload-images.jianshu.io/upload_images/1747081-4e5000cdf6dccd69.gif"
    //加载image
//    YYImage *image = [YYImage imagew];

    //创建ImageView
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
//    [imageView setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    [imageView setImageWithURL:url placeholder:nil options:YYWebImageOptionShowNetworkActivity progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 计算进度
        float progress = (float)receivedSize/expectedSize;
        NSLog(@"%f",progress);
    } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return image;
//        return [image imageByResizeToSize:CGSizeMake(image.size.width * 0.6, image.size.height * 0.6) contentMode:UIViewContentModeCenter];
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
        // 测试 : 是否是从磁盘加载的
        if (from == YYWebImageFromDiskCache) {
            NSLog(@"load from disk cache");
        }
    }];
    

    //YYAdd中的拓展UIView方法
    imageView.size = CGSizeMake(300, 200);
    imageView.top = 80;
    imageView.centerX = self.view.width / 2;
    [self.view addSubview:imageView];
}

- (void)cache {
 
    // 获取缓存管理类
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
 
    // 获取内存缓存大小
    NSInteger memCost = cache.memoryCache.totalCost/1024;
    // 获取内存缓存个数
    NSInteger memCount = cache.memoryCache.totalCount;
    // 获取磁盘缓存大小
    NSInteger diskCost = cache.diskCache.totalCost/1024;
    // 获取磁盘缓存个数
    NSInteger diskCount = cache.diskCache.totalCount;
 
    // 清空缓存内存缓存
    [cache.memoryCache removeAllObjects];
    // 清空磁盘缓存
    [cache.diskCache removeAllObjects];
    
    // 清空磁盘缓存，带进度回调
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
    // progress
    } endBlock:^(BOOL error) {
    // end
    }];
}
 
 

@end
