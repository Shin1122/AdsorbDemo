
//
//  MeiTuanHeader.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "MeiTuanHeader.h"

@implementation MeiTuanHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:@[[UIImage imageNamed:@"banner_1"],[UIImage imageNamed:@"banner_2"],[UIImage imageNamed:@"banner_3"],[UIImage imageNamed:@"banner_4"],[UIImage imageNamed:@"banner_5"]]];
        [self addSubview:_banner];
        _banner.autoScrollTimeInterval = 4;
        _banner.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(84);
        
        
        
    }
    return self;
}

@end
