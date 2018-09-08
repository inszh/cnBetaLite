//
//  CALayer+XibConfiguration.m
//  LHand
//
//  Created by 小华 on 15/11/26.
//  Copyright © 2015年 chenstone. All rights reserved.
//

#import "CALayer+XibConfiguration.h"
#import <QuartzCore/QuartzCore.h>

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}
-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end

