//
//  ChildVC.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ChildVC.h"

@interface ChildVC ()

@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Demo1用的监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFold) name:@"ChangeFold" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUnfold) name:@"ChangeUnfold" object:nil];
    
}

//在Demo1中,发送消息方法中使用该部分方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (self.leadingViewState == LeadingViewStateUnfold) {
        //在展开状态的时候
        if (point.y>scrollView.origin_sd.y+Navigation_Height/2) {
            //做成折叠
            [self makeFold];
            NSLog(@"往上滑");
        }else if (point.y<scrollView.origin_sd.y){
            NSLog(@"往下拉");
        }
    }else{
        //在折叠状态的时候
        if (point.y<scrollView.origin_sd.y-20) {
            [self makeUnfold];
            NSLog(@"往下拉2");
        }else if (point.y>scrollView.origin_sd.y){
            NSLog(@"往上滑2");
        }
    }
}

/** 做成折叠 */
- (void)makeFold{
    if (self.leadingViewState == LeadingViewStateUnfold) {
        self.leadingViewState = LeadingViewStateFold;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Fold" object:nil];
    }
}

/** 做成展开 */
- (void)makeUnfold{
    if (self.leadingViewState == LeadingViewStateFold) {
        self.leadingViewState = LeadingViewStateUnfold;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Unfold" object:nil];
    }
}

- (void)changeFold{
    if (self.leadingViewState == LeadingViewStateUnfold) {
        self.leadingViewState = LeadingViewStateFold;
    }
}

- (void)changeUnfold{
    if (self.leadingViewState == LeadingViewStateFold) {
        self.leadingViewState = LeadingViewStateUnfold;
    }
}
///////////////////// 以上 Demo1的各种方法 ///////////////////////////////




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
