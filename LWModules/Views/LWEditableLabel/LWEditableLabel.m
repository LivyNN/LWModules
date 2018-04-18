//
//  LWEditableLabel.m
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWEditableLabel.h"

#import <Masonry.h>
#import <ReactiveCocoa.h>

@interface LWEditableLabel()

@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong)UITextField *textField;



@end

@implementation LWEditableLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"Arial" size:20];
        [self addSubviews];
        [self addConstraints];
        [self bindSignal];
    }
    return self;
}

- (void)addSubviews{
    [self addSubview:self.label];
    [self addSubview:self.textField];
}

- (void)addConstraints{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(20);
    }];
}
- (void)bindSignal{
    __weak LWEditableLabel *weakSelf = self;
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        weakSelf.text = x;
    }];
    [self.textField addTarget:self action:@selector(textFieldEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textFieldEnd{
    [self completeEdit];
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.textField.font = font;
    self.label.font = font;
}

- (void)setText:(NSString *)text{
    _text = [text copy];
    self.label.text = text;
    self.textField.text = text;
    //textField重新计算宽度
    [self resizeTextField];
}

- (void)resizeTextField{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size ;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width+20);
    }];
    [self layoutIfNeeded];
}


- (void)edit{
    self.textField.hidden = NO;
    self.label.hidden = YES;
    [self.textField becomeFirstResponder];
}

- (void)completeEdit{
    self.textField.hidden = YES;
    self.label.hidden = NO;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = self.font;
        _textField.hidden = YES;
    }
    return _textField;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = self.font;
        _label.hidden = NO;
    }
    return _label;
}
@end
