//
//  ViewController.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/8.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ViewController.h"
#import "Demo1VC.h"
#import "Demo2VC.h"
#import "WeiboDemo.h"
#import "MeiTuanDemo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *_menu ;
    
    NSArray *_titles;
    
    UITableView *_mainView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    _menu = @[@{@"title":@"Segment联动吸附效果1",@"subtitle":@"子控制器发送通知方法(见代码)"},
              @{@"title":@"Segment联动吸附效果2",@"subtitle":@"控制器监听方法(见代码)"},
              @{@"title":@"仿微博个人主页",@"subtitle":@"切换segment后的head变化滑动"},
              @{@"title":@"仿美团外卖样式",@"subtitle":@"NavigationBar的变化"},];
    
    _titles = @[@"header隐藏,segment吸附效果",@"仿微博个人主页",@"仿美团外卖NavBar变化效果"];
    
    _mainView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }
    else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /* cell的重用队列*/
    static NSString *cellIdenfier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _menu[indexPath.row][@"title"];
        cell.detailTextLabel.text = _menu[indexPath.row][@"subtitle"];
    }else if (indexPath.section == 1){
        cell.textLabel.text = _menu[indexPath.row +2][@"title"];
        cell.detailTextLabel.text = _menu[indexPath.row +2][@"subtitle"];
    }else if (indexPath.section ==2){
        cell.textLabel.text = _menu[indexPath.row +3][@"title"];
        cell.detailTextLabel.text = _menu[indexPath.row +3][@"subtitle"];
    }
    
    return  cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return _titles[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __block UIViewController *controller = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            controller = [[Demo1VC alloc]init];
        }else if (indexPath.row == 1){
            controller = [[Demo2VC alloc]init];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            controller = [[WeiboDemo alloc]init];
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            controller = [[MeiTuanDemo alloc]init];
        }
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
