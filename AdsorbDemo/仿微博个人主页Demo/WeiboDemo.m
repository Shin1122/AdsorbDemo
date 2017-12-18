//
//  WeiboDemo.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "WeiboDemo.h"
#import "ChildVC2.h"
#import "ChildVC3.h"
#import "ChildVC5.h"
#import "UITableView+Guesture.h"
#import "SegmentCell.h"

#import "HFStretchableTableHeaderView.h"


/**
 
 实现思路:
 注:
 * segment使用HMSegmentControl(https://github.com/HeshamMegid/HMSegmentedControl)
 * header的下拉吸附使用HFStretchableTableHeaderView(https://github.com/hfrahmann/HFStretchableTableHeaderView)
 
 图像布局:
 1.整个页面的最底层contentView是一个UITableView.
 2.tableView的header就是显示用户基本信息的地方.
 3.有一个sectionHeader,sectionHeader用来方式segment(滑动分段控制器)
 4.整个大的tableview只有一行cell,这个cell上只有一个scrollView控件,用来放置多个列表展示页
 5.在唯一的cell里,每个子视图对应的控制器,要添加为当前viewController的子控制器.
 
 滑动逻辑:
 1.在当前控制器和唯一的cell里要有bool判断是否可以滑动
 2.在子控制器进行滑动的时候进行监听,随之整个大的tableview进行滑动.
 3.当滑动到sectionheader的位置的时候,大的tableView停止滑动,只有cell上的scrollview和每个子视图可以滑动
 4.下拉的时候根据滑动位置判断大的tableview是否需要进行滑动.
 
 最后加一个带吸附效果的header. 和一个背景alpha自动变化的navigation.
 
 */


@interface WeiboDemo ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    ChildVC5 *_vc1;
    ChildVC5 *_vc2;
    ChildVC5 *_vc3;
    
    SegmentCell *_segmentCell;
    
}

//是否应该刷新
@property(nonatomic,assign)BOOL shouldRefresh;
//偏移量
@property(nonatomic,assign)NSInteger lastContentOffY;
//是否在刷新
@property(nonatomic,assign)BOOL isRefreshing;

/** 可以滑动 */
@property (nonatomic, assign) BOOL canScroll ;
//下拉头部放大控件
@property (strong, nonatomic) HFStretchableTableHeaderView* stretchableTableHeaderView;
@end

@implementation WeiboDemo

