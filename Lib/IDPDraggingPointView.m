//
//  IDPDraggingPointView.m
//  CenterPositionTool
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPDraggingPointView.h"

@implementation IDPDraggingPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.718 green: 0.698 blue: 0.659 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.914 green: 0 blue: 0.212 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, 3.1);
    CGFloat shadowBlurRadius = 5;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(10.5, 10.5, 27, 27)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [color2 setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
    
    [color setStroke];
    ovalPath.lineWidth = 7;
    [ovalPath stroke];
}

@end


@implementation IDPSlimDraggingPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0.985 green: 0.985 blue: 0.985 alpha: 1];
    UIColor* color4 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.4];
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor.blackColor colorWithAlphaComponent: 0.5];
    CGSize shadowOffset = CGSizeMake(0.1, 3.1);
    CGFloat shadowBlurRadius = 5;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(8.25, 7.75, 15, 15)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    [color3 setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
    
    [color4 setStroke];
    ovalPath.lineWidth = 0.5;
    [ovalPath stroke];
}

@end