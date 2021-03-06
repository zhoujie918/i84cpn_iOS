//
//  Constants.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

class Constants {
    static func dPrint(item: Any) {
        #if DEBUG
        print(item)
        #endif
    }
    // SSKeyChain server name
    static let keychainServerName = "com.5i84.cpn"
    // hud 显示时间
    static let hudShowTime: Float = 0.7
    // 欢迎页页数
    static let welcomePageNumber = 3
    // 超小字体
    static let superSmallFont = UIFont.systemFontOfSize(12)
    // 小字体
    static let smallFont = UIFont.systemFontOfSize(13)
    // 中等字体
    static let mediumFont = UIFont.systemFontOfSize(14)
    // 导航栏字体
    static let navFont = UIFont.systemFontOfSize(18)
    // 标题字体
    static let titleFont = UIFont.systemFontOfSize(15)
    // 内容字体
    static let contentFont = UIFont.systemFontOfSize(14)
    // 提示文字字体
    static let tipFont = UIFont.systemFontOfSize(14)
    // 屏幕宽高
    static let screenWidth = UIScreen.mainScreen().bounds.size.width
    static let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    
    // 淡色字体颜色
    static let paleWordColor = Constants.colorWithHexString("666666")
    // 黄色字体颜色
    static let yellowWordColor = Constants.colorWithHexString("f9ca00")
    // 白色字体颜色
    static let whiteWordColor = UIColor.whiteColor()
    // 黑色字体颜色
    static let blackWordColor = UIColor.blackColor()
    // 红色字体颜色
    static let redWordColor = Constants.colorWithHexString("fc8663")
    // 绿色字体颜色
    static let greenWordColor = Constants.colorWithHexString("81cb4e")
    // 提示文字颜色 浅灰色
    static let tipWordColor = Constants.colorWithHexString("999999")
    
    // 白色背景
    static let whiteBGColor = UIColor.whiteColor()
    // 黑色背景
    static let blackBGColor = UIColor.blackColor()
    //  淡色背景颜色
    static let paleBGColor  = Constants.colorWithHexString("f0f0f0")
    // 透明黑色背景
    static let clearBlackBGColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    // 标题文字颜色
    static let titleWordColor = Constants.colorWithHexString("333333")
    // 主色调
    static let mainColor = Constants.colorWithHexString("ffda2a")
    // 高亮红色
    static let redHightColor = Constants.colorWithHexString("ff0000")
    // 蓝色
    static let blueColor = Constants.colorWithHexString("6ac0e3")
    
    // 分割线
    static func splitLine() -> UIView {
        let view: UIView = UIView()
        view.backgroundColor = colorWithHexString("e5e5e5")
        return view
    }
    
    static func containView() -> UIView {
        let view = UIView()
        view.backgroundColor = whiteBGColor
        return view
    }

    
    // 转颜色
    static func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    // 右侧弹出按钮
    static func getRightButton() -> UIButton {
        let btn = UIButton()
//        btn.setBackgroundImage(UIImage(named: "icon_in02"), forState: .Normal)
        btn.setImage(UIImage(named: "icon_in02"), forState: .Normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: Constants.screenWidth - 30, bottom: 0, right: 20)
        return btn
    }
    
    static var cityId = 0
    
//MARK:-- URL
//    private static let baseURL = "http://250a.i84.com.cn:8080/"  // 注意修改时需要修改URLHeader.h（支付宝）
//    private static let baseURL = "http://192.168.1.237:8080/"
//    private static let baseURL = "http://jiangxfa.i84.com.cn/"
    private static let baseURL = "http://cpn.5i84.cn/"
//    private static let baseURL = "http://cpn.5i84.cn:8080/"
//    private static let baseURL = "http://jiangxfa.i84.com.cn/"
//    private static let baseURL = "http://192.168.1.243:8080/"
//    private static let baseURL = "http://clife.5i84.cn/"
//    private static let checkBaseURL = "http://clife.5i84.cn/"
    
