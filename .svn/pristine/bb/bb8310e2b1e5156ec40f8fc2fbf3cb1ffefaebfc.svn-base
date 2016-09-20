//
//  HttpTool.h
//  CarUBenefits
//
//  Created by 海讯175999 on 16/4/24.
//  Copyright © 2016年 YuXiaWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject


+(void)getWithUrlString:(NSString *)url parameter:(NSString *)param progressBlock:(void (^)(NSProgress *progress))progress successBlock:(void (^)(id responseObject))success failureBlock:(void (^)(NSError *error))failure;


+(void)postWithUrlString:(NSString *)url parameter:(NSDictionary *)param progressBlock:(void (^)(NSProgress *progress))progress successBlock:(void (^)(id responseObject))success failureBlock:(void (^)(NSError *error))failure;

@end
