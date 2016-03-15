//
//  IPIMapViewController.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/15.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIMapViewController.h"
#import "AppDelegate.h"
#import "ConfigMacro.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件


@interface IPIMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property(nonatomic, strong)BMKMapView* mapView;
@property(nonatomic, strong)BMKLocationService *loctionService;
@property(nonatomic, assign)CGFloat currentLatitude;//经度
@property(nonatomic, assign)CGFloat currentLoogitude;//纬度

@end

@implementation IPIMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view = self.mapView;
    
    //定位
    _loctionService = [[BMKLocationService alloc] init];
    _loctionService.delegate = self;
    [_loctionService startUserLocationService];

}

- (void)addAnnotationOnUserLocation{

    //添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.currentLatitude;
    coor.longitude = self.currentLoogitude;
    annotation.coordinate = coor;
    annotation.title = @"我的位置";
    [self.mapView addAnnotation:annotation];
}

- (void)showUserLocation{

    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.currentLatitude, self.currentLoogitude);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.038325, 0.028045);
    _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
    _mapView.rotateEnabled = NO;//禁用旋转手势
}


- (BMKMapView *)mapView{

    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
        _mapView.mapType = BMKMapTypeNone;//设置地图为空白类型
        [_mapView setTrafficEnabled:NO];//打开实时路况图层
        [_mapView setBaiduHeatMapEnabled:NO];//打开百度城市热力图图层（百度自有数据）
    }
    return _mapView;
}

- (void)viewWillAppear:(BOOL)animated{

    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    _mapView.delegate = nil;  // 不用时，置nil 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MapView

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{

    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;

}

#pragma mark BMKLoctionServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    
    _currentLatitude = userLocation.location.coordinate.latitude;
    _currentLoogitude = userLocation.location.coordinate.longitude;
    [self addAnnotationOnUserLocation];
    [self showUserLocation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