    // 获取图形验证码
    static let captchaImageURL = baseURL + "code/captcha-image"
    // 验证图形验证码
    static let checkCaptchaURL = baseURL + "code/checkCaptcha"
    // 获取注册短信验证码
    static let getSMSCodeURL = baseURL + "sendRegCode"
    // 获取忘记密码短信验证码
    static let getSMSCodeOfForgetPasswordURL = baseURL + "sendForCode"
    // 获取修改绑定手机短信验证码
    static let getSMSCodeOfChangePhoneNumURL = baseURL + "auth/sendChmCode"
    // 验证修改绑定手机短信验证码是否正确
    static let checkSMSCodeOfChangePhoneNumURL = baseURL + "auth/checkChmCode"
    // 向行手机发送短信验证码
    static let getSMSCodeOfNewPhoneNumURL = baseURL + "auth/sendChmnCode"
    
    // 用户个人信息 -获取用户个人信息 -修改昵称 -实名认证 -获取通讯地址列表 -设置默认通讯地址 -新增通讯地址 -获取乘客列表 -获取乘客详情 -删除乘客 -关联乘客乘车信息推送 -设置乘车信息推送 -获取关联乘车提醒的申请记录 -查询订单列表 -订单详情 -计算订单金额 -新增订单 -获取退款提示信息 -退款申请 -补卡申请 -改签提示信息 -改签订单 -选座座位图初始化参数 -选座 -获取具体消息提醒列表 -获取具体消息提醒详细信息 -是否通过用户关联申请 -获取意见反馈列表 -获取我定制的线路列表  -取消定制 -获取我参与的线路列表 -退出参与的线路 -切换当前城市
    static let userInfoURL = baseURL + "auth/api"
    // 登录
    static let loginURL = baseURL + "login"
    // 退出
    static let userLogoutURL = baseURL + "userLogout?cityId=" + String(cityId)
    // 非个人信息 -手机号是否可以注册 -获取省市县信息 -获取意见反馈问题分类 -获取版本信息 -获取消息提醒类型
    static let noauthApiURL = baseURL + "noauth/api"
    // 注册
    static let registerURL = baseURL + "register"
    // 重设密码
    static let resetPasswordURL = baseURL + "resetPass"
    // 获取图片
    static let getImageURL = baseURL + "getImg?"
    // SDWebImage获取图片
    static func getSDWebImageURLWithImageName(imageName: String) -> NSURL {
        return NSURL.init(string: (getImageURL + "imgName=" + imageName + "&cityId=" + String(cityId)))!
    }
    // 修改绑定手机
    static let changePhoneNumURL = baseURL + "auth/editBMobile"
   // 用户头像 -乘客头像 -提交意见反馈（包含图片）
    static let fileApiURL = baseURL + "auth/fileApi"

    // 线路征集H5
    static func getLineCollectionURL() -> String {
        let cityId = NSUserDefaults.standardUserDefaults().objectForKey("cityId") as! Int
        return baseURL + "h5/lineEx/comCollectList.html?type=1&cityCode=\(cityId)&entrCode=2"
    }
    
    // 获取最新版本
    static func getVersion() -> Dictionary<String, AnyObject> {
        return ["action":"get_version_newest", "type": 2]
    }
    
    // 登录参数
    static func loginParms(username: String, password: String, cityId: Int) -> Dictionary<String, AnyObject> {
        return   ["username":username,"password":password, "manage":"member", "rememberMe": true, "isApp":"1", "cityId": cityId]
//        return   ["username":username,"password":password, "manage":"member",  "isApp":"1"]
    }
    
    // 验证手机号是否可以注册参数
    static func phoneNumSignUpAbleParamsWithPhoneNum(phoneNum: String) -> Dictionary<String, AnyObject> {
        return ["action":"can_register", "mobile":phoneNum, "cityId": cityId]
    }
    
