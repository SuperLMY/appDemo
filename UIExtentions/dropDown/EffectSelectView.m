//
//  EffectSelectView.m
//  iCar
//
//  Created by 李明洋 on 2017/12/6.
//  Copyright © 2017年 Mobisit. All rights reserved.
//

#import "EffectSelectView.h"
#import "BGlayerView.h"

#define EFF_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define EFF_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EffectSelectView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *selectStr;
}
@property (strong, nonatomic) BGlayerView *backView;

@property (strong, nonatomic) UITableView *mtableView;

@property (strong, nonatomic) UIButton *reSetBtn;

//@property (assign, nonatomic) bar

@end

@implementation EffectSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIColor *)selectColor{
    if (!_selectColor) {
        _selectColor = [UIColor redColor];
    }
    return _selectColor;
}

-(UITableView *)mtableView{
    if (!_mtableView) {
        _mtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, EFF_SCREEN_WIDTH, 200) style:UITableViewStylePlain];
        _mtableView.delegate = self;
        _mtableView.dataSource = self;
        _mtableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _mtableView.scrollEnabled = NO;
        [_mtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    return _mtableView;
}

-(UIButton *)reSetBtn{
    if (!_reSetBtn) {
        _reSetBtn = [[UIButton alloc]init];
        _reSetBtn.backgroundColor = [UIColor whiteColor];
        _reSetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_reSetBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_reSetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reSetBtn addTarget:self action:@selector(reSetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reSetBtn;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[BGlayerView alloc]initWithFrame:CGRectMake(0, 0, EFF_SCREEN_WIDTH, EFF_SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.colorframe = CGRectMake(0, _startPoint.y, EFF_SCREEN_WIDTH, EFF_SCREEN_HEIGHT-_startPoint.y);
        _backView.topColor = [UIColor colorWithWhite:0.3 alpha:0.6];
        _backView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction:)];
        [_backView addGestureRecognizer:tap];
    }
    
    return _backView;
}

-(AnimationType)moveType{
    if (!_moveType) {
        _moveType = AnimationTypeFromTop;
    }
    return _moveType;
}

-(void)showInSuperView:(UIView *)superView{
    if (!superView) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    if (!superView) {
        superView = [UIApplication sharedApplication].windows.lastObject;
    }
    if (!superView) {
        superView = [UIApplication sharedApplication].windows.firstObject;
    }
    [superView addSubview:self.backView];
    
    [superView addSubview:self];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.frame = CGRectMake(0, _startPoint.y, EFF_SCREEN_WIDTH, 0);
    
    self.mtableView.frame = CGRectMake(0, 0, EFF_SCREEN_WIDTH, _array.count*50.0);
    [self addSubview:self.mtableView];
    CGFloat reSetHeight = 0.0;
    if (_showReSet) {
        reSetHeight = 50;
        self.reSetBtn.frame = CGRectMake(0, _array.count*50.0, EFF_SCREEN_WIDTH, 50);
        [self addSubview:self.reSetBtn];
    }
    if (_startPoint.y+_array.count*50 > EFF_SCREEN_HEIGHT-reSetHeight) {
        self.mtableView.frame = CGRectMake(0, 0, EFF_SCREEN_WIDTH, EFF_SCREEN_HEIGHT-_startPoint.y-reSetHeight);
        self.reSetBtn.frame = CGRectMake(0, EFF_SCREEN_HEIGHT-_startPoint.y-reSetHeight, EFF_SCREEN_WIDTH, reSetHeight);
        self.mtableView.scrollEnabled = YES;
    }
    __weak typeof(self) weakself = self;
    if(_moveType == AnimationTypeFromTop){
        [UIView animateWithDuration:0.3 animations:^{
            weakself.backView.alpha = 1.0;
            weakself.frame = CGRectMake(0, weakself.startPoint.y, EFF_SCREEN_WIDTH, weakself.array.count*50.0+reSetHeight);
        } completion:nil];
    }
}

-(void)reSetAction:(id)sender{
    __weak typeof(self) weakSelf = self;
    if (_delegate && [_delegate respondsToSelector:@selector(EffectViewReSet:)]) {
        [_delegate EffectViewReSet:weakSelf];
    }
    [self closeAction:nil];
}

-(void)closeAction:(id)sender{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.backView.alpha = 0.01;
        self.frame = CGRectMake(0, weakself.startPoint.y, EFF_SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        if ([weakself.delegate respondsToSelector:@selector(EffectViewCancel:)]) {
            [weakself.delegate EffectViewCancel:self];
        }
        [weakself.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    id obj = [_array objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.textLabel.text = (NSString *)obj;
    }else{
        cell.textLabel.text = [_delegate EffectSelectView:self parsing:obj];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (_selectStyle == SelectCellStyleNull) {
        
    }else if(_selectStyle == SelectCellStyleCheck){
        if (indexPath.row == _selectIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if(_selectStyle == SelectCellStyleTextColor){
        if (indexPath.row == _selectIndex) {
            cell.textLabel.textColor = self.selectColor;
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }else if(_selectStyle == SelectCellStyleBackColor){
        if (indexPath.row == _selectIndex) {
            cell.backgroundColor = self.selectColor;
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (_delegate && [_delegate respondsToSelector:@selector(EffectSelectView:didSelect:index:)]) {
        [_delegate EffectSelectView:weakSelf didSelect:[_array objectAtIndex:indexPath.row] index:indexPath.row];
    }
    [self closeAction:nil];
}

@end
