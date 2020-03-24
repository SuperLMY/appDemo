//
//  DEBUGLOG.m
//  building
//
//  Created by 李明洋 on 2018/6/5.
//  Copyright © 2018年 datalk. All rights reserved.
//

#import "DEBUGLOG.h"
#import "DebugLogTableCell.h"

@interface DEBUGLOG ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIButton *hidBtn;
@property (strong, nonatomic) UITableView *LogView;

@end

@implementation DEBUGLOG

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    return self;
}

-(void)startDebug{
    [self addSubview:self.LogView];
    [self addSubview:self.hidBtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)endDebug{
    [self removeFromSuperview];
}

-(void)debugShow{
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = 0;
        self.frame = frame;
    } completion:^(BOOL finished) {
        //self.hidden = YES;
    }];
}

-(void)debugHidden{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = SCREEN_WIDTH;
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.delegate viewDiddismissed];
    }];
}

-(UIButton *)hidBtn{
    if (!_hidBtn) {
        _hidBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT)];
        [_hidBtn setTitle:@"隐藏" forState:UIControlStateNormal];
        [_hidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_hidBtn addTarget:self action:@selector(debugHidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hidBtn;
}

-(UITableView *)LogView{
    if (!_LogView) {
        _LogView = [[UITableView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-80, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [_LogView registerNib:[UINib nibWithNibName:@"DebugLogTableCell" bundle:nil] forCellReuseIdentifier:@"DebugLogTableCell"];
        _LogView.delegate = self;
        _LogView.dataSource = self;
        _LogView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
        _LogView.rowHeight = UITableViewAutomaticDimension;
        _LogView.estimatedRowHeight = 100;
    }
    return _LogView;
}

-(void)setLogArray:(NSArray *)logArray{
    _logArray = logArray;
    if (_LogView) {
        [_LogView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.logArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLogTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DebugLogTableCell"];
    if (!cell) {
        cell = [[UINib nibWithNibName:@"DebugLogTableCell" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    }
    LogModel *model = _logArray[indexPath.row];
    cell.timeLabel.text = model.time;
    cell.messageLabel.text = model.message;
    if(model.success){
        cell.iconView.image = [UIImage imageNamed:@"net_success"];
    }else{
        cell.iconView.image = [UIImage imageNamed:@"net_error"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end

@implementation DebugManager

+(void)addMessage:(id)message time:(NSString *)time success:(BOOL)success{
//    NSLog(@"上传消息");
    DebugManager *manager = [DebugManager shareInstance];
    if(manager.isShow){
        LogModel *model = [[LogModel alloc]initWithMSG:message time:time success:success];
        [manager.dataArray insertObject:model atIndex:0];
        [manager reloadData];
    }else{
        LogModel *model = [[LogModel alloc]initWithMSG:message time:time success:success];
        [manager.dataArray insertObject:model atIndex:0];
        [manager saveData];
    }
    
}

static DebugManager *instance = nil;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DebugManager alloc]init];
    });
    return instance;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[self path]]];
        //NSLog(@"array = %@",array);
        if (array) {
            if (array.count > 10) {
                array = [array subarrayWithRange:NSMakeRange(0, 10)];
            }
            [_dataArray addObjectsFromArray:array];
        }
    }
    return _dataArray;
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    [DebugManager addMessage:[NSString stringWithFormat:@"%@\n %@\n %@",name,reason,arr] time:nil success:NO];
}

-(void)initUI{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    _view = [[DEBUGLOG alloc]init];
    _view.logArray = self.dataArray;
    _view.delegate = self;
}

-(void)allowDebug{
    _view.logArray = self.dataArray;
    if (!_view.superview) {
        [_view startDebug];
    }
    [_view debugShow];
    _isShow = YES;
}

-(void)viewDiddismissed{
    _isShow = NO;
}

-(void)saveData{
    if (_dataArray) {
        if (_dataArray.count > 30) {
            _dataArray = [_dataArray subarrayWithRange:NSMakeRange(0, 30)].mutableCopy;
        }
        BOOL success = [NSKeyedArchiver archiveRootObject:_dataArray toFile:[self path]];
        NSLog(@"写入 %@",@(success));
    }
}

-(void)reloadData{
    self.view.logArray = self.dataArray;
    [self saveData];
}

- (NSString *)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *dstPath = [documentDir stringByAppendingPathComponent:@"debugLog.data"];
    return dstPath;
}


@end

@implementation LogModel

-(instancetype)initWithMSG:(id)message time:(NSString *)time success:(BOOL)success{
    self = [super init];
    if (self) {
        self.message = [NSString stringWithFormat:@"%@",message];
        self.time = time;
        self.success = success;
    }
    return self;
}

-(void)setTime:(NSString *)time{
    if (time) {
        _time = time;
    }else{
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *timeStr = [format stringFromDate:[NSDate date]];
        _time = timeStr;
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeBool:self.success forKey:@"success"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.success = [aDecoder decodeBoolForKey:@"success"];
    }
    return self;
}


@end

