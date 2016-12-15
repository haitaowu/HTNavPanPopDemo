//
//  UIView+PositionExt.m
//  NetDemo
//
//  Created by taotao on 15/3/12.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "UIView+PositionExt.h"

@implementation UIView (PositionExt)
#pragma mark - setter method
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint aCenter = self.center;
    aCenter.x = centerX;
    self.center = aCenter;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint aCenter = self.center;
    aCenter.y = centerY;
    self.center = aCenter;
}
- (CGFloat)centerY
{
    return self.center.y;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;

}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;

}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}






@end
