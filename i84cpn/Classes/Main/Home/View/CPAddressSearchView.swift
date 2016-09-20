//
//  CPHomeSearchView.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/24.
//  Copyright © 2016年 5i84. All rights reserved.
//  关键字搜索页（已购票的第二页）

import UIKit

protocol addressSearchDelegate:NSObjectProtocol {
    func goLineResultCtl()
}

class CPAddressSearchView: UIView,UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate {
    
    private var scrollView=UIScrollView()       //滚动视图
    private var contentView=UIView()            //基础视图
    private var searchView=UIView()             //搜索框
    
    private var addressTextFil=UITextField()    //地址输入框
    var addressTableView=UITableView()  //定位的tableView
    
    var locService:BMKLocationService! //初始化百度定位服务
    var poiSearcher:BMKPoiSearch!       //poi检索
    var poiOption:BMKNearbySearchOption!//周边检索
    
    var currentLongitude:Double! = 0.0      //经度
    var CurrentLatitude:Double! = 0.0       //纬度
    var geocodeSearch=BMKGeoCodeSearch()        //反地理编码
    var locationResult:String?                  //定位地址
    var cellGest=UITapGestureRecognizer()

    var mutablePOIArray=NSMutableArray()
    
    weak var delegate:addressSearchDelegate?
    
//    var localAddress:String!
//    var localLon:Double!
//    var localLat:Double!
    
    var selectedRow:Int!
    var selectedAddress:String!
    var selectedLon:Double!
    var selectedLat:Double!
    
    var mutablePOILon=NSMutableArray()           //poi经度
    var mutablePOILat=NSMutableArray()          //poi纬度
    
    var headerGest=UITapGestureRecognizer()

    override func drawRect(rect: CGRect) {
        locationResult=" "
        
        geocodeSearch.delegate = self
        addressTextFil.delegate=self
        
        poiSearcher=BMKPoiSearch()
        poiOption=BMKNearbySearchOption()
        poiSearcher.delegate=self
        //-------------------scrollView----------------
        self.addSubview(scrollView)
        scrollView.bounces=false
        scrollView.backgroundColor=COLOR_BACKGROUND_GRAY
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsZero)
        }
        
        //-------------contentView----------
        scrollView.addSubview(contentView)
        contentView.backgroundColor=COLOR_BACKGROUND_GRAY
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView).offset(UIEdgeInsetsZero)
            make.width.equalTo(self.bounds.size.width)
            make.height.equalTo(self.bounds.size.height)
        }
        
        //---------------searchView------------
        contentView.addSubview(searchView)
        searchView.backgroundColor=UIColor.whiteColor()
        searchView.layer.borderWidth=0.5
        searchView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        searchView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(0)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
        }
        
        searchView.addSubview(addressTextFil)
        addressTextFil.snp_makeConstraints { (make) in
            make.top.equalTo(searchView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(searchView).offset(WIDTH_DYNAMIC(30))
            make.right.equalTo(searchView).offset(WIDTH_DYNAMIC(-30))
            make.height.equalTo(34)
        }
        addressTextFil.leftView=UIView(frame: CGRectMake(0,0,10,34))
        addressTextFil.leftViewMode=UITextFieldViewMode.Always
        addressTextFil.placeholder="请输入关键字"
        addressTextFil.layer.borderWidth=1
        addressTextFil.layer.cornerRadius=3
        addressTextFil.layer.borderColor=COLOR_SEGMENTATION.CGColor
        addressTextFil.font=UIFont.systemFontOfSize(14)
        addressTextFil.clearButtonMode=UITextFieldViewMode.WhileEditing
        
        //-----------------searchView_bottom-------------
        searchView.snp_updateConstraints { (make) in
            make.bottom.equalTo(addressTextFil.snp_bottom).offset(HEIGHT_DYNAMIC(20))
        }
        
        //------------------addressTableView---------------------
        contentView.addSubview(addressTableView)
        addressTableView.snp_makeConstraints { (make) in
            make.top.equalTo(searchView.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(30))
            make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-30))
            make.height.equalTo(300)
