//
//  HomeController.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "HomeController.h"
#import "HomeDataM.h"
#import "HomeCell.h"
#import "MapViewController.h"

#import "NewsController.h"
@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSMutableArray *news ;
@property(nonatomic,strong)UITableView *homeView;
@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
    [self loadData];
}


- (void)setupView
{
    UITableView *homeView=[[UITableView alloc]init];
    self.homeView=homeView;
    homeView.delegate=self;
    [homeView setDataSource:self];
    homeView.frame = self.view.bounds;
    homeView.separatorStyle=UITableViewCellSeparatorStyleNone;
    homeView.estimatedRowHeight=0;
    [self.view addSubview:homeView];
    
    self.title=@"cnBetaLite";
    
    self.homeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.homeView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataMore)];

    
    
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    
    UIButton *pmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [pmButton setImage:[UIImage imageNamed:@"pm2.5btn"] forState:UIControlStateNormal];
    [pmButton addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pmButton];
    
    
}

- (void)reSetUI
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.homeView.mj_header endRefreshing];
    [self.homeView.mj_footer endRefreshing];
    [self.homeView reloadData];
}

-(void)loadData
{
    WeakSelf
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDate *date=[NSDate date];
    NSString *dateStr=[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *sign =[[NSString stringWithFormat: @"app_key=10000&format=json&method=Article.Lists&timestamp=%@&v=1.0&mpuffgvbvbttn3Rc",dateStr] MD5];
    NSString *strUrl =[NSString stringWithFormat: @"http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Lists&timestamp=%@&v=1.0&sign=%@",dateStr,sign];
    [AFNTool getWithURl:strUrl parameters:nil success:^(id responseObject) {
        weakSelf.news=nil;
        self.news=[HomeDataM CBMJExtensionobjectArrayWithKeyValuesArray :responseObject[@"result"]];
        [weakSelf reSetUI];
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadDataMore
{
    HomeDataM *homeM=self.news.lastObject;
    WeakSelf
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDate *date=[NSDate date];
    NSString *dateStr=[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *sign =[[NSString stringWithFormat: @"app_key=10000&end_sid=%@&format=json&method=Article.Lists&timestamp=%@&topicid=null&v=1.0&mpuffgvbvbttn3Rc",homeM.sid,dateStr] MD5];
    NSString *strUrl =[NSString stringWithFormat:@"http://api.cnbeta.com/capi?app_key=10000&end_sid=%@&format=json&method=Article.Lists&timestamp=%@&topicid=null&v=1.0&mpuffgvbvbttn3Rc&sign=%@",homeM.sid,dateStr,sign];
    [AFNTool getWithURl:strUrl parameters:nil success:^(id responseObject) {
        NSArray *news=[HomeDataM CBMJExtensionobjectArrayWithKeyValuesArray:responseObject[@"result"]];
        NSMutableArray *tempArray= [NSMutableArray array];
        [tempArray addObjectsFromArray:weakSelf.news];
        [tempArray addObjectsFromArray:news];
        weakSelf.news=tempArray;
        [weakSelf reSetUI];
    } failure:^(NSError *error) {
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell =[HomeCell cellWithTable:tableView];
    cell.homeM=self.news[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsController *content=[[NewsController alloc]init];
    content.homeM=self.news[indexPath.row];
    [self.navigationController pushViewController:content animated:YES];
}

-(NSMutableArray *)news
{

    if (!_news) {
        _news=[NSMutableArray array];
    }
    return _news;
}

- (void)map
{
    MapViewController *map=[MapViewController new];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:map];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)showRight{
    [self.xl_sldeMenu showRightViewControllerAnimated:true];
}


-(void)loadTop10
{
    
    WeakSelf
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDate *date=[NSDate date];
    NSString *dateStr=[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *sign =[[NSString stringWithFormat: @"app_key=10000&format=json&method=Article.Top10&timestamp=%@&v=1.0&mpuffgvbvbttn3Rc",dateStr] MD5];
    NSString *strUrl =[NSString stringWithFormat: @"http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Top10&timestamp=%@&v=1.0&sign=%@",dateStr,sign];
    [AFNTool getWithURl:strUrl parameters:nil success:^(id responseObject) {
        weakSelf.news=nil;
        self.news=[HomeDataM CBMJExtensionobjectArrayWithKeyValuesArray :responseObject[@"result"]];
        [weakSelf reSetUI];
    } failure:^(NSError *error) {
        
    }];
}


@end
