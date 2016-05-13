//
//  IBDesignableImageView.m
//  designable
//
//  Created by minggo on 16/5/13.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "IBDesignableImageView.h"

@implementation IBDesignableImageView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    _cornerRadius = cornerRadius;//不要使用self.cornerRadius = cornerRadius;这样会死循环
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

@end
