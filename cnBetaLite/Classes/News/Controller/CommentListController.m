//
//  CommentListController.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/8.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "CommentListController.h"
#import "CommentViewCell.h"
#import "CommentM.h"

@interface CommentListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *commentView;
@property(nonatomic,copy)NSMutableArray *dataArry;
@property(nonatomic,strong)UILabel *noDataL;

@end

@implementation CommentListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
    [self loadData];
}

-(void)setupView
{
    UITableView *commentView=[[UITableView alloc]init];
    self.commentView=commentView;
    commentView.delegate=self;
    [commentView setDataSource:self];
    commentView.frame = self.view.bounds;
    commentView.separatorStyle=UITableViewCellSeparatorStyleNone;
    commentView.estimatedRowHeight=0;
    commentView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:commentView];
    
    self.title=@"评论";
}
- (void)loadData
{
    WeakSelf;
    NSDate *date=[NSDate date];
    NSString *dateStr=[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *sign =[[NSString stringWithFormat:@"app_key=10000&format=json&method=Article.Comment&op=publish&sid=%@&timestamp=%@&v=1.0&mpuffgvbvbttn3Rc",self.sid,dateStr] MD5];
    NSString *strUrl =[NSString stringWithFormat: @"http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Comment&op=publish&sid=%@&timestamp=%@&v=1.0&sign=%@",self.sid,dateStr,sign];
    
    [AFNTool getWithURl:strUrl parameters:nil success:^(id responseObject) {
        DLog(@"%@",responseObject);
        weakSelf.dataArry=[CommentM CBMJExtensionobjectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (self.dataArry.count==0) {
            [self noDataL];
        }
        [MBProgressHUD hideHUDForView:weakSelf.view animated:NO];
        [weakSelf.commentView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:NO];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewCell *cell =[CommentViewCell cellWithTable:tableView];
    cell.commM=self.dataArry[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentM *model = self.dataArry[indexPath.row];
    CGSize maxSize = CGSizeMake(ScreenW, MAXFLOAT);
    CGFloat textH = [model.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    textH=textH+70;
    return textH;
}

-(NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry=[NSMutableArray array];
    }
    return _dataArry;
}

- (UILabel*)noDataL
{
    if (!_noDataL) {
        _noDataL=[UILabel new];
        _noDataL.textColor=[UIColor grayColor];
        _noDataL.font=[UIFont systemFontOfSize:25];
        _noDataL.text=@"无数据";
        _noDataL.frame=CGRectMake(0, 0, ScreenW, ScreenH);
        _noDataL.textAlignment=1;
        _noDataL.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_noDataL];
    }
    return _noDataL;

}

@end
