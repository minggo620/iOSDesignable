//
//  UIView+MGO.m
//  designable
//
//  Created by minggo on 16/5/12.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "UIView+MGO.h"
#import <objc/runtime.h>

@implementation UIView (MGO)


-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setBorderWidth:(CGFloat)borderWidth{
   
    self.layer.borderWidth = borderWidth;
}

-(void)setDefineValue:(CGFloat)defineValue{
    objc_setAssociatedObject(self, @selector(defineValue), @(defineValue), OBJC_ASSOCIATION_ASSIGN);
}


-(CGFloat)cornerRadius{
    
    return self.layer.cornerRadius;
}
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}
-(UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(CGFloat)defineValue{
    return [objc_getAssociatedObject(self, @selector(defineValue)) floatValue];
}


//-(void)setLinesWidth:(CGFloat)linesWidth{
//    objc_setAssociatedObject(self, @selector(linesWidth), @(linesWidth), OBJC_ASSOCIATION_ASSIGN);
//}
//-(CGFloat)linesWidth{
//    return [objc_getAssociatedObject(self, @selector(linesWidth)) floatValue];
//}

//-(void)drawRect:(CGRect)rect{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect myframe = self.bounds;
//    CGContextSetLineWidth(context,self.linesWidth);
//    CGRectInset(myframe, 1, 1);
//    [self.borderColor set];
//    UIRectFrame(myframe);
//}

@end
