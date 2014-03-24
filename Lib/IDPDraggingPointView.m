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
