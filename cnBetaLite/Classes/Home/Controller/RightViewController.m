//
//  RightViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "RightViewController.h"
#import "XLSlideMenu.h"
#import "MBProgressHUD+MJ.h"
#import "HomeController.h"
#import "CBNavController.h"
@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"cnBetaLite中文业界资讯站";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self titles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIView *line=[UIView new];
    line.backgroundColor=CBAColor(0, 0, 0, 0.2);
    line.frame=CGRectMake(10, cell.height+13, cell.width-20, 0.4);
    [cell addSubview:line];
    cell.textLabel.text = [self titles][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self images][indexPath.row] ];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            CBNavController *nav=(CBNavController *)self.xl_sldeMenu.rootViewController;
            [nav.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HomeController class]]) {
                    HomeController *home=obj;
                    home.title=@"TOP10";
                    [home loadTop10];
                    *stop=YES;;
                }
            } ];
            
            [self.xl_sldeMenu showRootViewControllerAnimated:true];
            break;
        }
        case 1:
        {
            CBNavController *nav=(CBNavController *)self.xl_sldeMenu.rootViewController;
            [nav.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HomeController class]]) {
                    HomeController *home=obj;
                    home.title=@"cnBetaLite";
                    [home loadData];
                    *stop=YES;;
                }
            } ];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];
            break;
        }
        case 2:
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD  showSuccess:@"清理成功"];
            });
            [self.xl_sldeMenu showRightViewControllerAnimated:true];
            break;
        case 3: {
            
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1088526122"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];
            break;
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (NSArray *)titles {
    return @[@"top10",@"最新",@"清空缓存",@"给我打分",@"版本信息:1.0"];
}

- (NSArray *)images {
    return @[@"top10",@"new",@"cache",@"score",@"version"];
}



@end
