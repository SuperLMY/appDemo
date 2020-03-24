//
//  AliyunOSSUtil.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "AliyunOSSUtil.h"
#import <AliyunOSSiOS/AliyunOSSios.h>
#import "AFNetWorkUtil.h"
#import "LMYModel.h"

OSSClient *client;

@implementation AliyunOSSUtil

+(void)OSSClientConfigurationStrong{
    client = nil;
    [self OSSClientConfiguration];
}

+(void)OSSClientConfiguration{
//    [OSSLog enableLog];//执行该方法，开启日志记录
    if (client.endpoint.length < 3) {
        [AFNetWorkUtil AFGETNetURL:[APIObject new].uploadToken body:nil success:^(NSDictionary * _Nonnull result) {
            BaseResult *baseObj = [BaseResult lmy_modelWithDict:result];
            if (baseObj.BaseCode == BaseResultCodeSuccess) {
                NSDictionary *dict = (NSDictionary *)baseObj.data;
                AliyunOSSModel *keyModel = [AliyunOSSModel lmy_modelWithDict:dict];
                NSString *endpoint = keyModel.endpoint;
                // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的访问控制章节
                id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:keyModel.accessKeyId secretKeyId:keyModel.accessKeySecret securityToken:keyModel.securityToken];
                OSSClientConfiguration * conf = [OSSClientConfiguration new];
                conf.maxRetryCount = 2; // 网络请求遇到异常失败后的重试次数
                conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
                conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
                client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential clientConfiguration:conf];
            }else{
                NSLog(@"初始化失败");
            }
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"阿里云初始化失败 网络错误");
        }];
    }
}

-(void)upLoadUIImage:(UIImage *)image bucketName:(NSString *)bucketName path:(NSString *)path name:(NSString *)name uploadFinish:(nonnull void (^)(NSDictionary * _Nonnull, BOOL))finish{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [self upLoadData:data bucketName:bucketName path:path name:name uploadFinish:finish];
    });
}

-(void)upLoadData:(NSData *)data bucketName:(NSString *)bucketName path:(NSString *)path name:(NSString *)name uploadFinish:(nonnull void (^)(NSDictionary * _Nonnull, BOOL))finish{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // required fields
    put.bucketName = bucketName;
    put.objectKey = name;
    put.uploadingData = data;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 上传进度
    };
    put.contentType = @"";
    put.contentMd5 = @"";
    put.contentEncoding = @"";
    put.contentDisposition = @"";
    if (!client) {
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(@{}, NO);
        });
    }
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            OSSTask *mTask = [client presignPublicURLWithBucketName:bucketName withObjectKey:put.objectKey];
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(mTask.result, YES);
            });
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
            [AliyunOSSUtil OSSClientConfigurationStrong];
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(@{}, NO);
            });
        }
        return nil;
    }];
}

- (void)sendResult:(NSMutableDictionary *) resultDict{

}

@end


@implementation AliyunOSSModel

@end
