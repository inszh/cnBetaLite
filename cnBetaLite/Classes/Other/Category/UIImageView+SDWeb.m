//
//  UIImageView+SDWeb.m
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "UIImageView+SDWeb.h"

@implementation UIImageView (SDWeb)

-(void)imageWithUrlStr:(NSString *)urlStr
               phImage:(UIImage *)phImage
{
    if(urlStr==nil) return;
    NSURL *url=[NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:phImage];
}


- (void)imageWithUrlStrP:(NSString *)urlStr
         placeholderImage:(nullable UIImage *)phImage
                  options:(SDWebImageOptions)options
                 progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                completed:(nullable SDWebImageCompletionBlock)completedBlock
{
    
    if(urlStr==nil) return;
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    [self sd_setImageWithURL:url
            placeholderImage:phImage
                     options:options
                    progress:progressBlock
                   completed:completedBlock];
}

@end
