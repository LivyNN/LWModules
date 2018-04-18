//
//  DemoLoginInputView.m
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DemoLoginInputView.h"
#import "masonry.h"

@interface DemoLoginInputView()

@property(nonatomic, strong, readwrite)UITextField *textField;

@end

@implementation DemoLoginInputView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubViews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.textField];
}

- (void)addConstraints{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}
@end
