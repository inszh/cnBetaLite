//
//  HomeDataM.h
//  cnBeta_szh
//
//  Created by 小华 on 15/11/25.
//  Copyright © 2015年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDataM : NSObject
/**
 *  comments = 8,
	pubtime = 2015-11-25 10:49:29,
	score_story = -20,
	thumb = http://static.cnbetacdn.com/thumb/mini/article/2015/1125/84e18349b4d6bc9.jpg_100x100.jpg,
	ratings_story = 4,
	ratings = 5,
	title = [视频]通过Apple Pencil 让iPad Pro实现3D Touch,
	topic = 464,
	summary = iPadPro是苹果最新的设备，也是最强大的设备之一，但在iPadPro身上却找不到苹果最新的发明：3DTouch。不过开发者的创造力总是无穷的，日前开发者HamzaSood就凭借着丰富的iOS知识，在破解iOS9的同时成功改变了ApplePencil的压感数据，使之和3DTouch的响应相联。,
	sid = 451387,
	topic_logo = http://static.cnbetacdn.com/topics/5559844cd9cc1a5.png,
	score = -25,
	counter = 1416

 */
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * thumb;
@property(nonatomic,copy)NSString * hometext;
@property(nonatomic,copy)NSString * inputtime;
@property(nonatomic,copy)NSString * sid;
@property(nonatomic,copy)NSString * topic;
@property(nonatomic,copy)NSString * source;
@property(nonatomic,copy)NSString * summary;
@property(nonatomic,copy)NSString * topic_logo;




@end
