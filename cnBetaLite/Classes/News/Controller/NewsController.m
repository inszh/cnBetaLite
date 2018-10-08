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
//#import <UShareUI/UShareUI.h>

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

//    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//
//        [self shareWebPageToPlatformType:platformType];
//    }];

//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
//
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//    }];
//}

@end
