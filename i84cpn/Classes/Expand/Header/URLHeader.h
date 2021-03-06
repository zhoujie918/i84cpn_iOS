//
//  URLHeader.h
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

#ifndef URLHeader_h
#define URLHeader_h

//固定部分
//#define URL_FIXED @"http://jiangxfa.i84.com.cn:80"  //测试环境
//#define URL_FIXED @"http://jiangxfa.i84.com.cn"  //测试环境
//#define URL_FIXED @"http://250a.i84.com.cn:8080"  //测试环境
#define URL_FIXED @"http://cpn.5i84.cn"         //外网测试环境
//#define URL_FIXED @"http://cpn.5i84.cn:8080"
//#define URL_FIXED  @"http://192.168.1.237:8080/"
//#define URL_FIXED @"http://clife.5i84.cn"  //正式环境

//登录  post
#define URL_LOGIN [NSString stringWithFormat:@"%@%@",URL_FIXED,@"/login"]
//调起支付宝接口  post
#define URL_AUTH_API [NSString stringWithFormat:@"%@%@",URL_FIXED,@"/auth/api"]




#endif /* URLHeader_h */
