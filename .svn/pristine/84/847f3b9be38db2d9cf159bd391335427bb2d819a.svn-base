//
//  CPAlipayModel.m
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

#import "CPAlipayModel.h"

@implementation CPAlipayModel


+(CPAlipayModel *)shareCPAlipayModel{
    static CPAlipayModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CPAlipayModel alloc] init];
    });
    return instance;
}


//防止在找不到key的时候崩溃   并打印缺少字段
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"缺少字段%@",key);
}

//如果早不到key直接返回
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

//如果是number型  转成字符串型
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]){
        value = [value stringValue];
    }
    [super setValue:value forKey:key];
}


-(void)alipaySuccessBlock:(void (^)(id responseObject))success failureBlock:(void (^)(NSError *error))failure{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.action,@"action",self.orderNo,@"orderNo",self.sysType,@"sysType",self.orderType,@"orderType", nil];
    NSLog(@"请求支付接口参数 : %@",param);
    
    //请求服务器支付订单数据
    [CPAFHTTPSessionManager postWithUrlString:URL_AUTH_API parameter:param progressBlock:nil successBlock:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
//        NSLog(@"支付接口返回 : %@",dic);
        if ([dic[@"result"][@"success"] intValue] == 1) {
            NSDictionary *dicOrderInfo = dic[@"result"][@"orderInfo"];
            
            /*
             *生成订单信息及签名
             */
            //将商品信息赋予AlixPayOrder的成员变量
//            Order *order = [[Order alloc] init];
//            order.partner = dicOrderInfo[@"partner"];
//            order.sellerID = dicOrderInfo[@"seller_id"];
//            order.outTradeNO = dicOrderInfo[@"out_trade_no"]; //订单ID（由商家自行制定）
//            order.subject = dicOrderInfo[@"subject"]; //商品标题
//            order.body = dicOrderInfo[@"body"]; //商品描述
//            order.totalFee = [NSString stringWithFormat:@"%.2f",[dicOrderInfo[@"total_fee"] floatValue]]; //商品价格
//            order.notifyURL =  dicOrderInfo[@"notify_url"]; //回调URL
//            order.itBPay = dicOrderInfo[@"it_b_pay"];   //超时时间
//            order.service = dicOrderInfo[@"service"];   //@"mobile.securitypay.pay";
//            order.inputCharset = dicOrderInfo[@"_input_charset"];  //@"utf-8";
//            order.paymentType = dicOrderInfo[@"payment_type"];    //@"1";
            //将商品信息拼接成字符串
//            NSString *orderSpec = [order description];
            
            //应用注册scheme,在Info.plist定义URL types
            NSString *appScheme = @"i84cpn";
            
            NSString *sign = dicOrderInfo[@"signContent"]; //签名
//            NSLog(@"支付宝支付字段 : %@",sign);
            
//            NSString *orderString = nil;
            if (sign != nil) {
//                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",dicOrderInfo[@"signContent"], sign, dicOrderInfo[@"sign_type"]];
                
                [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                    NSLog(@"支付宝支付结果 : %@",resultDic);

                    if ([resultDic[@"resultStatus"] intValue] == 6001) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消支付" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                        [alert show];
                    } else if ([resultDic[@"resultStatus"] intValue] == 6002) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请检查网络" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                        [alert show];
                    }else if ([resultDic[@"resultStatus"] intValue]==9000) {
                        NSLog(@"支付宝支付成功");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付宝支付成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                        [alert show];
                        if (success) {
                            success(resultDic);
                        }
                        
                    }else{
                        
                        if ([resultDic[@"resultStatus"] intValue] == 4000) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单支付失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                            [alert show];
                        }
                        NSString *resultMes = resultDic[@"memo"];
                        resultMes = (resultMes.length<=0 ? @"支付失败,未知原因":resultDic[@"memo"]);
                        NSLog(@"支付失败原因 : %@",resultMes);
                        if (failure) {
                            failure((NSError *)resultMes);
                        }
                    }
                    
                }];
                
            }
            
        }else{
            NSString *msg = dic[@"result"][@"msg"] ;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alert show];
        }
        
    } failureBlock:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}








@end