/**
 
 使用sd_autolayout布局做约束性吸附。
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"微博";
    
    //加载个视图
    [self setupMainView];
    
    //segment
    [self setupSegment];

    //加载别的
    [self setupConfig];
    
    //加载navBar
    [self setupNavBar];
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOtherScrollToTop:) name:@"LeftTop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScrollBottomView:) name:@"PageViewGestureState" object:nil];
    
}

- (void)setupMainView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width_sd, self.view.height_sd) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

}

- (void)setupHead{
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"WeiboHeader" owner:nil options:nil].lastObject ;
    _headerView.frame = CGRectMake(0, -20, self.view.width_sd, 250);
}
///通知的处理

//子控制器到顶部了 主控制器可以滑动
- (void)onOtherScrollToTop:(NSNotification *)ntf {
    self.canScroll = YES;
    _segmentCell.canScroll = NO;
}

//当滑动下面的ScrollView时，当前要禁止滑动
- (void)onScrollBottomView:(NSNotification *)ntf {
    if ([ntf.object isEqualToString:@"ended"]) {
        //bottomView停止滑动了 当前页可以滑动
        self.tableView.scrollEnabled = YES;
    } else {
        //bottomView滑动了 当前页就禁止滑动
        self.tableView.scrollEnabled = NO;
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要减去导航栏 状态栏 以及 sectionheader的高度
    return self.view.frame.size.height-40-64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //sectionheader的高度，这是要放分段控件的
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _segment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* cell的重用队列*/
    static NSString *cellIdenfier = @"cell";
    SegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    if (cell==nil) {
        cell=[[SegmentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    _segmentCell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_segment) {
        _segment.meanScrollView = cell.scrollView;
    }
    cell.scrollView.delegate = self;
    [self setupChildVC];
    return  cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _segmentCell.scrollView) {
        return;
    }
    //下拉放大 必须实现
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
    //计算导航栏的透明度
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = self.view.width_sd  / 1.7 - 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    NSLog(@"alpha--%f",alpha);

    _navBar.content.alpha = alpha;
    if (alpha>0.9) {
        [_navBar.back setImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
        [_navBar.back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        
    }else{
        [_navBar.back setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
        [_navBar.back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    //子控制器和主控制器之间的滑动状态切换
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y-64;
    if (scrollView.contentOffset.y >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        if (_canScroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kScrollToTopNtf" object:@1];
            _canScroll = NO;
            _segmentCell.canScroll = YES;
            _vc1.canScroll = YES;
            _vc2.canScroll = YES;
            _vc3.canScroll = YES;
        }else{
            
        }
    } else {
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
    
    [self configRefreshStateWithScrollView:scrollView];
}

-(void)configRefreshStateWithScrollView:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= -64 && scrollView.contentOffset.y < self.lastContentOffY) {
        self.shouldRefresh = YES;
    }else{
        self.shouldRefresh = NO;
    }
    
    if (scrollView.contentOffset.y < 0 && !self.isRefreshing && scrollView.contentOffset.y < self.lastContentOffY && self.lastContentOffY < 0) {
        if(!self.isRefreshing){
            //navbar开始刷新
        }else{
            //navbar结束刷新

        }
    }
    
    self.lastContentOffY = scrollView.contentOffset.y;
}




-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.shouldRefresh && !self.isRefreshing) {
        self.isRefreshing  = YES;
    }else if(!self.isRefreshing){
        self.isRefreshing = NO;
    }
}



//下拉放大
- (void)viewDidLayoutSubviews {
    [_stretchableTableHeaderView resizeView];
}


- (void)setupSegment{
    
    _segment = [HMSegmentedControl segmentControlWithTitles:@[@"主页",@"微博",@"相册"]];
    _segment.borderType = HMSegmentedControlBorderTypeNone;
    _segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segment.frame = CGRectMake(0, 0, self.view.width_sd, 40);

}

- (void)setupChildVC{
    _vc1 = [[ChildVC5 alloc]init];
    [self addChildViewController:_vc1];
    [_segmentCell.scrollView addSubview:_vc1.view];
    _vc1.view.sd_layout
    .leftSpaceToView(_segmentCell.scrollView, 0)
    .topSpaceToView(_segmentCell.scrollView, 0)
    .widthRatioToView(_segmentCell.scrollView, 1.0)
    .bottomSpaceToView(_segmentCell.scrollView, 0);
    [_vc1.view updateLayout];
    
    _vc2 = [[ChildVC5 alloc]init];
    [self addChildViewController:_vc2];
    [_segmentCell.scrollView addSubview:_vc2.view];
    _vc2.view.sd_layout
    .leftSpaceToView(_vc1.view, 0)
    .topEqualToView(_vc1.view)
    .bottomEqualToView(_vc1.view)
    .widthRatioToView(_vc1.view, 1.0);
    [_vc2.view updateLayout];
    
    _vc3 = [[ChildVC5 alloc]init];
    [self addChildViewController:_vc3];
    [_segmentCell.scrollView addSubview:_vc3.view];
    _vc3.view.sd_layout
    .leftSpaceToView(_vc2.view, 0)
    .topEqualToView(_vc2.view)
    .bottomEqualToView(_vc2.view)
    .widthRatioToView(_vc2.view, 1.0);
    [_vc3.view updateLayout];
    
    //sd_autolayout中的scrollview.contentsize的自动匹配方法
    [_segmentCell.scrollView setupAutoContentSizeWithRightView:_vc3.view rightMargin:0];
    [_segmentCell.scrollView setupAutoContentSizeWithBottomView:_vc1.view bottomMargin:0];
    
}


- (void)setupConfig{
    _canScroll = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    [self setupHead];
    _stretchableTableHeaderView = [HFStretchableTableHeaderView new];
    [_stretchableTableHeaderView stretchHeaderForTableView:_tableView withView:_headerView];
}



- (void)setupNavBar{
    _navBar = [[Weibo_NavBar alloc]init];
    [self.view addSubview:_navBar];
    _navBar.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(Navigation_Height);
    [_navBar.back addTarget:self action:@selector(returnLastPage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _segmentCell.scrollView) {
        NSInteger index = _segmentCell.scrollView.contentOffset.x/scrollView.width_sd;
        [_segment setSelectedSegmentIndex:index animated:YES];

    }
    
}


- (void)returnMain{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}

- (void)returnLastPage{
    [self.navigationController popViewControllerAnimated:YES];
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