    // 验证图形验证码参数
    static func checkCaptchaParamWithcaptcha(captcha: String) -> Dictionary<String, AnyObject> {
        return ["captcha":captcha, "cityId": cityId]
    }
    
    // 获取短信验证码参数
    static func getSMSCodeParamWithCaptcha(captcha: String, mobile: String) -> Dictionary<String, AnyObject> {
        return ["captcha":captcha, "mobile":mobile, "source": "CPN_Token_IP", "cityId": cityId]
    }
    
    // 获取忘记密码短信验证码
    static func getSMSCodeOfForgetPasswordWithPhoneNum(phoneNum: String) -> Dictionary<String, AnyObject> {
        return ["mobile":phoneNum, "source": "CPN_Token_IP", "cityId": cityId]
    }
    
    // 获取绑定手机验证码
    static func getBindingSMSCode() -> Dictionary<String, AnyObject> {
        return ["source": "CPN_Token_IP", "cityId": cityId]
    }
    
    // 向新手机号发送短信验证码
    static func getSMSCodeOfNewPhoneNumParamWithPhoneNum(phoneNum: String) -> Dictionary<String, AnyObject> {
        return ["mobile": phoneNum, "source": "CPN_Token_IP", "cityId": cityId]
    }
    
    // 注册参数
    static func getRegisterParamWithPhoneNum(phoneNum: String, regcode: String, password: String) -> Dictionary<String, AnyObject> {
        return ["code":regcode, "mobile":phoneNum, "pass":password, "cityId": cityId]
    }

    // 重设密码
    static func resetPasswordParamWithPhoneNum(phoneNum: String, SMSCode: String, newPassword: String) -> Dictionary<String, AnyObject> {
        return ["mobile":phoneNum, "code":SMSCode, "pass": newPassword, "cityId": cityId]
    }
    
    // 修改密码
    static func changePasswordParamWithOldPassword(oldPassword: String, newPassword: String) -> Dictionary<String, AnyObject> {
        return ["action":"change_pass", "oldWord": oldPassword, "newWord": newPassword, "cityId": cityId]
    }
    
    // 获取用户个人信息
    static let getUserInfoParam = ["action": "get_user_msg", "cityId": cityId]
 
    // 获取图片
    static func getImageWithImageName(imageName: String) -> Dictionary<String, AnyObject> {
        return ["imgName": imageName, "cityId": cityId]
    }
    
    // 设置用户昵称
    static func setPetNameParamWithNickName(nickName: String) -> Dictionary<String, AnyObject> {
        return ["action":"edit_nick_name", "nickName": nickName, "cityId": cityId]
    }
    
    static func editUserHeadView() -> Dictionary<String, AnyObject> {
        return ["action": "edit_user_pic", "cityId": cityId]
    }
    
    // 验证修改绑定手机验证码是否正确
    static func checkSMSCodeForChangePhoneNumParamWithSMSCode(code: String) -> Dictionary<String, AnyObject> {
        return ["code": code, "cityId": cityId]
    }
    
    // 修改绑定手机号
    static func changePhoneNumWithNewPhoneNum(phoneNum: String, SMSCode: String) -> Dictionary<String, AnyObject> {
        return ["mobile": phoneNum, "code": SMSCode, "cityId": cityId]
    }
    
    // 实名认证
    static func checkCertParamWithIdNo(idNo: String, name: String) -> Dictionary<String, AnyObject> {
        return ["action": "check_id_card", "idNo": idNo, "name": name, "cityId": cityId]
    }
    
     // 获取通讯地址列表
    static func getAddressList() -> Dictionary<String, AnyObject> {
        return ["action": "get_bu_add_list", "cityId": cityId]
    }
    
    // 设置默认地址
    static func setDefaultAddParamWithUasId(uasId: String) -> Dictionary<String, AnyObject> {
        return ["action":"set_ba_default", "uasId": uasId, "cityId": cityId]
    }
    
