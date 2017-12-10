//
//  SegmentCell.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/10.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _scrollView = [[UIScrollView alloc]init];
        [self.contentView addSubview:_scrollView];
        _scrollView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(100, 100);
        
        [_scrollView addObserver:self
                              forKeyPath:@"panGestureRecognizer.state"
                                 options:NSKeyValueObservingOptionNew
                                 context:nil];
        
        [self setupAutoHeightWithBottomView:_scrollView bottomMargin:0];
        
    }
    return self;
}
//监听拖拽手势的回调
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (((UIScrollView *)object).panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"bottomSView 滑动了");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PageViewGestureState" object:@"changed"];
    } else if (((UIScrollView *)object).panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束拖拽");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PageViewGestureState" object:@"ended"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
