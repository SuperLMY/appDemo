//
//  LMYModel.m
//  runtimeDemo
//
//  Created by 李明洋 on 2018/3/21.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import "LMYModel.h"
#import <objc/runtime.h>

@implementation NSObject (LMYModel)

+(instancetype)lmy_modelWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

+(NSMutableArray *)lmy_modelWithArray:(NSArray *)array{
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        id object = array[i];
        if ([object isKindOfClass:NSDictionary.class]) {
            NSObject *obj = [self lmy_modelWithDict:object];
            [mArray addObject:obj];
        }else if([object isKindOfClass:NSArray.class]){
            NSArray *childArray = [self lmy_modelWithArray:object];
            [mArray addObject:childArray];
        }else if ([object isKindOfClass:NSString.class]||[object isKindOfClass:NSNumber.class]){
            [mArray addObject:object];
        }else{
            [mArray addObject:object];
        }
    }
    return mArray;
}

+ (instancetype )objectWithDict:(NSDictionary *)dict {
    NSObject *obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}

- (void)setDict:(NSDictionary *)dict {
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            key = [key substringFromIndex:1];// 成员变量名转为属性名（去掉下划线 _ ）
            id value = dict[key];// 取出字典的值
            if (value == nil) continue; // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];// 获得成员变量的类型
            NSRange range = [type rangeOfString:@"@"]; // 如果属性是对象类型
            if (range.location != NSNotFound) {
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)]; // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                // 排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    value = [class objectWithDict:value];
                }else if ([type isEqualToString:@"NSArray"]) {
                    // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    // 获取到每个模型的类型
                    Class class = NSClassFromString(key);
                    if (class) {
                        // 将数组中的所有模型进行字典转模型
                        for (int i = 0; i < array.count; i++) {
                            [mArray addObject:[class objectWithDict:array[i]]];
                        }
                        value = mArray;
                    }else{
                        for (int i = 0; i < array.count; i++) {
                            [mArray addObject:array[i]];
                        }
                    }
                }
            }
            if ([value isEqual:[NSNull null]]) {
                
            }else{
                [self setValue:value forKeyPath:key];// 将字典中的值设置到模型上
            }
        }
        free(ivars);
        c = [c superclass];
    }
}

@end