    // 新增通讯地址
    static func addAddress(defalut: AnyObject, provinceId: String, cityId: String, countyId: String, address: String) -> Dictionary<String, AnyObject> {
        return ["action": "add_bu_address", "isDef": defalut, "provinceId": provinceId, "city_id": cityId, "area_id":countyId, "address": address, "cityId": cityId]
    }
    
    // 获取省份信息
    static func getProvinceList() -> Dictionary<String, AnyObject> {
        return ["action": "get_provinces", "cityId": cityId]
    }
    
    // 获取城市信息
    static func getCityListParamWithProvinceCode(pCode: String) -> Dictionary<String, AnyObject> {
        return ["action": "get_citys", "pCode": pCode, "cityId": cityId]
    }
    
    // 获取城区/县级信息
    static func getCountyListWithCityCode(cCode: String) -> Dictionary<String, AnyObject> {
        return ["action": "get_countys", "pCode": cCode, "cityId": cityId]
    }
    
    // 获取乘客列表
    static func getPassengerInfoList() -> Dictionary<String, AnyObject> {
        return ["action":"get_psg_list", "cityId": cityId]
    }
    
    // 获取乘客详情
    static func getPassengerDetailInfo(psgId: Int) -> Dictionary<String, AnyObject> {
        return ["action":"get_psg_detail", "psgId": psgId, "cityId": cityId]
    }
    
    // 查询订单列表
    static func getOrderList(state: Int) -> Dictionary<String, AnyObject> {
        return ["action": "order_list", "start": 0, "limit": 100, "order_state": state, "cityId": cityId]
    }
    
    // 删除乘客信息
    static func deletePassengerInfo(psgId: Int) -> Dictionary<String, AnyObject> {
        return ["action":"delete_psg", "psgId": psgId, "cityId": cityId]
    }
    
    // 编辑乘客信息
    static func editPassengerInfo(psgId: Int, isSend: Int) -> Dictionary<String, AnyObject> {
        return ["action": "edit_psg", "psgId": psgId, "isSend": isSend, "cityId": cityId]
    }
    
    // 关联乘客信息
    static func relevancePassengerInfoWithPhoneNum(phoneNum: String, psgName: String) -> Dictionary<String, AnyObject> {
        return ["action":"add_psg_apply", "mobile": phoneNum, "psgName": psgName, "cityId": cityId]
    }
    
    // 关联乘车提醒的申请记录
    static func getHistoryOfRelevanceInfo() -> Dictionary<String, AnyObject> {
        return ["action": "get_psg_applyList", "cityId": cityId]
    }
    
    // 获取乘车消息设置详情
    static func getRiderSettingDetail() -> Dictionary<String, AnyObject> {
        return ["action": "get_msg_rmds", "cityId": cityId]
    }
    
    // 设置乘车信息推送
    static func setRidePush(isRecRmsg: Int, isRecSmsg: Int) -> Dictionary<String, AnyObject> {
        return ["action": "edit_msg_rmds", "isRecRmsg": isRecRmsg, "isRecSmsg": isRecSmsg, "cityId": cityId]
    }
    
