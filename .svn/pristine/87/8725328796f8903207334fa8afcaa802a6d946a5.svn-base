//
//  HttpTool.m
//  CarUBenefits
//
//  Created by 海讯175999 on 16/4/24.
//  Copyright © 2016年 YuXiaWei. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+(void)getWithUrlString:(NSString *)url parameter:(NSString *)param progressBlock:(void (^)(NSProgress *))progress successBlock:(void (^)(id))success failureBlock:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
//    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"" password:@""];

    
     [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
         if (progress) {
             progress(downloadProgress);
         }
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (success) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             success(dic);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (failure) {
             failure(error);
         }
     }];
}



+(void)postWithUrlString:(NSString *)url parameter:(NSDictionary *)param progressBlock:(void (^)(NSProgress *))progress successBlock:(void (^)(id))success failureBlock:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
//    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
////    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"" password:@""];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




@end
