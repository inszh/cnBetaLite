//
//  UIImageView+SDWeb.h
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (SDWeb)

-(void)imageWithUrlStr:(NSString *)urlStr
               phImage:(UIImage *)phImage;


- (void)imageWithUrlStrP:(NSString *)urlStr
         placeholderImage:(nullable UIImage *)phImage
                  options:(SDWebImageOptions)options
                 progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                completed:(nullable SDWebImageCompletionBlock)completedBlock;

@end
