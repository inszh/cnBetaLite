//
//  CommentViewCell.h
//  cnBetaLite
//
//  Created by 小华 on 2018/9/8.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentM;
@interface CommentViewCell : UITableViewCell
@property(nonatomic,strong)CommentM * commM;
+(instancetype)cellWithTable:(UITableView*)tableView;

@end
