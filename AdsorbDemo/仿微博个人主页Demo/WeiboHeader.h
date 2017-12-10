//
//  WeiboHeader.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboHeader : UIView
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
/** 头像底视图 */
@property (weak, nonatomic) IBOutlet UIView *headBackView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headView;
/** 姓名label */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 关注、粉丝数 */
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
/** 关于label */
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end
