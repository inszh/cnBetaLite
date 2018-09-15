//
//  HomeController.h
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController
-(void)loadTop10;
-(void)loadData;
- (void)hotType:(int)type;

@end
