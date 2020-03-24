//
//  LMYModel.h
//  runtimeDemo
//
//  Created by 李明洋 on 2018/3/21.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LMYModel)

+ (instancetype)lmy_modelWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)lmy_modelWithArray:(NSArray *)array;

@end


