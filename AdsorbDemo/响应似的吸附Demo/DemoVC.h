//
//  DemoVC.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//


/**
 Base_DemoVC
 */
#import <UIKit/UIKit.h>
#import "HMSegmentedControl+Category.h"

@interface DemoVC : UIViewController

@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
