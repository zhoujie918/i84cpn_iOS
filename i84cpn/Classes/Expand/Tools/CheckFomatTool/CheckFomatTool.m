//
//  CheckFomatTool.m
//  CarUBenefits
//
//  Created by 海讯175999 on 16/4/23.
//  Copyright © 2016年 YuXiaWei. All rights reserved.
//

#import "CheckFomatTool.h"

@implementation CheckFomatTool


+(BOOL)checkPhone:(NSString *)phone{
    BOOL fitstCharact = [phone hasPrefix:@"1"];
    NSInteger lenth = [phone length];
    NSScanner* scan = [NSScanner scannerWithString:phone];
    int val;
    BOOL isPureInt = [scan scanInt:&val] && [scan isAtEnd];
    if (fitstCharact && (lenth == 11) && isPureInt) {
        return YES;
    }
    return NO;
}


+(BOOL)checkPassword:(NSString *)password{
    NSString *passWordRegex = @"^[a-zA-Z0-9_]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}


+(BOOL)checkEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(BOOL)checkIDCard:(NSString*)cardNo
{
    BOOL flag;
    if (cardNo.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardNo];
}


@end
