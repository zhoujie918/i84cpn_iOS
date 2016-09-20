//
//  CPRealTimeCarController.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/31.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRealTimeCarController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate,CPRealTimeCarTabbarViewProtocol {

    var mapView = BMKMapView()
    var locService = BMKLocationService()
    var hasLocation = Bool()
    var isLineInfo = false
    
    var tabbarView = CPRealTimeCarTabbarView()
    var userLineData = NSArray()
    var stationList : [StationList]!
    var pointList : [LinePointList]!
    var selectedLineData = NSDictionary()
    var tempAnnotation = RouteAnnotation()
    
    var hud = MBProgressHUD()
    
    var timer:NSTimer!
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "实时专车"
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.setupMapView()
        
        if isLineInfo == true {
            self.drawLineOnMap()
        }else{
            self.creatTabbarView()
            self.getLineData()
        }
    }

    override func viewWillAppear(animated: Bool) {
        mapView.delegate = self
        locService.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.delegate = nil
        locService.delegate = nil
        if timer != nil{
            timer.invalidate()
        }
    }
    
    
    //MARK: -
    //MARK: 创建路线选择标签栏
    func creatTabbarView() {
        tabbarView = CPRealTimeCarTabbarView.init(frame: CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_WIDTH, 50))
        tabbarView.delegate = self
        self.view.addSubview(tabbarView)
    }
    
    //MARK: 配置百度地图
    func setupMapView() {
        self.view.addSubview(mapView)
        mapView.showMapScaleBar = true
        mapView.showsUserLocation = true
        weak var weakSelf = self
        mapView .snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.view)
        }
        locService.distanceFilter = 1
        locService.headingFilter = 5
        locService.startUserLocationService()
    }
    
    
    //MARK: -
    //MARK: 获取用户线路信息
    func getLineData() {
        hud = MBProgressHUD .showHUDAddedTo(mapView, animated: true)
        hud.labelText = "正在获取路线..."
        weak var weakSelf = self
        CPRealTimeCarModel .getUserLineData({ (success) in
            weakSelf!.hud .hide(true)
            weakSelf?.userLineData = (success?.obj)! as NSArray
            weakSelf!.tabbarView.viewData = (success?.obj)! as NSArray
            weakSelf?.tabbarViewDidSelectRowAtIndexPath(0)
        }) { (fail) in
            weakSelf!.hud .hide(true)
            print(fail)
            if (fail != nil){
                let alertV = UIAlertView.init(title: "提示", message: fail, delegate: nil, cancelButtonTitle: "取消")
                alertV.show()
            }else{
                let alertV = UIAlertView.init(title: "提示", message:"无法连接到服务器", delegate: nil, cancelButtonTitle: "取消")
                alertV.show()
            }

        }
    }
    
    
    //MARK: 获取线路详细信息(tableView点击回调)
    func tabbarViewDidSelectRowAtIndexPath(index: Int) {
        hud = MBProgressHUD .showHUDAddedTo(mapView, animated: true)
        hud.labelText = "正在绘制路线..."
        weak var weakSelf = self
        if ((userLineData.count) != 0){
            if timer != nil {
                timer.invalidate()
            }
            selectedLineData = userLineData[index] as! NSDictionary
            LineDetailModel.getLineDetailData(["action":"tm_line_point","LINE_NO":selectedLineData["line_no"]!,"LINE_TYPE":selectedLineData["is_up_down"]!,"BUS_NO":selectedLineData["plate_no"]!,"classId":selectedLineData["classes_id"]!] , successClosure: { (success) in
                weakSelf!.hud .hide(true)
                weakSelf!.pointList = success.linePointLt
                weakSelf!.stationList = success.stationLt
                weakSelf!.drawLineOnMap()
                weakSelf!.getGPSData()
                // 计时器
                weakSelf!.timer = NSTimer.scheduledTimerWithTimeInterval(20.0,target:weakSelf!,selector:#selector(CPRealTimeCarController.getGPSData),userInfo:nil,repeats:true)
                
                }, fail: { (fail) in
                    weakSelf!.hud.hide(true)
                    print(fail)
            })
        }
    }
    
    //MARK: 获取车辆GPS信息
    func getGPSData() {
        weak var weakSelf = self
    CarGPSModel.getCarGPSData(["action":"tm_bus_gps","LINE_NO":selectedLineData["line_no"]!,"IS_UP_DOWN":selectedLineData["is_up_down"]!,"BUS_NO":selectedLineData["plate_no"]!], successClosure: { (success) in
        
        if weakSelf!.tempAnnotation.coordinate.latitude != 0{
            weakSelf!.mapView.removeAnnotation(weakSelf!.tempAnnotation)
        }
        weakSelf!.tempAnnotation = RouteAnnotation()
        weakSelf!.tempAnnotation.coordinate = CLLocationCoordinate2DMake(success.LAT, success.LNG)
        //            item.degree = Int(transitStep.direction) * 30
        weakSelf!.tempAnnotation.type = 4
        weakSelf!.mapView.addAnnotation(weakSelf!.tempAnnotation)
        
            }) { (fail) in
                print(fail)
        }
    }
    
    
    //MARK: -
    //MARK: 地图描点画线
    func drawLineOnMap() {
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        if isLineInfo == true {
            
            if stationList != nil{
                
                let stationCount = stationList.count
                
                // 轨迹点
                var points = Array(count: stationCount, repeatedValue: CLLocationCoordinate2DMake(0, 0))
                
                for i in 0..<stationCount{
                    let step = stationList![i]
                    if step.type == "0" {
                        // 站点
                        let item = RouteAnnotation()
                        item.coordinate = CLLocationCoordinate2D(latitude: step.latitude, longitude: step.longitude)
                        item.title = step.stationName
                        item.type = 2
                        mapView.addAnnotation(item)
                        points[i].latitude = step.latitude
                        points[i].longitude = step.longitude
                    }else{
                        // 辅助点
                        points[i].latitude = step.latitude
                        points[i].longitude = step.longitude
                        let dic : NSDictionary = BMKConvertBaiduCoorFrom(points[i], BMK_COORDTYPE_GPS)
                        points[i] = BMKCoorDictionaryDecode(dic as [NSObject : AnyObject])
                    }
                }
                
                // 通过 points 构建 BMKPolyline
                let polyLine = BMKPolyline(coordinates: &points, count: UInt(stationCount))
                mapViewFitPolyLine(polyLine)
                mapView.addOverlay(polyLine)  // 添加路线 overlay
            }
            
        }else{
            
            if stationList != nil{
                
                let stationCount = stationList.count
                
                // 添加站点
                for i in 0..<stationCount{
                    
                    let step = stationList![i]
                    let item = RouteAnnotation()
                    item.coordinate = CLLocationCoordinate2D(latitude: step.latitude, longitude: step.longitude)
                    item.title = step.stationName
                    item.type = 2
                    mapView.addAnnotation(item)
                    print(step)
                }
                
                
                if pointList != nil {
                    
                    let pointCount = pointList.count

                    // 添加起点标注
                    let start = pointList![0]
                    let startItem = RouteAnnotation()
                    startItem.coordinate = CLLocationCoordinate2D(latitude: start.LATITUDE, longitude: start.LONGITUDE)
                    startItem.coordinate = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(startItem.coordinate, BMK_COORDTYPE_GPS))
                    startItem.title = "起点"
                    startItem.type = 0
                    mapView.addAnnotation(startItem)
                    
                    // 添加终点标注
                    let end = pointList![pointCount-1]
                    let endItem = RouteAnnotation()
                    endItem.coordinate = CLLocationCoordinate2D(latitude: end.LATITUDE, longitude: end.LONGITUDE)
                    endItem.coordinate = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(endItem.coordinate, BMK_COORDTYPE_GPS))
                    endItem.title = "终点"
                    endItem.type = 1
                    mapView.addAnnotation(endItem)
                    
                    // 轨迹点
                    var points = Array(count: pointCount, repeatedValue: CLLocationCoordinate2DMake(0, 0))
                    for i in 0..<pointCount {
                        let step = pointList![i]
                        points[i].latitude = step.LATITUDE
                        points[i].longitude = step.LONGITUDE
                        let dic : NSDictionary = BMKConvertBaiduCoorFrom(points[i], BMK_COORDTYPE_GPS)
                        points[i] = BMKCoorDictionaryDecode(dic as [NSObject : AnyObject])
                    }
                    
                    // 通过 points 构建 BMKPolyline
                    let polyLine = BMKPolyline(coordinates: &points, count: UInt(pointCount))
                    mapViewFitPolyLine(polyLine)
                    mapView.addOverlay(polyLine)  // 添加路线 overlay
                }
                
            }
        }
        
    }
    
    
    //MARK: -
    //MARK: 百度地图代理方法
    func willStartLocatingUser() {
        print("start locate")
    }
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        if hasLocation == false{
            var region = BMKCoordinateRegion()
            region.center = userLocation.location.coordinate
            region.span.latitudeDelta = 0.1
            region.span.longitudeDelta = 0.1
            mapView.setRegion(region, animated: true)
        }
        hasLocation = true
    }
    
    func didStopLocatingUser() {
        print("stop locate")
    }
    
    func didFailToLocateUserWithError(error: NSError!) {
        print("location error")
    }

    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if let routeAnnotation = annotation as! RouteAnnotation? {
            return getViewForRouteAnnotation(routeAnnotation)
        }
        return nil
    }
    
    
    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay as! BMKPolyline? != nil {
            let polylineView = BMKPolylineView(overlay: overlay as! BMKPolyline)
            polylineView.strokeColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.7)
            polylineView.lineDash = true
            polylineView.lineWidth = 5
            return polylineView
        }
        return nil
    }
    
    
    //根据polyline设置地图范围
    func mapViewFitPolyLine(polyline: BMKPolyline!) {
        mapView.visibleMapRect = polyline.boundingMapRect
        mapView.zoomLevel = mapView.zoomLevel - 0.3
    }

    
    //配置Annotation
    func getViewForRouteAnnotation(routeAnnotation: RouteAnnotation!) -> BMKAnnotationView? {
        var view: BMKAnnotationView?
        
        var imageName: String?
        switch routeAnnotation.type {
        case 0:
            imageName = "nav_start"
        case 1:
            imageName = "nav_end"
        case 2:
            imageName = "nav_bus"
        case 3:
            imageName = "nav_rail"
        case 4:
            imageName = "direction"
        case 5:
            imageName = "nav_waypoint"
        default:
            return nil
        }
        let identifier = "\(imageName)_annotation"
        view = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if view == nil {
            view = BMKAnnotationView(annotation: routeAnnotation, reuseIdentifier: identifier)
            view?.centerOffset = CGPointMake(0, -(view!.frame.size.height * 0.5))
            view?.canShowCallout = true
        }
        
        view?.annotation = routeAnnotation
        
        let bundlePath = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/mapapi.bundle/")
        let bundle = NSBundle(path: bundlePath!)
        if let imagePath = bundle?.resourcePath?.stringByAppendingString("/images/icon_\(imageName!).png") {
            var image = UIImage(contentsOfFile: imagePath)
            if routeAnnotation.type == 4 {
                image = image?.imageRotated(routeAnnotation.degree)
            }
            if image != nil {
                view?.image = image
            }
        }
        return view
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("内存警告!!")
    }
}


public extension UIImage {
    //旋转图片
    func imageRotated(degrees: Int!) -> UIImage {
        let width = CGImageGetWidth(self.CGImage)
        let height = CGImageGetHeight(self.CGImage)
        let rotatedSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(rotatedSize);
        let bitmap = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
        CGContextRotateCTM(bitmap, CGFloat(Double(degrees) * M_PI / 180.0));
        CGContextRotateCTM(bitmap, CGFloat(M_PI));
        CGContextScaleCTM(bitmap, -1.0, 1.0);
        CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}
