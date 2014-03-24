//
//  IDPSliderBaseView.m
//  CenterPositionTool
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSliderBaseView.h"

@implementation IDPSliderBaseView

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
#define HORIZONTAL_MARGIN 15.0f
#define BASE_HEIGHT 3.0f
    
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.827 green: 0.827 blue: 0.827 alpha: 1];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake( CGRectGetMinX(rect) + HORIZONTAL_MARGIN
                                                                                      ,(rect.size.height - BASE_HEIGHT) * .5f
                                                                                      ,CGRectGetMaxX(rect) - HORIZONTAL_MARGIN * 2.0f, BASE_HEIGHT) cornerRadius: 2];
    [color setFill];
    [rectanglePath fill];
}

@end
