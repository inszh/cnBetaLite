//
//  CommentM.h
//  cnBetaLite
//
//  Created by 小华 on 2018/9/8.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentM : NSObject

//created_time = 2018-09-07 14:06:54,
//content = 谷歌都维持4G内存，说实话我的8G也没体现什么优势,
//support = 1,
//username = Cassfin,
//against = 0,
//tid = 14865893,
//pid = 0

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *support;



@end
