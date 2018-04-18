//
//  LWPullDownBaseViewController.m
//  LWModules
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWPullDownBaseViewController.h"
#import <ReactiveCocoa.h>
@interface LWPullDownBaseViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong, readwrite)UIView *contentView;

//单击退出
@property(nonatomic, strong, readwrite)UITapGestureRecognizer *singleTapRecognizer;

//上划退出
@property(nonatomic, strong, readwrite)UISwipeGestureRecognizer *swipeRecognizer;

@property(nonatomic, strong, readwrite)RACSubject *returnGestureSubject;
@property(nonatomic, strong, readwrite)RACSubject *returnAnimationCompleteSubject;

@end

@implementation LWPullDownBaseViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubViews];
        [self addGestures];
    }
    return self;
}

- (void)addSubViews{
    [self.view addSubview:self.contentView];
    self.contentView.frame = self.view.frame;
}

- (void)addGestures{
    [self.contentView addGestureRecognizer:self.singleTapRecognizer];
    [self.contentView addGestureRecognizer:self.swipeRecognizer];
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
            if (touch.view == self.contentView) {
                return YES;
            }else{
                //在用户添加的子视图中不触发
                return NO;
            }
        }else{
            return NO;
        }
    }else if(gestureRecognizer == self.swipeRecognizer){
        if (self.isUpSwipeReturnOpen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


- (void)adjustInitialPosition{
    NSLog(@"%f",self.contentView.center.y);
    if (self.contentView.center.y>0) {
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y -= self.contentView.frame.size.height;
        self.contentView.center = viewCenter;
    }
}

- (void)appearAnimation{
    if (self.contentView.center.y<0) {
        __weak LWPullDownBaseViewController *weakSelf = self;
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y += self.contentView.frame.size.height;
        //系统优化过，还是要养成好习惯
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.contentView.center = viewCenter;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)disappearAnimation{
    if (self.contentView.center.y>0) {
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y -= self.contentView.frame.size.height;
        //系统优化过，还是要养成好习惯
        __weak LWPullDownBaseViewController *weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.contentView.center = viewCenter;
        } completion:^(BOOL finished) {
            [weakSelf.returnAnimationCompleteSubject sendNext:nil];
        }];
    }
}

- (void)returnGestureRecognized{
    [self.returnGestureSubject sendNext:nil];
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
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
        [_swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
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
