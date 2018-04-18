//
//  LWSegmentView.m
//  LWModules
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWSegmentView.h"
#import <Masonry.h>
#import "LWSegmentViewCollectionViewCell.h"

@interface LWSegmentView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, assign)NSInteger selectedItem;

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)UIView *slipView;

@property(nonatomic, copy)void(^cellBlock)(UILabel *label, id customObj, NSInteger index);
@property(nonatomic, copy)void(^selectedBlock)(UILabel *label, id customObj, NSInteger orgIndex, NSInteger curIndex);
@property(nonatomic, copy)void(^deselectedBlock)(UILabel *label, id customObj, NSInteger index);

@property(nonatomic, assign)NSInteger currentSelectedIndex;

@end

@implementation LWSegmentView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.slipAnimationTime = 0.3;
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubviews{
    [self addSubview:self.collectionView];
    [self addSubview:self.slipView];
}

- (void)addConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
    
    [self.slipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView);
        make.bottom.equalTo(self.collectionView);
        make.height.mas_equalTo(2);
        if (self.cellWidth<=0) {
            make.width.mas_equalTo(100);
        }else{
            make.width.mas_equalTo(self.cellWidth);
        }
    }];
    
}

- (void)customCellBlock:(void (^)(UILabel *, id, NSInteger))customBlock{
    self.cellBlock = customBlock;
}
- (void)customSelectedBlock:(void (^)(UILabel *, id, NSInteger, NSInteger))selectedBlock{
    self.selectedBlock = selectedBlock;
}
- (void)customDeselectedBLock:(void (^)(UILabel *, id, NSInteger))deselectedBlock{
    self.deselectedBlock = deselectedBlock;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row != self.currentSelectedIndex) {
        NSInteger orgIndex = self.currentSelectedIndex;
        self.currentSelectedIndex = indexPath.row;
        UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
        CGRect cellRect = [collectionView convertRect:cell.frame toView:collectionView];
        [UIView animateWithDuration:self.slipAnimationTime animations:^{
            [self.slipView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellRect.origin.x);
            }];
            if (self.deselectedBlock) {
                LWSegmentViewCollectionViewCell *cell = (LWSegmentViewCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:orgIndex inSection:0]];
                self.deselectedBlock(cell.titleLabel, self.sourceArr[orgIndex], orgIndex);
            }
            if (self.selectedBlock) {
                LWSegmentViewCollectionViewCell *cell = (LWSegmentViewCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentSelectedIndex inSection:0]];
                self.selectedBlock(cell.titleLabel, self.sourceArr[self.currentSelectedIndex], orgIndex , self.currentSelectedIndex);
            }
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.frame.size.height == 0) {
        //使用自动布局有可能获取不到frame,强制布局产生frame
        [self layoutIfNeeded];
    }
    if (self.cellWidth<=0) {
        return CGSizeMake(100, self.frame.size.height);
    }else{
        return CGSizeMake(self.cellWidth, self.frame.size.height);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LWSegmentViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLWSegmentViewCollectionViewCell forIndexPath:indexPath];
    if (self.cellBlock) {
        self.cellBlock(cell.titleLabel, self.sourceArr[indexPath.row], indexPath.row);
        if (indexPath.row == self.currentSelectedIndex) {
            if (self.selectedBlock) {
                self.selectedBlock(cell.titleLabel, self.sourceArr[indexPath.row], indexPath.row, indexPath.row);
            }
        }else{
            if (self.deselectedBlock) {
                self.deselectedBlock(cell.titleLabel, self.sourceArr[indexPath.row], indexPath.row);
            }
        }
        return cell;
    }else{
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        if (indexPath.row == self.currentSelectedIndex) {
            if (self.selectedBlock) {
                self.selectedBlock(cell.titleLabel, self.sourceArr[indexPath.row], indexPath.row, indexPath.row);
            }
        }else{
            if (self.deselectedBlock) {
                self.deselectedBlock(cell.titleLabel, self.sourceArr[indexPath.row], indexPath.row);
            }
        }
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.sourceArr.count==0){
        self.slipView.hidden = YES;
    }else{
        self.slipView.hidden = NO;
    }
    return self.sourceArr.count;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = CGFLOAT_MIN;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.allowsSelection = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LWSegmentViewCollectionViewCell class] forCellWithReuseIdentifier:kLWSegmentViewCollectionViewCell];
    }
    return _collectionView;
}

- (UIView *)slipView{
    if (!_slipView) {
        _slipView = [[UIView alloc] init];
        _slipView.backgroundColor = [UIColor blackColor];
    }
    return _slipView;
}

- (void)setSlipViewColor:(UIColor *)slipViewColor{
    _slipViewColor = slipViewColor;
    _slipView.backgroundColor = slipViewColor;
}

- (void)setCellWidth:(float)cellWidth{
    _cellWidth = cellWidth;
    [self.slipView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.cellWidth<=0) {
            make.width.mas_equalTo(100);
        }else{
            make.width.mas_equalTo(self.cellWidth);
        }
    }];
}

@end
