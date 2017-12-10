//
//  WeiboDemo.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboHeader.h"
#import "Weibo_NavBar.h"
#import "HMSegmentedControl+Category.h"
@interface WeiboDemo : UIViewController

@property (nonatomic, strong) Weibo_NavBar *navBar ;

@property (nonatomic, strong) UITableView *tableView ;

/** 用weiboheader作为控制器的head */
@property (nonatomic, strong) WeiboHeader *headerView ;

@property (nonatomic, strong) HMSegmentedControl *segment ;


@end
