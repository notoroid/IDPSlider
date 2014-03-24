//
//  IDPSliderRimUIView.m
//  IDPSlider
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSliderRimView.h"

@implementation IDPSliderRimView

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
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.167 green: 0.167 blue: 0.167 alpha: 1];
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 3, 3) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(1.5, 1.5)];
    [rectangle2Path closePath];
    [color setFill];
    [rectangle2Path fill];
}

@end
