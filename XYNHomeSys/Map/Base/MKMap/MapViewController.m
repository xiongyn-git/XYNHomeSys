//
//  MapViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/24.
//

#import "MapViewController.h"
#import "Toast.h"
#import "XYNAnnotation.h"
#import "UIView+Toast.h"
#import "XYNToastManager.h"

//#import "MapAnnotation.h"

@interface MapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *weidu;
@property (weak, nonatomic) IBOutlet UITextField *jingdu;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D location2D;
@end

@implementation MapViewController

-(CLLocationManager *)locationManager{
    
    if (!_locationManager) {
        // 创建CoreLocation管理对象
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        // 定位权限检查
        [locationManager requestWhenInUseAuthorization];
        // 设定定位精准度
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // 设置代理
        locationManager.delegate = self;
        //设置最佳经度
        locationManager.desiredAccuracy =kCLLocationAccuracyBest;
        //位置过滤:10m更新一次
        locationManager.distanceFilter = 10.0;
        
        _locationManager = locationManager;
    }
    return _locationManager;
    
}
#pragma mark - delegate定位权限检查
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
            //==1. 用户还没有关于这个应用程序做出了选择
        case kCLAuthorizationStatusNotDetermined:{
            NSLog(@"用户还未决定授权");
            // 主动获得授权
            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
            //==2. 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            // 主动获得授权
            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
            //==3. 用户已经明确拒绝了这个应用程序访问权限
        case kCLAuthorizationStatusDenied:{
            // 此时使用主动获取方法也不能申请定位权限
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
            //一直允许获取定位
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"获得前后台授权");
//            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
            //在使用时允许获取定位
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            NSLog(@"获得前台授权");
//            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
        default:
            break;
    }
}
#pragma mark - delegate获取位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation * newLocation = [locations lastObject];
    // 判空处理
    if (newLocation.horizontalAccuracy < 0) {
        NSLog(@"定位失败，请检查手机网络以及定位");
        return;
    }
    //停止定位
    [self.locationManager stopUpdatingLocation];
    // 获取定位经纬度
    self.location2D = newLocation.coordinate;
    NSLog(@"纬度为:%f, 经度为:%f", self.location2D.latitude, self.location2D.longitude);
    [self locationWith2D:self.location2D];
    
    // 创建编码对象，获取所在城市
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反地理编码
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        // 获取地标
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"获取地标 = %@,",placeMark.locality);
    }];
    
}
#pragma mark - delegate定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //     NSLog(@"定位失败,请检查手机网络以及定位");
}
#pragma mark - cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    XYNToastManager *a = [XYNToastManager manager];
//    XYNToastManager *b = [[XYNToastManager alloc] init];
//    [[Toast sharedSingleton] makeToast:@"王茹涛大傻逼王大傻逼" duration:3];
//    CFRunLoopRun();
//
//    [[Toast sharedSingleton] makeToast:@"王aaaaa" duration:10];
//    CFRunLoopRun();
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = @"cdsfdsds";
//    lab.size = CGSizeMake(100, 30);
//    [[[UIApplication sharedApplication] keyWindow] cs_showToast:lab duration:3.0 position:CSToastPositionBottom];
//
//    UILabel *l = [[UILabel alloc] init];
//    l.size = CGSizeMake(100, 30);
//    l.text = @"王茹涛";
//    [[[UIApplication sharedApplication] keyWindow] cs_showToast:l duration:2.0 position:CSToastPositionBottom];

    
    
    
//    可以通过直接在 info.plist 中添加 NSLocationDefaultAccuracyReduced 为 true 默认请求大概位置。
//    这样设置之后，即使用户想要为该 App 开启精确定位权限，也无法开启。
//    CLAccuracyAuthorization accuracy = self.locationManager.accuracyAuthorization;
//    typedef NS_ENUM(NSInteger, CLAccuracyAuthorization) {
//        CLAccuracyAuthorizationFullAccuracy, //精准定位
//        CLAccuracyAuthorizationReducedAccuracy, // 模糊定位
//    };
    
    //可以直接通过API来根据不同的需求设置不同的定位精确度
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    

    BOOL enable = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    //kCLAuthorizationStatusDenied 用户拒绝
    if(enable && status != kCLAuthorizationStatusDenied) {
        // 开启定位
        [self.locationManager startUpdatingLocation];
//        [self.locationManager startMonitoringVisits];

    }else {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统定位尚未打开，请到【设置-隐私-定位服务】中手动打开" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"系统定位尚未打开，是否去开启？" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消了");
