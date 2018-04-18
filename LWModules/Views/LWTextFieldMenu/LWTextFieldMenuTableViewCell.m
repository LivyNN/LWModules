//
//  LWTextFieldMenuTableViewCell.m
//  LWModules
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWTextFieldMenuTableViewCell.h"
#import <Masonry.h>

NSString *const kLWTextFieldMenuTableViewCell = @"kLWTextFieldMenuTableViewCell";

@interface LWTextFieldMenuTableViewCell()

@property(nonatomic, strong, readwrite)UIView *itemLabelContentView;

@property(nonatomic, strong, readwrite)UILabel *itemLabel;

@property(nonatomic, strong, readwrite)UIView *deleteButtonContentView;

@property(nonatomic, strong, readwrite)UIButton *deleteButton;

@end

@implementation LWTextFieldMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    [self.contentView addSubview:self.itemLabelContentView];
    [self.itemLabelContentView addSubview:self.itemLabel];
    [self.contentView addSubview:self.deleteButtonContentView];
    [self.deleteButtonContentView addSubview:self.deleteButton];
}

- (void)addConstraints{
    [self.itemLabelContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.deleteButtonContentView.mas_left);
        make.top.and.bottom.equalTo(self.contentView);
    }];
    
    [self.deleteButtonContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemLabelContentView.mas_right);
        make.top.and.bottom.and.right.equalTo(self.contentView);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.itemLabelContentView);
        make.height.equalTo(self.itemLabelContentView).multipliedBy(0.8);
        make.width.equalTo(self.itemLabelContentView).multipliedBy(0.8);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.deleteButtonContentView);
        make.width.equalTo(self.deleteButtonContentView).multipliedBy(0.8);
        make.height.equalTo(self.deleteButtonContentView).multipliedBy(0.8);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addConstraints];
}

- (UIView *)itemLabelContentView{
    if (!_itemLabelContentView) {
        _itemLabelContentView = [[UIView alloc] init];
    }
    return _itemLabelContentView;
}

- (UILabel *)itemLabel{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
    }
    return _itemLabel;
}

- (UIView *)deleteButtonContentView{
    if (!_deleteButtonContentView) {
        _deleteButtonContentView = [[UIView alloc] init];
    }
    return _deleteButtonContentView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _deleteButton;
}

@end
