//
//  DemoVC.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "DemoVC.h"

@interface DemoVC ()<UIScrollViewDelegate>

@end

@implementation DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segment = [HMSegmentedControl segmentControlWithTitles:@[@"VC1",@"VC2",@"VC3"]];
    [self.view addSubview:self.segment];
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.width_sd*3, self.view.height_sd-self.segment.bottom_sd);
    self.scrollView.delegate = self;
    self.segment.meanScrollView = self.scrollView;
}

//segment的滑动方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        NSInteger index = scrollView.contentOffset.x/scrollView.width_sd ;
        [self.segment setSelectedSegmentIndex:index animated:YES];
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
