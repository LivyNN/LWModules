//
//  ViewController.m
//  LWModules
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DemoLoginViewController.h"

#import "LWTextFieldMenu.h"

#import "LWPullDownMenuContainer.h"

#import "NICK_ThirdPartProtocol.h"
#import "LWSegmentView.h"

#import "LWEditableLabel.h"

#import <Masonry.h>

#import "LWBottomMenuContainer.h"

#import "LWFlowLayoutView.h"


@interface ViewController ()

@property(nonatomic, strong, readwrite)LWPullDownMenuContainer *pullDownMenu;

@property(nonatomic, strong, readwrite)UIViewController *pullDownMenuViewController;

@property(nonatomic, strong, readwrite)UIView *cView;

@property(nonatomic, strong, readwrite)LWSegmentView *segmentView;

@property(nonatomic, strong)LWEditableLabel *textEditLabel;

@property(nonatomic, strong)LWBottomMenuContainer *bottomMenu;

@end

@implementation ViewController

- (LWEditableLabel *)textEditLabel{
    if (!_textEditLabel) {
        _textEditLabel = [[LWEditableLabel alloc] init];
    }
    return _textEditLabel;
}

- (LWBottomMenuContainer *)bottomMenu{
    if (!_bottomMenu) {
        _bottomMenu = [[LWBottomMenuContainer alloc] initWithHeight:120];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor yellowColor];
        //[_bottomMenu.layoutView lw_InsertSubView:view height:60];
    }
    return _bottomMenu;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    button.frame = CGRectMake(100,200,100,100);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonClicked{
    [self.bottomMenu show];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        //[self.textEditLabel edit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
