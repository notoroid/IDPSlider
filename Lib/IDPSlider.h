//
//  IDPSlider.h
//  IDPSlider
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDPSliderStyle )
{
     IDPSliderStyleDefault
    ,IDPSliderStyleSlim
};

@protocol IDPSliderDelegate;

@interface IDPSlider : UIView
@property(assign,nonatomic) IDPSliderStyle sliderStyle;
@property(assign,nonatomic) CGFloat value;
@property(weak,nonatomic) IBOutlet id<IDPSliderDelegate> delegate;
@property(readonly,nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@end

@protocol IDPSliderDelegate <NSObject>

- (void) sliderChangeValue:(IDPSlider *)slider;

@end
