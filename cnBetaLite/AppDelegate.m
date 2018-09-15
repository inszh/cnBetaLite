//
//  AppDelegate.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "RightViewController.h"
#import "XLSlideMenu.h"
#import "CBNavController.h"
#import <UMShare/UMShare.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ArkBMKManager manager] setupBMK];
    
    //主界面
    HomeController *vc = [[HomeController alloc] init];
    //配置NavigationBar
    CBNavController *rootNav = [[CBNavController alloc] initWithRootViewController:vc];
    //右侧菜单
    RightViewController *rightVC = [[RightViewController alloc] init];
    //创建滑动菜单
    XLSlideMenu *slideMenu = [[XLSlideMenu alloc] initWithRootViewController:rootNav];
    //设置左右菜单
    slideMenu.rightViewController = rightVC;
    
    
    self.window.rootViewController = slideMenu;
    
    // U-Share 平台设置
//    [self configUSharePlatforms];

    return YES;
}



- (void)configUSharePlatforms
{
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8ce94c6dad48a50e" appSecret:@"fc9b8bdf390b26a26e051df1e85d200a" redirectURL:@"http://mobile.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"5b9c8003a40fa30567000060" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


@end
