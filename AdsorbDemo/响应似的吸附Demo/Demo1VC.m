//
//  Demo1VC.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/8.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "Demo1VC.h"

#import "ChildVC2.h"
#import "ChildVC4.h"

/**
 Demo1是使用子控制器中,每个滑动视图(如果可滑动)在滑动时候的offset进行判断.从而根据当前headview的状态来改变headView显示方式.
 使用SD_AutoLayout来实现动画.
 */


@interface Demo1VC ()<UIScrollViewDelegate>{
    
    UIImageView *_header;
    
    //子控制器
    ChildVC1 *_vc1;
    ChildVC2 *_vc2;
    ChildVC3 *_vc3;
    
    LeadingViewState _leadingViewState;
}

@end

@implementation Demo1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo1";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载header
    [self setupHeader];
    
    //加载视图
    [self setupViews];
    
    //加载子控制器
    [self setupChildVC];
    
    //headerView的状态 fold/unfold
    _leadingViewState = LeadingViewStateUnfold;
    
    //接受子控制器的"滑动"消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(foldHeader) name:@"Fold" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unfoldHeader) name:@"Unfold" object:nil];
    
}

- (void)setupHeader{
    
    _header  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header"]];
    [self.view addSubview:_header];
    _header.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, Navigation_Height)
    .rightSpaceToView(self.view, 0)
    .heightIs(150);
    [_header updateLayout];
    
    _header.backgroundColor = [UIColor redColor];
}

- (void)setupViews{
  
    self.segment.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(_header, 0)
    .rightSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(40);
    
    self.scrollView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.segment, 0)
    .bottomSpaceToView(self.view, 0);
    
}

- (void)setupChildVC{
    _vc1 = [[ChildVC1 alloc]init];
    [self addChildViewController:_vc1];
    [self.scrollView addSubview:_vc1.view];
    _vc1.view.sd_layout
    .leftSpaceToView(self.scrollView, 0)
    .topSpaceToView(self.scrollView, 0)
    .widthRatioToView(self.scrollView, 1.0)
    .bottomSpaceToView(self.scrollView, 0);
    
    _vc2 = [[ChildVC2 alloc]init];
    [self addChildViewController:_vc2];
    [self.scrollView addSubview:_vc2.view];
    _vc2.view.sd_layout
    .leftSpaceToView(_vc1.view, 0)
    .topEqualToView(_vc1.view)
    .bottomEqualToView(_vc1.view)
    .widthRatioToView(_vc1.view, 1.0);
    
    _vc3 = [[ChildVC3 alloc]init];
    [self addChildViewController:_vc3];
    [self.scrollView addSubview:_vc3.view];
    _vc3.view.sd_layout
    .leftSpaceToView(_vc2.view, 0)
    .topEqualToView(_vc2.view)
    .bottomEqualToView(_vc2.view)
    .widthRatioToView(_vc2.view, 1.0);
    
    //sd_autolayout中的scrollview.contentsize的自动匹配方法
    [self.scrollView setupAutoContentSizeWithRightView:_vc3.view rightMargin:0];
    [self.scrollView setupAutoContentSizeWithBottomView:_vc1.view bottomMargin:0];
    
}


/**
    head的折叠和展开方法.
    其实只是运用动画,根据子控制器的滑动,改变headView的布局.
 */

- (void)foldHeader{
    if (_leadingViewState == LeadingViewStateUnfold) {
        //折叠
        _leadingViewState = LeadingViewStateFold;
        [UIView animateWithDuration:0.3 animations:^{
            _header.sd_layout
            .topSpaceToView(self.view, Navigation_Height - _header.height_sd);
            [_header updateLayout];
        }];
    }
}

- (void)unfoldHeader{
    if (_leadingViewState == LeadingViewStateFold) {
        //折叠
        _leadingViewState = LeadingViewStateUnfold;
        [UIView animateWithDuration:0.3 animations:^{
            _header.sd_layout
            .topSpaceToView(self.view, Navigation_Height);
            [_header updateLayout];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
