//
//  PictureCycleScrollView.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/11.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "PictureCycleScrollView.h"
#import "PictureCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PictureCycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    int page;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UILabel *pageLabel;
@property (strong, nonatomic) UIImageView *icomView;

@property (strong, nonatomic) NSMutableArray *imageArray;

@end

@implementation PictureCycleScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self addSubview:_collectionView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = Font(10);
    _titleLabel.text = @"车辆编号:56415";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    _titleLabel.layer.cornerRadius = 5.0;
    _titleLabel.layer.masksToBounds = YES;
    [self addSubview:_titleLabel];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-50-15, frame.size.height-25, 50, 15)];
    back.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    back.layer.cornerRadius = 5.0;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    _icomView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2.5, 10, 10)];
    _icomView.contentMode = UIViewContentModeScaleAspectFit;
    _icomView.image = [UIImage imageNamed:@"icon-picture"];
    [back addSubview:_icomView];
    
    _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 30, 15)];
    _pageLabel.font = Font(10);
    _pageLabel.text = @"00/00";
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [_pageLabel setAdjustsFontSizeToFitWidth:YES];
    [back addSubview:_pageLabel];

    // H 水平方向上
    NSArray *colConstsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"collectionView":self.collectionView}];
    // V 垂直方向
    NSArray *colConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"collectionView":self.collectionView}];
    [self addConstraints:colConstsH];
    [self addConstraints:colConstsV];
    // H 水平方向上
    NSArray *titleConstsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleLabel]" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"titleLabel":self.titleLabel}];
    // V 垂直方向
    NSArray *titleConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel(15)]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"titleLabel":self.titleLabel}];
    [self addConstraints:titleConstsH];
    [self addConstraints:titleConstsV];
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count > 0) {
        return self.imageArray.count;
    }else{
        return self.array.count;
    }
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCollectionViewCell" forIndexPath:indexPath];
    NSString *str = nil;
    if (self.imageArray.count > 0) {
        str = _imageArray[indexPath.row];
    }else{
        str = _array[indexPath.row];
    }
//    cell.imageView.image = [UIImage imageNamed:str];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ImageHolder"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex) {
        self.selectIndex(page);
    }
}
////// 设置UIcollectionView整体的内边距（这样item不贴边显示）
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    // 上 左 下 右
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//
//// 设置minimumInteritemSpacing：cell左右之间最小的距离
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_imageArray.count >= 3) {
        CGFloat offx = scrollView.contentOffset.x;
        CGFloat width = _collectionView.frame.size.width;
        if (offx < width*0.5) {
            [self lastPage];
        }else if (offx > width*1.5){
            [self nextPage];
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self loadPageLabel];
}
// 下一页
-(void)nextPage{
    page++;
    if (page+1 > _array.count) {
        page = 0;
    }
    if (page+1 == _array.count) {
        [self.imageArray removeObjectAtIndex:0];
        [self.imageArray addObject:_array.firstObject];
    }else{
        [self.imageArray removeObjectAtIndex:0];
        [self.imageArray addObject:_array[page+1]];
    }
    [_collectionView reloadData];
}
// 上一页
-(void)lastPage{
    page--;
    if (page-1 < -1) {
        page = (int)_array.count-1;
    }
    if (page-1 == -1) {
        [self.imageArray removeObjectAtIndex:2];
        [self.imageArray insertObject:_array.lastObject atIndex:0];
    }else{
        [self.imageArray removeObjectAtIndex:2];
        [self.imageArray insertObject:_array[page-1] atIndex:0];
    }
    [_collectionView reloadData];
}

-(void)loadPageLabel{
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",page+1,(int)_array.count];
}

-(void)setArray:(NSArray *)array{
    _array = array;
    page = 0;
    if (array.count >= 3) {
        [self.imageArray addObject:_array.lastObject];
        [self.imageArray addObject:_array.firstObject];
        [self.imageArray addObject:_array[1]];
    }
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",page+1,(int)_array.count];
    [_collectionView setContentOffset:CGPointMake(_collectionView.frame.size.width, 0) animated:NO];
    [_collectionView reloadData];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = _titleLabel.frame;
    frame.size.width = [self getWidthWithTitle:_titleLabel.text font:_titleLabel.font] + 10;
    _titleLabel.frame = frame;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
