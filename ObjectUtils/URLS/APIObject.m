//
//  APIObject.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "APIObject.h"

@implementation APIObject

+(NSString *)getHomeUrl{
    if (APPProduction.integerValue == 0) {                  // 开发
        return @"http://39.108.5.27";
    }else if (APPProduction.integerValue == 1){             // 测试
        return @"http://120.24.47.211:8080";
//        return @"http://120.24.47.211";
    }else{
        return @"https://api.jzwcars.cn";                    // 生产
    }
}

+(NSString *)getHTML5HomeUrl{
    if (APPProduction.integerValue == 0) {
        return @"http://39.108.5.27:44555";
    }else if (APPProduction.integerValue == 1){
        return @"http://120.24.47.211:8000";
    }else{
        return @"https://mwx.jzwcars.cn/share";
    }
}

-(NSString *)pushBind{    
    return [NSString stringWithFormat:@"%@/message-push-service/api/v1/mp/bindDevice",URLHOME];
}

-(NSString *)uploadToken{
    return [NSString stringWithFormat:@"%@/file-service/upload_token",URLHOME];
}

-(NSString *)getTopAssessmentList{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/top",URLHOME];
}

-(NSString *)assessmentValues{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/values",URLHOME];
}

-(NSString *)assessment{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/second",URLHOME];
}

-(NSString *)assessmentOption{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/third",URLHOME];
}

-(NSString *)assessmentSummary{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/summary",URLHOME];
}

-(NSString *)assessmentbaseinfo{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/baseInfo",URLHOME];
}

-(NSString *)assessmentDetail{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/detail",URLHOME];
}

-(NSString *)maintenance{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/maintenance",URLHOME];
}

-(NSString *)carInfoGroup{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/groups",URLHOME];
}

-(NSString *)getUploadImg{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/imgs",URLHOME];
}

-(NSString *)edit_assessment{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/edit_assessment",URLHOME];
}

-(NSString *)loginUrl{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/auth/login",URLHOME];
}

-(NSString *)forgetPasdCode{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/sms/forgetPassword",URLHOME];
}

-(NSString *)modifyPasd{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/user/modifyPassword",URLHOME];
}

-(NSString *)logOutUrl{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/auth/logout",URLHOME];
}

-(NSString *)password{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/user/password",URLHOME];
}

-(NSString *)CarBrands{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/brandsMany",URLHOME];
}

-(NSString *)CarModel{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/models",URLHOME];
}

-(NSString *)commonOptions{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/options",URLHOME];
}

-(NSString *)configValue{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/configValue/",URLHOME];
}

-(NSString *)configoptions{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/model/configOption/",URLHOME];
}

-(NSString *)CarModelByOption{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/modelsByOption",URLHOME];
}

-(NSString *)CarModelSearch{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/common/search-models",URLHOME];
}

-(NSString *)userProfile{
    return [NSString stringWithFormat:@"%@/user-service/api/v1/user/profile",URLHOME];
}

-(NSString *)record{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/record",URLHOME];
}

-(NSString *)editAbled{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/assessment/editAbled",URLHOME];
}

-(NSString *)inquiry{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/inquiry",URLHOME];
}

-(NSString *)inquiryRenew{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/inquiry/renew",URLHOME];
}

-(NSString *)inquiryRestart{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/inquiry/restart",URLHOME];
}

-(NSString *)verifyInquiryStatus{
    return [NSString stringWithFormat:@"%@/vehicle-service/api/v1/inquiry/verifyInquiryStatus",URLHOME];
}

-(NSString *)order{
    return [NSString stringWithFormat:@"%@/order-service/api/v1/order/purchase",URLHOME];
}

-(NSString *)cancelOrder{
    return [NSString stringWithFormat:@"%@/order-service/api/v1/order/purchase/cancel",URLHOME];
}

-(NSString *)orderConfirm{
    return [NSString stringWithFormat:@"%@/order-service/api/v1/order/purchase/confirmReceipt",URLHOME];
}

-(NSString *)orderResave{
    return [NSString stringWithFormat:@"%@/order-service/api/v1/order/purchase/resave",URLHOME];
}

-(NSString *)orderInvalid{
    return [NSString stringWithFormat:@"%@/order-service/api/v1/order/purchase/invalid",URLHOME];
}

-(NSString *)inspectorList{
    return [NSString stringWithFormat:@"%@/system-admin-service/api/v1/shopRelation/queryByInspector",URLHOME];
}

-(NSString *)shopSeller{
    return [NSString stringWithFormat:@"%@/system-admin-service/api/v1/shop/getSellerList",URLHOME];
}

-(NSString *)ocrAliyun{
    return [NSString stringWithFormat:@"%@/file-service/ocr/vehicle-registration",URLHOME];
}

NSString *getToken(){
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

@end
