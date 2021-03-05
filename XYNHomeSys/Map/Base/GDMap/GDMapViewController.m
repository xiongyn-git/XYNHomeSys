//
//  GDMapViewController.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/3.
//

#import "GDMapViewController.h"

@interface GDMapViewController ()<MAMapViewDelegate>
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation GDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.view addSubview:self.mapView];
    // 1 实例化MAPointAnnotation类
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    // 2 设置标注点的坐标
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.9088230000, 116.3974700000);
    pointAnnotation.title = @"高德地图标题"; //设置标题
    pointAnnotation.subtitle = @"副标题"; //设置副标题
    // 3 调用地图的addAnnotation方法将标注点添加到地图上
    [self.mapView addAnnotation:pointAnnotation];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.mapView addGestureRecognizer:longPress];
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
    MAPointAnnotation *pointAnn = [[MAPointAnnotation alloc] init];
    pointAnn.coordinate = coordinate;
    pointAnn.title = @"长按的大头针";
    pointAnn.subtitle = @"副标题";
    [self.mapView addAnnotation:pointAnn];
}

/**
 折线类为 MAPolyline，由一组经纬度坐标组成，并以有序序列形式建立一系列的线段。iOS SDK支持在3D矢量地图上绘制带箭头或有纹理等样式的折线，同时可设置折线端点和连接点的类型，以满足各种绘制线的场景。
 */
- (void)MAPolyline {
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
//    //初始化点
//    NSArray *latitudePoints =[NSArray arrayWithObjects:@"23.172223",@"23.163385",@"23.155411",@"23.148765",@"23.136935", nil];
//    NSArray *longitudePoints = [NSArray arrayWithObjects: @"113.348665",@"113.366056",@"113.366128", @"113.362391", @"113.356785", nil];
//    // 创建数组
//    CLLocationCoordinate2D polyLineCoords[5];
//    for (int i=0; i<5; i++) {
//        polyLineCoords[i].latitude = [latitudePoints[i] floatValue];
//        polyLineCoords[i].longitude = [longitudePoints[i] floatValue];
//    }
//    // 创建折线对象
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:polyLineCoords count:5];
//    // 在地图上显示折线
//    [_mapView addOverlay:polyLine];
    
    
    
    
    
//    // 通过MACircle类绘制圆，圆是由中心点（经纬度）和半径（米）构成。
//    //构造圆
//    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:5000];
//    //在地图上添加圆
//    [_mapView addOverlay: circle];
}
#pragma  mark - 定制折线视图
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay {
//    if ([overlay isKindOfClass:[MAPolyline class]]) {
//        MAPolylineView *polyLineView = [[MAPolylineView alloc] initWithPolyline:overlay];
//        polyLineView.lineWidth = 2; //折线宽度
//        polyLineView.strokeColor = [UIColor blueColor]; //折线颜色
//        polyLineView.lineJoinType = kMALineJoinRound; //折线连接类型
//        return polyLineView;
//    }
//    return nil;
//}

#pragma  mark - 定位 回调方法

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    NSLog(@"定位成功");
    CLLocation *location = userLocation.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"我的坐标位置：%f, %f", coordinate.longitude, coordinate.latitude);
    // 定位后，可设置停止定位
    // _maMapView.showsUserLocation = NO;
    
}
- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame: self.view.bounds];
        // 显示比例尺
        _mapView.showsScale = YES;
        // 显示指南针
        _mapView.showsCompass = YES;
        // 显示定位蓝点
        _mapView.showsUserLocation = YES;
        // 用户定位模式
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        // 设置缩放级别
        [_mapView setZoomLevel:15];
        // 设置代理
        _mapView.delegate = self;
        // 设置地图类型
        _mapView.mapType = MAMapTypeBus;
        // 允许显示自己的位置（如使用定位功能，则必须设置为YES）
        _mapView.showsUserLocation = YES;
        // 设置logo位置
        _mapView.logoCenter = CGPointMake(100, 100);
        // 显示罗盘
        _mapView.showsCompass = YES;
        // 显示交通
        _mapView.showTraffic = YES;
        // 是否支持旋转
        _mapView.rotateEnabled = NO;
        // 是否支持拖动
        _mapView.scrollEnabled = YES;
        // 是否支持缩放
        _mapView.zoomEnabled = YES;
        
        // 设置当前地图的中心点：例如默认地图中心显示坐标为（39.9088230000, 116.3974700000）
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.9088230000, 116.3974700000);
        
        //        // 设置坐标
        //        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.9088230000, 116.3974700000);
        //        // 设置缩放
        //        MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
        //        // 设置区域
        //        MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
        //        // 显示区域
        //        _mapView.region = region;
    }
    return _mapView;
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
//        MAAnnotationView *customView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (customView == nil) {
//            customView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:reuseIndetifier];
//        }
       
        
        
        // 1、自带的标注视图
        MAPinAnnotationView *pinAnnView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if ( !pinAnnView ) {
            pinAnnView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];

        }
        // 是否可弹出视图
        pinAnnView.canShowCallout = YES;
        // 设置掉落动画
        pinAnnView.animatesDrop = YES;
        // 设置标注颜色
        pinAnnView.pinColor = MAPinAnnotationColorGreen;
        // 设置左视图
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        leftView.backgroundColor = [UIColor blueColor];
        pinAnnView.leftCalloutAccessoryView = leftView;
        //设置右视图
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinAnnView.rightCalloutAccessoryView = rightBtn;

        
//        //设置大头针图片
//        pinAnnView.image = [UIImage imageNamed:@"marker"];
//        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        pinAnnView.centerOffse =

        return pinAnnView;
    }
    return nil;
}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    // 线
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        // 线宽
        polylineRenderer.lineWidth    = 3.f;
        // 颜色
        polylineRenderer.strokeColor  = [self markColor];
        return polylineRenderer;
    }
    
    // 圆形
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth = 0;
        circleRenderer.strokeColor  = [[self markColor] colorWithAlphaComponent:0.2];
        circleRenderer.fillColor = [[self markColor] colorWithAlphaComponent:0.2];
        return circleRenderer;
    }
    return nil;
}

- (UIColor *)markColor {
    return [UIColor yellowColor];
}


@end
