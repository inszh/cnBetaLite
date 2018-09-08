//
//  HomeCell.h
//  cnBeta_szh
//
//  Created by 小华 on 15/11/25.
//  Copyright © 2015年 ark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDataM.h"

@interface HomeCell : UITableViewCell

@property(nonatomic,strong)HomeDataM * homeM;

+(instancetype)cellWithTable:(UITableView*)tableView;

@end