//            make.height.lessThanOrEqualTo(300)
        }
        addressTableView.backgroundColor=UIColor.whiteColor()
        addressTableView.delegate=self
        addressTableView.dataSource=self
        addressTableView.layer.borderWidth=1
        addressTableView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        
        //设置分割线顶格
        if addressTableView.respondsToSelector(Selector("setSeparatorInset:")){
            addressTableView.separatorInset = UIEdgeInsetsZero
        }
        if addressTableView.respondsToSelector(Selector("setLayoutMargins:")){
            addressTableView.layoutMargins = UIEdgeInsetsZero
        }
        addressTableView.separatorColor=COLOR_SEGMENTATION
        addressTableView.scrollEnabled=true
        
        //发起百度定位
        locService=BMKLocationService()
        if  (CLLocationManager.authorizationStatus() != .Denied) {
            locService.desiredAccuracy=kCLLocationAccuracyBest  //定位精确度
            locService.distanceFilter=10.0                        //最小更新距离（10米）
            locService.delegate=self
            locService.startUserLocationService()
        }
        else{
            let alertView=UIAlertView(title: "提示", message: "定位功能未开启,请进入系统设置>隐私>定位服务中打开开关,并允许“同学号”使用定位服务", delegate: self, cancelButtonTitle: "确定")
            alertView.show()

        }
        //------------------------------------------------
        
        
    }
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        currentLongitude=locService.userLocation.location.coordinate.longitude  //经度
        CurrentLatitude=locService.userLocation.location.coordinate.latitude    //纬度
        
        //发起反向地理编码检索
        let reverseGeocodeSearchOption = BMKReverseGeoCodeOption()
        //        reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(26.0812552750482, 119.327499252607)
        reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(CurrentLatitude, currentLongitude)
        
        let flag = geocodeSearch.reverseGeoCode(reverseGeocodeSearchOption)
        if flag {
//            print("反geo 检索发送成功")
        } else {
//            print("反geo 检索发送失败")
        }
 
        //发起POI检索
        poiOption.pageIndex=0
        poiOption.pageCapacity=10
        poiOption.radius=1000
        //        poiOption.location=CLLocationCoordinate2D(latitude: 26.0812552750482, longitude: 119.327499252607)
        poiOption.location=CLLocationCoordinate2D(latitude: CurrentLatitude, longitude: currentLongitude)
        //停止定位
        locService.stopUserLocationService()
    }

    
    //返回反地理编码搜索结果
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
//        print("onGetReverseGeoCodeResult error: \(error)")
        if error == BMK_SEARCH_NO_ERROR {
            locationResult=result.address
            let poiKeyWord="\(result.addressDetail.streetName)"+"\(result.addressDetail.streetNumber)"   //poi的搜索词不能太长
            poiOption.keyword=poiKeyWord
            poiSearcher.poiSearchNearBy(poiOption)
            addressTableView.reloadData()
        }
    }
    
    //返回POI搜索结果
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        mutablePOILon.removeAllObjects()
        mutablePOILat.removeAllObjects()
        if (errorCode == BMK_SEARCH_NO_ERROR) {
            for i in 0..<poiResult.poiInfoList.count {
                let poi=poiResult.poiInfoList[i] as? BMKPoiInfo
                mutablePOIArray.addObject(poi!.name)
                mutablePOILon.addObject(poi!.pt.longitude)
                mutablePOILat.addObject(poi!.pt.latitude)
            }
//            print(mutablePOIArray)      //POI数组
        } else if errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD {
//            print("检索词有歧义")
        } else {
            print(errorCode)
            // 各种情况的判断……
        }
        addressTableView.reloadData()
        
    }

    //cell分割线顶格
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setLayoutMargins:")){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector(Selector("setSeparatorInset:")){
            cell.separatorInset = UIEdgeInsetsZero
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //headerView用于获取当前地址
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView=UIView()
        headerView.backgroundColor=UIColor.whiteColor()
        headerView.layer.borderWidth=1
        headerView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        
        let locationImgView=UIImageView()
        headerView.addSubview(locationImgView)
        locationImgView.image=UIImage(named: "icon_location")
        locationImgView.snp_makeConstraints { (make) in
            make.top.equalTo(headerView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(headerView).offset(WIDTH_DYNAMIC(22))
        }
        locationImgView.contentMode=UIViewContentMode.ScaleAspectFill
        
        let locationLb=UILabel()
        locationLb.text="当前位置："+locationResult!
        locationLb.numberOfLines=2
        locationLb.lineBreakMode=NSLineBreakMode.ByTruncatingTail
        locationLb.font=UIFont.systemFontOfSize(14)
        headerView.addSubview(locationLb)
        locationLb.snp_makeConstraints { (make) in
            make.top.equalTo(headerView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(headerView).offset(WIDTH_DYNAMIC(55))
            make.right.equalTo(headerView).offset(0)
        }
        
        headerGest.numberOfTapsRequired=1
        headerView.addGestureRecognizer(headerGest)

        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mutablePOIArray.count
        //        return mutablePOIArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pointView=UIView()
        let poingImgView=UIImageView()       //cell左侧定位图标
        let poingLabelView=UILabel()             //cell获取的地址

        var cell=addressTableView.dequeueReusableCellWithIdentifier("cell")
        if(cell==nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            addressTableView.reloadData()
        }else{
        while (cell?.contentView.subviews.last != nil) {
            cell?.contentView.subviews.last?.removeFromSuperview()
        }
        //获取POI场所
            
        cell!.contentView.addSubview(pointView)
        pointView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(cell!.contentView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(cell!.contentView).offset(WIDTH_DYNAMIC(20))
        })
        pointView.addSubview(poingImgView)
        poingImgView.image=UIImage(named: "icon_point")
        poingImgView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(pointView).offset(HEIGHT_DYNAMIC(0))
            make.left.equalTo(pointView).offset(WIDTH_DYNAMIC(0))
        })
        poingImgView.contentMode=UIViewContentMode.ScaleAspectFill
        
        pointView.addSubview(poingLabelView)
        poingLabelView.font=UIFont.systemFontOfSize(14)
        poingLabelView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(pointView).offset(HEIGHT_DYNAMIC(0))
            make.left.equalTo(pointView).offset(WIDTH_DYNAMIC(35))
        })
        poingLabelView.text=(mutablePOIArray[indexPath.row] as! String)
        }
        
        
        return cell!
    }
    
    
    //向上滑动时将section一并隐藏
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let heightForHeader:CGFloat = 60.0;
        if (scrollView.contentOffset.y <= heightForHeader&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=heightForHeader) {
            scrollView.contentInset = UIEdgeInsetsMake(-heightForHeader, 0, 0, 0);
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        poiOption.keyword=addressTextFil.text
//        poiOption.keyword="福马路45号"
        mutablePOIArray.removeAllObjects()
        addressTableView.reloadData()
        if poiSearcher.poiSearchNearBy(poiOption){
//            print("POI send success!")
        }else{
//            print("POI send failed!")
//            let alertView=UIAlertView(title: "提示", message: "未找到结果！", delegate: self, cancelButtonTitle: "确定")
//            alertView.show()
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedAddress=mutablePOIArray[indexPath.row] as! String
//        selectedLon=Double("119.29814270720651")
//        selectedLat=Double("26.06832799119582")
        selectedLon=mutablePOILon[indexPath.row] as! Double
        selectedLat=mutablePOILat[indexPath.row] as! Double

        if(self.delegate != nil){
            self.delegate?.goLineResultCtl()
        }
        
    }

}