//
//  addCustomerViewController.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/7.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "BaseFormViewController.h"
#import "TableGroupHeaderView.h"
#import "TableGroupHeaderImageView.h"
#import "TableGroupFooterView.h"
#import "TextFeildTableViewCell.h"
#import "SigleSelectTableViewCell.h"
#import "DateSelectTableViewCell.h"
#import "ImageViewTableViewCell.h"

@interface BaseFormViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *bottomView;

@end

@implementation BaseFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    _tableView.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TableGroupHeaderView class] forHeaderFooterViewReuseIdentifier:@"TableGroupHeaderView"];
    [_tableView registerClass:[TableGroupHeaderImageView class] forHeaderFooterViewReuseIdentifier:@"TableGroupHeaderImageView"];
    [_tableView registerClass:[TableGroupFooterView class] forHeaderFooterViewReuseIdentifier:@"TableGroupFooterView"];
    [_tableView registerNib:[UINib nibWithNibName:@"TextFeildTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextFeildTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SigleSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"SigleSelectTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"DateSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"DateSelectTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NormalTableViewCell" bundle:nil] forCellReuseIdentifier:@"NormalTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ImageViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImageViewTableViewCell"];

    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-IPHONEX_BOTTOM, SCREEN_WIDTH, 50)];
    _bottomView.backgroundColor = [UIColor whiteColor];
}

-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(11, 5, SCREEN_WIDTH-22, 40)];
        _bottomBtn.backgroundColor = RGB(244, 116, 17);
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font(15);
        _bottomBtn.layer.cornerRadius = 20;
        _bottomBtn.layer.masksToBounds = YES;
        [self.view addSubview:_bottomView];
        [_bottomView addSubview:_bottomBtn];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-_bottomView.frame.size.height-IPHONEX_BOTTOM);
    }
    return _bottomBtn;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupItem.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *model = _groupItem[section];
    return model.GroupItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 6;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GroupModel *model = self.groupItem[section];
    NSString *identifier = nil;
    if (model.imageName) {
        identifier = @"TableGroupHeaderImageView";
    }else{
        identifier = @"TableGroupHeaderView";
    }
    TableGroupHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    header.titleLabel.text = model.title;
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TableGroupFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableGroupFooterView"];
    return footer;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupModel *model = self.groupItem[indexPath.section];
    GroupItems *item = model.GroupItems[indexPath.row];
    GroupSuperViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier];
    [cell setModel:item];
    cell.row = indexPath.row;
    cell.section = indexPath.section;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
