//
//  CommentViewCell.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/8.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "CommentViewCell.h"
#import "CommentM.h"

@interface CommentViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *supportL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;



@end

@implementation CommentViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}



+(instancetype)cellWithTable:(UITableView*)tableView
{
    static NSString * ID =@"comm";
    
    CommentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[[NSBundle  mainBundle]loadNibNamed:@"CommentViewCell" owner:self options:nil]  lastObject];
    }
    
    return cell;
}
-(void)setCommM:(CommentM *)commM
{
    _commM=commM;
    self.nameL.text=commM.username;
    self.timeL.text=commM.created_time;
    self.contentL.text=commM.content;
    self.supportL.text= [NSString stringWithFormat:@"支持%@",commM.support];
}

@end
