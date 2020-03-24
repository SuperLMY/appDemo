//
//  AliyunOSSUtil.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUIDUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface AliyunOSSUtil : NSObject

+(void)OSSClientConfiguration;

-(void)upLoadData:(NSData *)data bucketName:(NSString *)bucketName path:(NSString *)path name:(NSString *)name uploadFinish:(void (^)(NSDictionary *result, BOOL success))finish;

-(void)upLoadUIImage:(UIImage *)image bucketName:(NSString *)bucketName path:(NSString *)path name:(NSString *)name uploadFinish:(void (^)(NSDictionary *result, BOOL success))finish;

@end

@interface AliyunOSSModel : NSObject

@property (strong, nonatomic) NSString *accessKeyId;
@property (strong, nonatomic) NSString *accessKeySecret;
@property (strong, nonatomic) NSString *securityToken;
@property (strong, nonatomic) NSString *expiration;
@property (strong, nonatomic) NSString *endpoint;


@end

NS_ASSUME_NONNULL_END
