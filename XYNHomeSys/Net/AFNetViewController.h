//
//  AFNetViewController.h
//  XYNHomeSys
//
//  Created by xyn on 2021/2/18.
//

#import <UIKit/UIKit.h>
//iOS官方播放器头文件
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFNetViewController : UIViewController
{
    //定义一个播放器
    AVPlayerViewController* _playerVC;
    //播放地址字符串
    NSString* _videoUrl;
}
@end

NS_ASSUME_NONNULL_END
