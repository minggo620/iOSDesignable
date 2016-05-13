//
//  UIImageView+MGO.m
//  designable
//
//  Created by minggo on 16/5/13.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "UIImageView+MGO.h"
#import <objc/runtime.h>

@implementation UIImageView (MGO)

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius),OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

@end
