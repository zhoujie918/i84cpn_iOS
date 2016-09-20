//
//  CPAlipayModel.h
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

@interface CPAlipayModel : NSObject

@property(nonatomic,strong)NSString *action;    //接口标识
@property(nonatomic,strong)NSString *orderNo;   //订单号
@property(nonatomic,strong)NSString *sysType;   //设备系统类型
@property(nonatomic,strong)NSString *orderType; //订单类型

@property(nonatomic,strong)NSString *lineId;    //线路ID
@property(nonatomic,strong)NSString *classId;   //班次ID


//创建单例
+(CPAlipayModel *)shareCPAlipayModel;

//调起支付宝支付
-(void)alipaySuccessBlock:(void (^)(id responseObject))success failureBlock:(void (^)(NSError *error))failure;


@end
