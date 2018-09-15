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
    UITableView *_tableView;
}
@property(nonatomic,strong)HomeController *home;

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
    WeakSelf
    CBNavController *nav=(CBNavController *)self.xl_sldeMenu.rootViewController;
    [nav.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HomeController class]]) {
            weakSelf.home=obj;
            *stop=YES;
        }
    } ];
    
    switch (indexPath.row) {

        case 0:
        {
            weakSelf.home.title=@"cnBetaLite";
            [weakSelf.home loadData];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];

            break;
        }
        case 1:
        {
            weakSelf.home.title=@"TOP10";
            [weakSelf.home loadTop10];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];

            break;
        }
        case 2:
        {
            weakSelf.home.title=@"最热评论";
            [weakSelf.home hotType:1];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];

            break;
        }
        case 3:
        {
            weakSelf.home.title=@"点赞最高";
            [weakSelf.home hotType:2];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];

            break;
        }
        case 4:
        {
            weakSelf.home.title=@"特别推荐";
            [weakSelf.home hotType:3];
            [self.xl_sldeMenu showRootViewControllerAnimated:true];

            break;
        }
            
        case 5:
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD  showSuccess:@"清理成功"];
            });
            [self.xl_sldeMenu showRightViewControllerAnimated:true];
            break;
        case 6: {
            
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
    return @[@"最新",@"本月top10",@"最热评论",@"点赞最高",@"特别推荐",@"清空缓存",@"给我打分",@"版本信息:1.0"];
}

- (NSArray *)images {
    return @[@"new",@"top10",@"hot",@"counter",@"dig",@"cache",@"score",@"version"];
}



@end
