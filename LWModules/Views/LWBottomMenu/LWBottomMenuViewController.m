//
//  LWBottomMenuViewController.m
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWBottomMenuViewController.h"

#import <ReactiveCocoa.h>

#import "LWFlowLayoutView.h"
#import <Masonry.h>
@interface LWBottomMenuViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong, readwrite)LWFlowLayoutView *contentView;

//单击退出
@property(nonatomic, strong, readwrite)UITapGestureRecognizer *singleTapRecognizer;

//上划退出
@property(nonatomic, strong, readwrite)UISwipeGestureRecognizer *swipeRecognizer;

@property(nonatomic, strong, readwrite)RACSubject *returnGestureSubject;
@property(nonatomic, strong, readwrite)RACSubject *returnAnimationCompleteSubject;

@property(nonatomic, assign)float height;

@end

@implementation LWBottomMenuViewController


- (instancetype)initWithHeight:(float)height{
    self = [super init];
    if (self) {
        self.height = height;
        [self addSubViews];
        [self addGestures];
        [self addConstraints];
    }
    return self;
}

- (void)addSubViews{
    [self.view addSubview:self.contentView];
}

- (void)addConstraints{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(self.height);
    }];
    [self.view layoutIfNeeded];
}

- (void)addGestures{
    [self.view addGestureRecognizer:self.singleTapRecognizer];
    [self.view addGestureRecognizer:self.swipeRecognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self adjustInitialPosition];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self appearAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self disappearAnimation];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == self.singleTapRecognizer) {
        if (self.isSingleTapReturnOpen) {
            if (touch.view == self.view) {
                return YES;
            }else{
                //在用户添加的子视图中不触发
                return NO;
            }
        }else{
            return NO;
        }
    }else if(gestureRecognizer == self.swipeRecognizer){
        if (self.isDownSwipeReturnOpen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (void)adjustInitialPosition{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(self.height);
        }];
        [self.view layoutIfNeeded];
}

- (void)appearAnimation{
        __weak LWBottomMenuViewController *weakSelf = self;
        //系统优化过，还是要养成好习惯

        [UIView animateWithDuration:0.3 animations:^{
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view);
            }];
            [weakSelf.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
}

- (void)disappearAnimation{
        __weak LWBottomMenuViewController *weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.view).offset(weakSelf.height);
            }];
            [weakSelf.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [weakSelf.returnAnimationCompleteSubject sendNext:nil];
        }];
}

- (void)returnGestureRecognized{
    [self.returnGestureSubject sendNext:nil];
}

- (LWFlowLayoutView *)contentView{
    if (!_contentView) {
        _contentView = [[LWFlowLayoutView alloc] init];
        _contentView.backgroundColor = [UIColor blackColor];
    }
    return _contentView;
}

- (UITapGestureRecognizer *)singleTapRecognizer{
    if (!_singleTapRecognizer) {
        _singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnGestureRecognized)];
        _singleTapRecognizer.delegate = self;
        
    }
    return _singleTapRecognizer;
}
- (UISwipeGestureRecognizer *)swipeRecognizer{
    if (!_swipeRecognizer) {
        _swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnGestureRecognized)];
        [_swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
        _swipeRecognizer.delegate = self;
    }
    return _swipeRecognizer;
}

- (RACSubject *)returnGestureSubject{
    if (!_returnGestureSubject) {
        _returnGestureSubject = [RACSubject subject];
    }
    return _returnGestureSubject;
}

- (RACSubject *)returnAnimationCompleteSubject{
    if (!_returnAnimationCompleteSubject) {
        _returnAnimationCompleteSubject = [RACSubject subject];
    }
    return _returnAnimationCompleteSubject;
}
@end

