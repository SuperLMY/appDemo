//
//  AFNetWorkUtil.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/6.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "AFNetWorkUtil.h"
#import "AFNetworking.h"

@implementation AFNetWorkUtil

+(void)AFNetURL:(NSString *)url method:(AFNetMethods)method ParameterStyle:(ParameterStyle)style body:(id _Nullable )body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFNetURL:url method:method ParameterStyle:style timeOut:15.f body:body success:success failure:failure];
}

+(void)AFNetURL:(NSString *)url method:(AFNetMethods)method ParameterStyle:(ParameterStyle)style timeOut:(float)time body:(id _Nullable )body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    if (url.length == 0) {
        failure([NSError new]);
        return;
    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    switch (style) {
        case ParameterStyleJson:
        {
            sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
            break;
        case ParameterStyleQuary:
            sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
//        case ParameterStyleFormData:
//            [sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            break;
            
        default:
            break;
    }
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置10秒超时
    [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sessionManager.requestSerializer.timeoutInterval = time;
    [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token) {
        [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"X-AUTH-TOKEN"];
    }
    if (method == AFNetMethodGET) {
        [sessionManager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"httpCode: %d",(int)httpResponse.statusCode);
            if (success) {
                success(jsonDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *errorDict = [self ErrorLog:httpResponse];
            if (errorDict) {
                if (success) {
                    success(errorDict);
                }
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
    }else if (method == AFNetMethodPOST){
        [sessionManager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"httpCode: %d",(int)httpResponse.statusCode);
            if (success) {
                success(jsonDict);
            }
        }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *errorDict = [self ErrorLog:httpResponse];
            if (errorDict) {
                if (success) {
                    success(errorDict);
                }
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
    }else if (method == AFNetMethodPUT){
        [sessionManager PUT:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"httpCode: %d",(int)httpResponse.statusCode);
            if (success) {
                success(jsonDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *errorDict = [self ErrorLog:httpResponse];
            if (errorDict) {
                if (success) {
                    success(errorDict);
                }
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
    }else if (method == AFNetMethodDELETE){
        [sessionManager DELETE:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"httpCode: %d",(int)httpResponse.statusCode);
            if (success) {
                success(jsonDict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *errorDict = [self ErrorLog:httpResponse];
            if (errorDict) {
                if (success) {
                    success(errorDict);
                }
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
    }
}

+(NSDictionary *)ErrorLog:(NSHTTPURLResponse *)httpResponse{
    NSDictionary *result;
    if(httpResponse.statusCode==404){
        result=@{@"code":@"404",@"msg":@"找不到服务器"};
    }else if(httpResponse.statusCode>=500){
        result=@{@"code":@"500",@"msg":@"服务器异常"};
    }else if (httpResponse.statusCode==401){
        result=@{@"code":@"401",@"msg":@"权限不足，请联系管理员！"};
    }else if (httpResponse.statusCode==403){
        result=@{@"code":@"403",@"msg":@"登录已过期"};
    }else if (httpResponse.statusCode==400){
        result=@{@"code":@"400",@"msg":@"参数格式错误"};
    }else{
        NSLog(@"网络异常");
    }
    return result;
}

+(void)AFPOSTNetURL:(NSString *)url body:(NSDictionary *)body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFPOSTNetURL:url ParameterStyle:ParameterStyleJson body:body success:success failure:failure];
}

+(void)AFPOSTNetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(NSDictionary *)body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFNetURL:url method:AFNetMethodPOST ParameterStyle:style body:body success:success failure:failure];
}

+(void)AFGETNetURL:(NSString *)url success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure{
    [self AFGETNetURL:url body:nil success:success failure:failure];
}

+(void)AFGETNetURL:(NSString *)url body:(NSDictionary *)body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFNetURL:url method:AFNetMethodGET ParameterStyle:ParameterStyleQuary body:body success:success failure:failure];
}

+(void)AFDELETENetURL:(NSString *)url body:(NSDictionary * _Nullable)body success:(nonnull void (^)(NSDictionary * _Nonnull))success failure:(nonnull void (^)(NSError * _Nonnull))failure{
    [self AFDELETENetURL:url ParameterStyle:ParameterStyleJson body:body success:success failure:failure];
}

+(void)AFDELETENetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(NSDictionary *)body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFNetURL:url method:AFNetMethodDELETE ParameterStyle:style body:body success:success failure:failure];
}

+(void)AFPUTNetURL:(NSString *)url body:(NSDictionary *)body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure{
    [self AFPUTNetURL:url ParameterStyle:ParameterStyleJson body:body success:success failure:failure];
}

+(void)AFPUTNetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(NSDictionary *)body success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self AFNetURL:url method:AFNetMethodPUT ParameterStyle:style body:body success:success failure:failure];
}

@end