    // 订单详情
    static func getOrderDetail(orderId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "order_detail", "orderId": orderId, "cityId": cityId]
    }
    
    // 获取退款提示信息
    static func getUnsubscribedInfo(orderId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "order_rfdinfo", "orderId": orderId, "cityId": cityId]
    }
    
    // 退款申请
    static func refundApply(orderId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "order_rfdapply", "orderId": orderId, "cityId": cityId]
    }
    
    // 补卡申请
    static func rePayCardWithOrderId(orderId: Int, uasId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "order_reissueCard", "orderId": orderId, "uasId": uasId, "cityId": cityId]
    }
    
    // 选座初始化参数
    static func seatInitWithLineId(lineId: Int, classId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "seat_init", "lineId": lineId, "classesId": classId, "cityId": cityId]
    }
    
    // 添加乘客
    static func addPassengerWithIdNo(idNo: String, name: String, isSend: Int, captcha: String) -> Dictionary<String, AnyObject> {
        return ["action": "add_passenger", "idNo": idNo, "name": name, "isSend": isSend, "captcha": captcha, "cityId": cityId]
    }
    
    // 获取意见反馈列表
    static func getSuggestionsList(start: Int = 0, limit: Int = 50) -> Dictionary<String, AnyObject> {
        return ["action": "get_feedback_list", "start": start, "limit": limit, "cityId": cityId]
    }
    
    // 获取意见反馈类型
    static func getSuggestionsProblemType() -> Dictionary<String, AnyObject> {
        return ["action":"get_cat_for_feedback", "cityId": cityId]
    }
    
    // 提交问题反馈
    static func submitSuggestionsProblem(code: String, content: String) -> Dictionary<String, AnyObject> {
        return ["action": "add_feedback", "code": code, "content": content, "cityId": cityId]
    }
    
    // 获取消息提醒类型
    static func getMsgRemindingType() -> Dictionary<String, AnyObject> {
        return ["action": "get_msg_types", "cityId": cityId]
    }
    
    // 获取消息提醒列表
    static func getMsgRemindingListWithType(msgType: Int, start: Int = 0, limit: Int = 20) -> Dictionary<String, AnyObject> {
        return ["action": "get_msg_list", "start": start, "limit": limit, "msgType": msgType, "cityId": cityId]
    }
    
    // 获取消息提醒详细内容
    static func getMsgRemindingDetailContentWithCmrId(cmrId: Int, msgType: Int) -> Dictionary<String, AnyObject> {
        return ["action": "get_msg_detail", "cmrId": cmrId, "msgType": msgType, "cityId": cityId]
    }
    
    // 是否通过用户关联申请 2=拒绝，3=同意
    static func replyToRelevanceWithCmrId(cmrId: Int, msgStatus: Int) -> Dictionary<String, AnyObject> {
        return ["action": "reply_to_rela", "cmrId": cmrId, "msgStatus": msgStatus, "cityId": cityId]
    }
    
    // 获取我定制的线路列表
    static func getMyCollectionLineListWithStart(start: Int = 0, limit :Int = 20) -> Dictionary<String, AnyObject> {
        return ["action": "get_myCusLine_list", "start": start, "limit": limit, "cityId": cityId]
    }
    
    // 取消定制
    static func cancelCollectionLineWithlclrId(lclrId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "cancel_custom_line", "lclrId": lclrId, "cityId": cityId]
    }
    
    // 获取我参与的线路列表
    static func getMyParTakeLineListWithStart(start: Int = 0, limit :Int = 20) -> Dictionary<String, AnyObject> {
        return ["action": "get_myAttLine_list", "start": start, "limit": limit, "cityId": cityId]
    }
    
    // 取消定制
    static func cancelMyParTakeLineWithlclrId(attendId: Int, type: Int) -> Dictionary<String, AnyObject> {
        return ["action": "cancel_attend_line", "attendId": attendId, "type": type, "cityId": cityId]
    }
    
    // 切换当前城市
    static func switchCityWithCityId(cityId: Int) -> Dictionary<String, AnyObject> {
        return ["action": "city_switch", "cityId": cityId]
    }
    
    static func transformGradeToNum(grade: String) -> String {
        var num : String
        switch grade {
        case "一年级": num="1";
        case "二年级": num="2";
        case "三年级": num="3";
        case "四年级": num="4";
        case "五年级": num="5";
        case "六年级": num="6";
        case "初一": num="7";
        case "初二": num="8";
        case "初三": num="9";
        case "高一": num="a";
        case "高二": num="b";
        case "高三": num="c";
        default: num="1"
        }
        return num
    }
}