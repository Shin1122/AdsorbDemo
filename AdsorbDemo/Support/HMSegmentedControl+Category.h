//
//  HMSegmentedControl+Category.h
//  Qatime_Teacher
//
//  Created by Shin on 2017/7/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "HMSegmentedControl.h"

@interface HMSegmentedControl (Category)

@property (nonatomic, strong) UIScrollView *meanScrollView ;

+ (instancetype)segmentControlWithTitles:(NSArray *)titles;

@end
