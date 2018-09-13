//
//  NewsController.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "NewsController.h"
#import "HomeDataM.h"
#import "CommentListController.h"

@interface NewsController ()<UIWebViewDelegate>
@property (nonatomic , strong ) UIWebView *webView;
@property (nonatomic , strong ) UIButton *commentBtn;

//@property (strong, nonatomic)UIView *statusBarBiew;
//@property (strong, nonatomic)UILabel *titleL;

@end

@implementation NewsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.height+=50;
    webView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    for (UIView *bg in webView.subviews) {
        bg.backgroundColor=[UIColor whiteColor];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 85, 0);
    });
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView=webView;
    [self loadData];

}


-(void)loadData
{
//    self.homeM.sid=@"765443";
    WeakSelf
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDate *date=[NSDate date];
    NSString *dateStr=[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *sign =[[NSString stringWithFormat:@"app_key=10000&format=json&method=Article.NewsContent&sid=%@&timestamp=%@&v=1.0&mpuffgvbvbttn3Rc",self.homeM.sid,dateStr] MD5];
    NSString *strUrl =[NSString stringWithFormat: @"http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.NewsContent&sid=%@&timestamp=%@&v=1.0&sign=%@",self.homeM.sid,dateStr,sign];
    
    [AFNTool getWithURl:strUrl parameters:nil success:^(id responseObject) {
        DLog(@"%@",responseObject);
        NSString *html=[NSString stringWithFormat:@"%@%@",responseObject[@"result"][@"hometext"],responseObject[@"result"][@"bodytext"]];
        [weakSelf.webView loadHTMLString:html baseURL:nil];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:NO];

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:NO];
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='PingFangSC-Light';";
    [webView stringByEvaluatingJavaScriptFromString:fontFamilyStr];
    NSString *fontSizeStr = @"document.getElementsByTagName('section')[0].style.fontSize='15px';";
    [webView stringByEvaluatingJavaScriptFromString:fontSizeStr];

    [webView stringByEvaluatingJavaScriptFromString:[self methodStr:@"img"]];
    [webView stringByEvaluatingJavaScriptFromString:[self methodStr:@"embed"]];
    [webView stringByEvaluatingJavaScriptFromString:[self methodStr:@"iframe"]];
    [self commentBtn];

}
- (NSString *)methodStr:(NSString *)str
{
    return [NSString stringWithFormat:@"function %@AutoFit() { \
            var imgs = document.getElementsByTagName('%@'); \
            for (var i = 0; i < imgs.length; ++i) {\
            var img = imgs[i];   \
            img.style.maxWidth = %f;\
            } \
            }%@AutoFit()",str,str,(ScreenW - 20),str];
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

//- (UIView*)statusBarBiew
//{
//    if (!_statusBarBiew) {
//        _statusBarBiew=[UIView new];
//        _statusBarBiew.backgroundColor=[UIColor whiteColor];
//        _statusBarBiew.frame=CGRectMake(0, 0, ScreenW, 64);
//        [self.view addSubview:_statusBarBiew];
//    }
//    return _statusBarBiew;
//}

- (UIButton*)commentBtn
{
    if (!_commentBtn) {
        _commentBtn=[UIButton new];
        [_commentBtn setImage:[UIImage imageNamed:@"commentBtn"] forState:0];
        _commentBtn.frame=CGRectMake(ScreenW-70, ScreenH-50, 40, 30);
        [_commentBtn addTarget:self action:@selector(toCommentPage) forControlEvents:UIControlEventTouchUpInside];
        [_webView addSubview:_commentBtn];
    }
    return _commentBtn;
}

- (void)toCommentPage
{
    CommentListController *list=[CommentListController new];
    list.sid=self.homeM.sid;
    [self.navigationController pushViewController:list animated:YES];
}

//- (UILabel*)titleL
//{
//    if (!_titleL) {
//        _titleL=[UILabel new];
//        _titleL.textColor=[UIColor blackColor];
//        _titleL.font=[UIFont systemFontOfSize:20];
//        _titleL.text=self.homeM.title;
//        CGFloat w = [self.homeM.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_titleL.font} context:nil].size.width;
//        _titleL.frame=CGRectMake(0, 64, w, 44);
//        _titleL.textAlignment=1;
//        _titleL.backgroundColor=[UIColor whiteColor];
//        [self.view addSubview:_titleL];
//        [self startToAnimate];
//    }
//    return _titleL;
//
//}

//- (void)startToAnimate{
//
//    CGFloat speed = 45.0;
//    CABasicAnimation * animate = [CABasicAnimation animation];
//    animate.fromValue = @( _titleL.frame.size.width+20);
//    animate.toValue=@( -_titleL.frame.size.width+20);
//    animate.keyPath = @"transform.translation.x";
//    animate.duration = (_titleL.frame.size.width + 20) / speed;
//    animate.removedOnCompletion = YES;
//    animate.repeatCount = MAXFLOAT;
//    [_titleL.layer addAnimation:animate forKey:@"containerView animation"];
//
//}

@end
