//
//  HomeCell.m
//  cnBeta_szh
//
//  Created by 小华 on 15/11/25.
//  Copyright © 2015年 ark. All rights reserved.
//

#import "HomeCell.h"


@interface HomeCell()

@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *topic_logo;
@property (weak, nonatomic) IBOutlet UILabel *title;
//@property (weak, nonatomic) IBOutlet UILabel *pubtime;


@end

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.topic_logo.layer.masksToBounds=YES;
    self.topic_logo.layer.cornerRadius = self.topic_logo.bounds.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTable:(UITableView*)tableView
{
    static NSString * ID =@"home";
    
    HomeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[[NSBundle  mainBundle]loadNibNamed:@"HomeCell" owner:self options:nil]  lastObject];
    }
    
    return cell;
}

-(void)setHomeM:(HomeDataM *)homeM
{
    _homeM=homeM;
    
    self.title.text=homeM.title;
    self.summary.text=homeM.summary;
    [self.topic_logo imageWithUrlStr:homeM.topic_logo phImage:[UIImage imageNamed:@"cnbetaph"]];
}

@end
