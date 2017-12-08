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


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *_menu ;
    
    UITableView *_mainView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    _menu = @[@{@"title":@"Segment联动吸附效果1",@"subtitle":@"子控制器发送通知方法(见代码)"},
              @{@"title":@"Segment联动吸附效果2",@"subtitle":@"控制器监听方法(见代码)"},];
    _mainView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return _menu.count;
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
    }
    
    return  cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    __block NSString *title;
    
    switch (section) {
        case 0:
            title = @"header隐藏,segment吸附效果";
            break;
            
        case 1:
            break;
    }
    
    return title;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __block UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:
            controller = [[Demo1VC alloc]init];
            break;
        case 1:
            controller = [[Demo2VC alloc]init];
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
