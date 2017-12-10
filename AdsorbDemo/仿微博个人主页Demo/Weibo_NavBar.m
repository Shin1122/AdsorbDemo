//
//  Weibo_NavBar.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/10.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "Weibo_NavBar.h"

@implementation Weibo_NavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _content = [[UIView alloc]init];
        [self addSubview:_content];
        _content.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        _content.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
        _content.alpha = 0;
        UIView *line = [[UIView alloc]init];
        [_content addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
        line.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .heightIs(0.5);
        
        _back = [[UIButton alloc]initWithFrame:CGRectMake(10, 20,80, 44)];
        [_back setTitle:@"返回" forState:UIControlStateNormal];
        _back.titleLabel.font = [UIFont systemFontOfSize:16];
        [_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_back setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
        _back.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        _back.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:_back];
        
        
        
    }
    return self;
}

@end
