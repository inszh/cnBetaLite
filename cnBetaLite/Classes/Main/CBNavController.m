//
//  CBNavController.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "CBNavController.h"

@interface CBNavController ()

@end

@implementation CBNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    // 去掉导航栏的横线
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
//    [self.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor=[UIColor whiteColor];
}


@end
