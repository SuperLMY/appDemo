//
//  DEBUGLOG.h
//  building
//
//  Created by 李明洋 on 2018/6/5.
//  Copyright © 2018年 datalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DEBUGLOG;

@protocol DEBUGLOGVieWDelegate <NSObject>

-(void)viewDiddismissed;

@end

@interface DEBUGLOG : UIView

@property (weak, nonatomic) id<DEBUGLOGVieWDelegate> delegate;
@property (strong, nonatomic) NSArray *logArray;

-(void)startDebug;
-(void)endDebug;
-(void)debugShow;
-(void)debugHidden;

@end

@interface DebugManager : NSObject <DEBUGLOGVieWDelegate>

+(void)addMessage:(id)message time:(NSString *)time success:(BOOL)success;
+(instancetype)shareInstance;
-(void)initUI;
-(void)allowDebug;
-(void)reloadData;
-(void)saveData;

@property (strong, nonatomic) DEBUGLOG *view;
@property (assign, nonatomic) BOOL isShow;      //查看中？
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@interface LogModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) id message;
@property (assign, nonatomic) BOOL success;

-(instancetype)initWithMSG:(id)message time:(NSString *)time success:(BOOL)success;

@end;
