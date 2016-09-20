//
//  CheckFomatTool.h
//  CarUBenefits
//
//  Created by 海讯175999 on 16/4/23.
//  Copyright © 2016年 YuXiaWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckFomatTool : NSObject

//验证手机号
+(BOOL)checkPhone:(NSString *)phone;

//验证密码
+(BOOL)checkPassword:(NSString *)password;

//验证邮箱
+(BOOL)checkEmail:(NSString *)email;

//身份证验证
+(BOOL)checkIDCard:(NSString*)cardNo;

@end