//            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定了");
            NSURL *url = [NSURL URLWithString:@"app-settings:"];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    if (!success) {
                        
                        UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"不能完成跳转" message:@"请确认App已经安装" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
                        [aler addAction:cancelAction];
                        [self presentViewController:aler animated:YES completion:nil];
                        
                    }
//                    else if(back){
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
                }];
            }

        }];
        [alert addAction:defaultAction1];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }


    /**类型
     
     MKMapTypeStandard = 0,可映射类型标准
     MKMapTypeSatellite,  可映射类型卫星
     MKMapTypeHybrid,  可映射类型混合(普通地图覆盖于卫星云图之上)
     MKMapTypeSatelliteFlyover MK地图类型的国家立交桥(3D 立体卫星)
     MKMapTypeHybridFlyover    MK地图型混合飞行(3D 立体混合)
     */
    //设置地图的显示风格
    self.mapView.mapType = MKMapTypeStandard;
    //设置地图可缩放
    self.mapView.zoomEnabled = YES;
    //设置地图可滚动
    self.mapView.scrollEnabled = YES;
    //设置地图可旋转
    self.mapView.rotateEnabled = NO;
    //设置显示用户当前位置
    self.mapView.showsUserLocation = YES;
    //为mapView设置代理
    self.mapView.delegate = self;
    if(self.location2D.latitude == 0) {
        CLLocationCoordinate2D location2D = {23.126272, 113.395568};
        [self locationWith2D: location2D];
    }
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.mapView addGestureRecognizer:longPress];
    
    
    NSLog(@"用户当前是否位于地图中：%d" , self.mapView.userLocationVisible);
    
    
}

#pragma  mark -- 长按手势Action
-(void)longPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
    //获取点位置
    CGPoint point = [longPress locationInView:self.mapView];
    //将点位置转换成经纬度坐标
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    //在该点添加一个大头针(标注)
    MKPointAnnotation *pointAnn = [[MKPointAnnotation alloc] init];
    pointAnn.coordinate = coordinate;
    pointAnn.title = @"长按的大头针";
    pointAnn.subtitle = @"副标题";
    
    [self.mapView addAnnotation:pointAnn];
}

- (void)currentLocation {
    //    CLLocationManager *manager = [];
}

- (IBAction)gogogo:(id)sender {
    
    //关闭两个文本框的虚拟键盘
    [self.weidu resignFirstResponder];
    [self.jingdu resignFirstResponder];
    NSString* latitudeStr = self.weidu.text;
    NSString* longtitudeStr = self.jingdu.text;
    
    //如果用户输入的经纬度不为空
    if (latitudeStr != nil && latitudeStr.length > 0 && longtitudeStr != nil && longtitudeStr.length > 0) {
        double latitude = latitudeStr.doubleValue;
        double longitude = longtitudeStr.doubleValue;
        CLLocationCoordinate2D center = {latitude, longitude};
        //        self.location2D = center;
        // 调用自己实现的方法设置地图的显示位置和显示区域
        [self locationWith2D: center];
    }
}

-(void)locationWith2D:(CLLocationCoordinate2D)location2D {
    
    // 也可以使用如下方式设置经、纬度
    //location2D.latitude = latitude;
    // location2D.longitude = longitude;
    //设置地图的显示范围
    MKCoordinateSpan span;
    //地图显示范围越小，越清楚
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    // 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
    MKCoordinateRegion region = {location2D, span};
    // 设置当前地图的显示中心和显示范围
    [self.mapView setRegion:region animated:YES];
//    MKAnnotationView *annotation = [[MKAnnotationView alloc] init];
    XYNAnnotation *annotatio = [[XYNAnnotation alloc] initWithCoordinates:location2D title:@"XYN" subTitle:@"家"];
    [self.mapView addAnnotation: annotatio];
    //自动显示标注的layout
    [self.mapView selectAnnotation: annotatio animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView * result = nil;
    if(![mapView isEqual:self.mapView] || ![annotation isKindOfClass:[XYNAnnotation class]]) {
        return result;
    }
//    XYNAnnotation * senderAnnotation = (XYNAnnotation *)annotation;
    NSString *identifier = NSStringFromClass([annotation class]);
//    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    MKMarkerAnnotationView * annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

    if(annotationView == nil) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        [annotationView setCanShowCallout:YES];
    }
        
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    annotationView.rightCalloutAccessoryView = button;
//    annotationView.opaque = NO;
//    annotationView.animatesDrop = YES;
//    annotationView.draggable = YES;
//    annotationView.selected = YES;
//    annotationView.calloutOffset = CGPointMake(15, 15);
//    // 设置大头针颜色
//    annotationView.pinTintColor = [UIColor greenColor];
//    // 设置大头针是否有下落动画
//    annotationView.animatesDrop = YES;
//    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFIcon.png"]];
//    annotationView.leftCalloutAccessoryView = imageView;
    
    
    annotationView.animatesWhenAdded = YES;
//    MKFeatureVisibilityAdaptive,
//    MKFeatureVisibilityHidden,
//    MKFeatureVisibilityVisible
    annotationView.titleVisibility = MKFeatureVisibilityAdaptive;
    annotationView.subtitleVisibility = MKFeatureVisibilityAdaptive;
//    annotationView.glyphImage = [UIImage imageNamed:@"SFIcon.png"];
//    annotationView.glyphText = @"XYN";
    annotationView.glyphTintColor = [UIColor greenColor];
    annotationView.markerTintColor = [UIColor redColor];
    
    result = annotationView;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(removeAnnnotation:)];
    [result addGestureRecognizer:longPress];
    
    return result;
}
- (void)removeAnnnotation:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
//    //获取点位置
//    CGPoint point = [longPress locationInView:self.mapView];
//    //将点位置转换成经纬度坐标
//    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
//    //在该点添加一个大头针(标注)
}

