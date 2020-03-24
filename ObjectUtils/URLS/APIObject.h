//
//  APIObject.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define URLHOME [APIObject getHomeUrl]

// h5地址
#define H5URLHOME [APIObject getHTML5HomeUrl]       //测试环境

@interface APIObject : NSObject

/** 推送绑定 */
@property (strong, nonatomic) NSString *pushBind;

/** OSS初始化数据 */
@property (strong, nonatomic) NSString *uploadToken;

/** 功能检测 */
@property (strong, nonatomic) NSString *getTopAssessmentList;

/** 功能检测二级列表 */
@property (strong, nonatomic) NSString *assessment;

/** 功能检测三级级列表 */
@property (strong, nonatomic) NSString *assessmentOption;

/** 测评结论 */
@property (strong, nonatomic) NSString *assessmentSummary;

/** 车辆基本信息（查看功能） */
@property (strong, nonatomic) NSString *assessmentbaseinfo;

/** 车辆检测详情（查看功能） */
@property (strong, nonatomic) NSString *assessmentDetail;

/** 车辆保养详情（查看功能） */
@property (strong, nonatomic) NSString *maintenance;

/** 车辆参数（查看功能） */
@property (strong, nonatomic) NSString *carInfoGroup;

/** 上传二级列表 */
@property (strong, nonatomic) NSString *assessmentValues;

/** 上传检测图片 */
@property (strong, nonatomic) NSString *getUploadImg;

/** 修改车型基本信息 */
@property (strong, nonatomic) NSString *edit_assessment;

/** 登录 */
@property (strong, nonatomic) NSString *loginUrl;

/** 忘记密码验证码 */
@property (strong, nonatomic) NSString *forgetPasdCode;

/** 忘记密码 */
@property (strong, nonatomic) NSString *modifyPasd;

/** 注销登录 */
@property (strong, nonatomic) NSString *logOutUrl;

/** 修改个人密码 */
@property (strong, nonatomic) NSString *password;

/** GET：获取个人数据， PUT：修改头像 */
@property (strong, nonatomic) NSString *userProfile;

/** 车辆列表 */
@property (strong, nonatomic) NSString *CarBrands;

/** 车型列表 */
@property (strong, nonatomic) NSString *CarModel;

/** 车型模糊查询 */
@property (strong, nonatomic) NSString *CarModelSearch;

/** 配置选项列表 */
@property (strong, nonatomic) NSString *commonOptions;
/** 配置选项列表 */
@property (strong, nonatomic) NSString *configoptions;
/** 车型列表by筛选条件 */
@property (strong, nonatomic) NSString *CarModelByOption;

/** 车辆配置信息  */
@property (strong, nonatomic) NSString *configValue;

/** 评估记录列表 */
@property (strong, nonatomic) NSString *record;

/** 查询车辆检测记录是否可以编辑 */
@property (strong, nonatomic) NSString *editAbled;

/** 询价列表  GET获取列表  POST发起询价 */
@property (strong, nonatomic) NSString *inquiry;

/** 询价列表操作 PUT二次询价 */
@property (strong, nonatomic) NSString *inquiryRenew;

/** 询价列表操作 PUT重新询价 +/{id} */
@property (strong, nonatomic) NSString *inquiryRestart;

/** 询价列表 是否能提交 +/{id} */
@property (strong, nonatomic) NSString *verifyInquiryStatus;

/** 订单列表 GET获取订单列表，  POST 创建订单 */
@property (strong, nonatomic) NSString *order;

/** 取消订单 +/{orderid} */
@property (strong, nonatomic) NSString *cancelOrder;

/** 确认收款 +/{orderid} */
@property (strong, nonatomic) NSString *orderConfirm;

/** 重新申请订单 */
@property (strong, nonatomic) NSString *orderResave;

/** 异常订单列表 */
@property (strong, nonatomic) NSString *orderInvalid;
/** 门店列表 */
@property (strong, nonatomic) NSString *inspectorList;

/** 门店员工 */
@property (strong, nonatomic) NSString *shopSeller;

@property (strong, nonatomic) NSString *ocrAliyun;

extern NSString *getToken(void);

+(NSString *)getHomeUrl;

+(NSString *)getHTML5HomeUrl;

@end

NS_ASSUME_NONNULL_END
