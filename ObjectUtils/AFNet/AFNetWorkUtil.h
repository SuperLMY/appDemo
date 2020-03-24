//
//  AFNetWorkUtil.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/6.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AFNetMethods) {
    AFNetMethodGET = 0,
    AFNetMethodPOST,
    AFNetMethodPUT,
    AFNetMethodDELETE,
};

typedef NS_ENUM(NSInteger, ParameterStyle) {
    ParameterStyleQuary = 0,
    ParameterStyleJson,
    ParameterStyleOther,
};

@interface AFNetWorkUtil : NSObject

+(void)AFNetURL:(NSString *)url method:(AFNetMethods)method ParameterStyle:(ParameterStyle)style timeOut:(float)time body:(id _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

+(void)AFNetURL:(NSString *)url method:(AFNetMethods)method ParameterStyle:(ParameterStyle)style body:(id _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
/** POST 默认json上传格式 */
+(void)AFPOSTNetURL:(NSString *)url body:(id _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/** POST 自定上传格式 */
+(void)AFPOSTNetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(id _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/** PUT 自定上传格式 */
+(void)AFPUTNetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(NSDictionary * _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/** PUT 默认json */
+(void)AFPUTNetURL:(NSString *)url body:(NSDictionary * _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/** GET 有参数 */
+(void)AFGETNetURL:(NSString *)url body:(NSDictionary * _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
/** GET 默认Quary上传格式 */
+(void)AFGETNetURL:(NSString *)url success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/** DELETE 默认json上传格式 */
+(void)AFDELETENetURL:(NSString *)url body:(NSDictionary * _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

+(void)AFDELETENetURL:(NSString *)url ParameterStyle:(ParameterStyle)style body:(NSDictionary * _Nullable )body success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