#pragma mark -MKMapViewDelegate(地图代理)

// MKMapViewDelegate协议中的方法，当MKMapView显示区域将要发生改变时激发该方法
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    //    NSLog(@"地图控件的显示区域将要发生改变！");
}

// MKMapViewDelegate协议中的方法，当MKMapView显示区域改变完成时激发该方法
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animatedx {
    //    NSLog(@"地图控件的显示区域完成了改变！");
}

// MKMapViewDelegate协议中的方法，当MKMapView开始加载数据时激发该方法
- (void) mapViewWillStartLoadingMap:(MKMapView *)mapView {
    //    NSLog(@"地图控件开始加载地图数据！");
}

// MKMapViewDelegate协议中的方法，当MKMapView加载数据完成时激发该方法
- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    //    NSLog(@"地图控件加载地图数据完成！");
}

// MKMapViewDelegate协议中的方法，当MKMapView加载数据失败时激发该方法
- (void) mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    //    NSLog(@"地图控件加载地图数据发生错误，错误信息 %@！" , error);
}

// MKMapViewDelegate协议中的方法，当MKMapView开始渲染地图时激发该方法
- (void) mapViewWillStartRenderingMap:(MKMapView *)mapView {
    //    NSLog(@"地图控件开始渲染地图！");
}

// MKMapViewDelegate协议中的方法，当MKMapView渲染地图完成时激发该方法
- (void) mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    //    NSLog(@"地图控件渲染地图完成！");
}

#pragma mark - 打开各个地图app

//- (void)gdMap {
//    // 百度地图与高德地图、苹果地图采用的坐标系不一样，高德和苹果只能用地名不能用后台返回的坐标
//    CGFloat latitude = 36.547901; // 纬度
//    CGFloat longitude = 104.258354;// 经度
//    self.address = [[NSString alloc] init];
//
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:(CLLocationDegrees)longitude];
//
//    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        if(error ==nil&& [placemarks count] >0) {
//            //这时的placemarks数组里面只有一个元素
//            CLPlacemark* placemark = [placemarks firstObject];
//            NSLog(@"%@",placemark.addressDictionary); //根据经纬度会输出该经纬度下的详细地址  国家 地区 街道
//            self.address = [NSString stringWithFormat:@"%@",placemark.addressDictionary[@"FormattedAddressLines"][0]] ;
//            [self openAlert];
//        }
//    }];
//}
//
//- (void)openAlert{
//    CGFloat latitude=36.547901;
//    CGFloat longitude =104.258354;
////    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:(CLLocationDegrees)longitude];
//    // 打开地图的优先级顺序：百度地图->高德地图->苹果地图
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
//        // 百度地图
//        // 起点为“我的位置”，终点为后台返回的坐标
//        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=riding&src=%@", latitude, longitude,self.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL*url = [NSURL URLWithString:urlString];
//        [[UIApplication sharedApplication] openURL:url];
//
//    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//        // 高德，起点为“我的位置”，终点为后台返回的address
//        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=%@&did=BGVIS2&dname=%@&dev=0&t=0",@"我的位置",self.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//
//    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]){
//        // 苹果
//        //起点为“我的位置”，终点为后台返回的address
//        NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@",self.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//
//    }else{
//        // 没有安装上面三种地图APP，弹窗提示安装地图APP
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安地图APP" message:@"建议安装百度地图APP" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:alertVC animated:NO completion:nil];
//    }
//}



@end
