//
//  LWSegmentViewCollectionViewCell.m
//  LWModules
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWSegmentViewCollectionViewCell.h"
#import <Masonry.h>
NSString *const kLWSegmentViewCollectionViewCell = @"kLWSegmentViewCollectionViewCell";

@interface LWSegmentViewCollectionViewCell()

@property(nonatomic, strong, readwrite)UILabel *titleLabel;

@end

@implementation LWSegmentViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    [self.contentView addSubview:self.titleLabel];
}

- (void)addConstraints{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.contentView);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addConstraints];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
