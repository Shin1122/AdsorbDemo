//
//  WeiboHeader.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "WeiboHeader.h"

@implementation WeiboHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    //用sdautolayout布局加约束
    
    [self addSubview:_backgroundView];
    
    _backgroundView.frame = rect;
//    _backgroundView.sd_layout
//    .leftSpaceToView(self, 0)
//    .rightSpaceToView(self, 0)
//    .topSpaceToView(self, 0)
//    .bottomSpaceToView(self, 0);
    
    [self addSubview:_aboutLabel];
    _aboutLabel.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(self, 10)
    .autoHeightRatio(0);
    [_aboutLabel setSingleLineAutoResizeWithMaxWidth:self.width_sd];
    [self addSubview:_fansLabel];
    _fansLabel.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(_aboutLabel, 5)
    .autoHeightRatio(0);
    [_fansLabel setSingleLineAutoResizeWithMaxWidth:self.width_sd];
    [self addSubview:_nameLabel];
    _nameLabel.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(_fansLabel, 10)
    .autoHeightRatio(0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:self.width_sd];
    [self addSubview:_headBackView];
    _headBackView.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(_nameLabel, 10)
    .widthIs(82)
    .heightIs(82);
    [_headBackView addSubview:_headView]; _headBackView.sd_cornerRadiusFromWidthRatio = @0.5;
    _headView.sd_layout
    .centerXEqualToView(_headBackView)
    .centerYEqualToView(_headBackView)
    .widthIs(80)
    .heightIs(80);
    _headView.sd_cornerRadiusFromWidthRatio = @0.5;
}




@end
