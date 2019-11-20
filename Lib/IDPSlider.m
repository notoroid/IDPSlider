//
//  IDPSlider.m
//  IDPSlider
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSlider.h"
#import "IDPSliderBaseView.h"
#import "IDPDraggingPointView.h"
#import "IDPSliderRimView.h"

@interface IDPSlider () <UIGestureRecognizerDelegate>
{
    IDPSliderBaseView *_sliderBaseView;
    UIView *_draggingPointView;
    IDPSliderRimView *_sliderRimView;
    UIView *_boardView;
    NSNumber *_dragOffsetX;
    UIPanGestureRecognizer *_panGestureRecognizer;
    
    IDPSliderStyle _sliderStyle;
}
@end

@implementation IDPSlider

- (IDPSliderStyle) sliderStyle
{
    return _sliderStyle;
}

- (void) setSliderStyle:(IDPSliderStyle)sliderStyle
{
    if( _sliderStyle != sliderStyle ){
        _sliderStyle = sliderStyle;

        if( _draggingPointView != nil ){
            CGPoint center = _draggingPointView.center;
            [_draggingPointView removeFromSuperview];
            
            _draggingPointView = sliderStyle == IDPSliderStyleDefault ? [[IDPDraggingPointView alloc] initWithFrame:(CGRect){CGPointMake(.0f, .0f),CGSizeMake(self.frame.size.height,self.frame.size.height)}] : [[IDPSlimDraggingPointView alloc] initWithFrame:(CGRect){CGPointMake(.0f, .0f),CGSizeMake(self.frame.size.height,self.frame.size.height)}];
            
            _draggingPointView.opaque = NO;
            _draggingPointView.backgroundColor = [UIColor clearColor];
            _draggingPointView.userInteractionEnabled = NO;
            
            [self addSubview:_draggingPointView];
            _draggingPointView.center = center;
        }
        
    }
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    return _panGestureRecognizer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    //    _value = .5f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if( _sliderBaseView == nil ){
        _sliderBaseView = [[IDPSliderBaseView alloc] initWithFrame:(CGRect){CGPointMake(.0f, .0f),self.frame.size}];
        _sliderBaseView.opaque = NO;
        _sliderBaseView.backgroundColor = [UIColor clearColor];
        [self addSubview:_sliderBaseView];
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(firedPan:)];
        _panGestureRecognizer.delegate = self;
        NSLog(@"panGestureRecognizer.delaysTouchesBegan=%@",_panGestureRecognizer.delaysTouchesBegan ? @"YES" : @"NO" );
        
        [_sliderBaseView addGestureRecognizer:_panGestureRecognizer];
    }
    
    if( _sliderRimView == nil ){
#define SLIDER_RIM_HEIGHT 3.0f
        _sliderRimView = [[IDPSliderRimView alloc] initWithFrame:CGRectMake(.0f, .0f, SLIDER_RIM_HEIGHT, SLIDER_RIM_HEIGHT)];
        _sliderRimView.opaque = NO;
        _sliderRimView.backgroundColor = [UIColor clearColor];
        [self addSubview:_sliderRimView];
        
#define SLIDER_RIM_OFFSET 15
        _sliderRimView.center = CGPointMake([self sliderEndPosition], _sliderBaseView.center.y );
    }
    
    if( _boardView == nil ){
        _boardView = [[UIView alloc] initWithFrame:CGRectMake(SLIDER_RIM_OFFSET + 3.0f, .0f,(self.frame.size.width - SLIDER_RIM_OFFSET * 2.0f) -SLIDER_RIM_HEIGHT, SLIDER_RIM_HEIGHT)];
        _boardView.backgroundColor = [UIColor colorWithRed: 0.167 green: 0.167 blue: 0.167 alpha: 1];
        [self addSubview:_boardView];
        
        _boardView.center = CGPointMake(_boardView.center.x, _sliderBaseView.center.y);
    }
    
    if( _draggingPointView == nil ){
        _draggingPointView = _sliderStyle == IDPSliderStyleDefault ? [[IDPDraggingPointView alloc] initWithFrame:(CGRect){CGPointMake(.0f, .0f),CGSizeMake(self.frame.size.height,self.frame.size.height)}] : [[IDPSlimDraggingPointView alloc] initWithFrame:(CGRect){CGPointMake(.0f, .0f),CGSizeMake(self.frame.size.height,self.frame.size.height)}];
        _draggingPointView.opaque = NO;
        _draggingPointView.backgroundColor = [UIColor clearColor];
        _draggingPointView.userInteractionEnabled = NO;
        
        [self addSubview:_draggingPointView];
        _draggingPointView.center = CGPointMake([self sliderBeginPosition] , _sliderBaseView.center.y );
        
        [self setValue:_value animated:NO];
    }
    
}

- (CGFloat) sliderBeginPosition
{
    return CGRectGetMinX(_sliderBaseView.frame) + SLIDER_RIM_OFFSET;
}

- (CGFloat) sliderEndPosition
{
    
    return CGRectGetMaxX(_sliderBaseView.frame) - SLIDER_RIM_OFFSET;
}

- (CGFloat) updateValue
{
    CGFloat length = [self sliderEndPosition] - [self sliderBeginPosition];
    CGFloat position = _draggingPointView.center.x - [self sliderBeginPosition];
    return position / length;
}

- (void) setValue:(CGFloat)value animated:(BOOL)animated
{
    dispatch_block_t block = ^{
        CGFloat length = [self sliderEndPosition] - [self sliderBeginPosition];
        self->_draggingPointView.center = CGPointMake([self sliderBeginPosition] + length * self->_value, self->_sliderBaseView.center.y );
        self->_boardView.frame = CGRectMake(self->_draggingPointView.center.x,  self->_boardView.frame.origin.y , self->_sliderRimView.frame.origin.x - self->_draggingPointView.center.x, self->_boardView.frame.size.height);
    };
    
    if( _draggingPointView != nil ){
        if( animated ){
            [UIView animateWithDuration:.25f animations:^{
                block();
            }];
        }else{
            block();
        }
    }
}

- (void) setValue:(CGFloat)value
{
    value = (value > 1.0) ? 1.0f : (value < .0f ? .0f : value);
    
    if( _value != value ){
        _value = value;
        [self setValue:value animated:YES];
    }
}


- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = YES;
    if( _panGestureRecognizer == gestureRecognizer ){
        CGPoint hitTest = [gestureRecognizer locationInView:_sliderBaseView.superview];
        CGRect hitTestRect = CGRectUnion(CGRectOffset(_draggingPointView.frame, -5.0f, -5.0f),CGRectOffset(_draggingPointView.frame, 5.0f, 5.0f) );
        
        shouldBegin = CGRectContainsPoint(hitTestRect, hitTest) ? YES : NO;
    }
    return shouldBegin;
}

- (IBAction)firedPan:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint location = [gesture locationInView:_sliderBaseView.superview];
            _dragOffsetX = @(_draggingPointView.center.x - location.x);
        }
            break;
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if( _dragOffsetX != nil ){
                switch (gesture.state) {
                    case UIGestureRecognizerStateChanged:
                    {
                        CGPoint pt = [gesture locationInView:_sliderBaseView];
                        pt.x -= [_dragOffsetX doubleValue];
                        pt.y = _sliderBaseView.center.y;
                        
                        if( pt.x < [self sliderBeginPosition] ){
                            pt.x = [self sliderBeginPosition];
                            
                        }else if( pt.x > [self sliderEndPosition] ){
                            pt.x = [self sliderEndPosition];
                        }
                        
                        //                        NSLog(@"UIGestureRecognizerStateChanged: call pt=%@",[NSValue valueWithCGPoint:pt]);
                        
                        _draggingPointView.center = pt;
                        
                        _boardView.frame = CGRectMake(_draggingPointView.center.x,  _boardView.frame.origin.y , _sliderRimView.frame.origin.x - _draggingPointView.center.x, _boardView.frame.size.height);
                        
                        _value = [self updateValue];
                        [_delegate sliderChangeValue:self];
                    }
                        break;
                    default:
                        break;
                }
                
                switch (gesture.state) {
                    case UIGestureRecognizerStateEnded:
                    case UIGestureRecognizerStateCancelled:
                        _dragOffsetX = nil;
                        break;
                    default:
                        break;
                }
                
                switch (gesture.state) {
                    case UIGestureRecognizerStateCancelled:
                    {
                        _value = [self updateValue];
                        [_delegate sliderChangeValue:self];
                    }
                        break;
                    case UIGestureRecognizerStateEnded:
                    {
                        CGPoint velocity = [gesture velocityInView:_sliderBaseView];
                        CGFloat move1 = velocity.x / ((CGRectGetWidth(_sliderBaseView.frame) - SLIDER_RIM_OFFSET * 2.0) * .125f);
                        if( fabs(move1) < 10.0f ){
                            move1 = .0f;
                        }
                        
                        CGFloat move2 = .0f;
                        if( move1 > 0 ){
                            if( _draggingPointView.center.x + move1 > [self sliderEndPosition] ){
                                move2 = [self sliderEndPosition] - (_draggingPointView.center.x + move1);
                                move1 += move2;
                            }
                        }else{
                            if( _draggingPointView.center.x + move1 < [self sliderBeginPosition] ){
                                move2 = [self sliderBeginPosition] - (_draggingPointView.center.x + move1);
                                move1 += move2;
                            }
                        }
                        
                        //                        NSLog(@"move1=%@",@(move1));
                        //                        NSLog(@"move2=%@",@(move2));
                        
                        if( move2 == .0f){
                            [UIView animateWithDuration:.25f delay:.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                                self->_draggingPointView.center = CGPointMake(self->_draggingPointView.center.x + move1, self->_draggingPointView.center.y);
                                self->_boardView.frame = CGRectMake(self->_draggingPointView.center.x,  self->_boardView.frame.origin.y , self->_sliderRimView.frame.origin.x - self->_draggingPointView.center.x, self->_boardView.frame.size.height);
                                
                            } completion:^(BOOL finished) {
                                self->_value = [self updateValue];
                                [self->_delegate sliderChangeValue:self];
                            }];
                        }else{
                            CGFloat total = fabs(move1) + fabs(move2);
                            CGFloat ratioMove1 = fabs(move1) / total;
                            CGFloat ratioMove2 = fabs(move2) / total;
                            // 距離に基づいて秒数比率を計算
                            
                            [UIView animateWithDuration:.25f * ratioMove1 delay:.0f options:UIViewAnimationOptionCurveLinear animations:^{
                                self->_draggingPointView.center = CGPointMake(self->_draggingPointView.center.x + move1, self->_draggingPointView.center.y);
                                self->_boardView.frame = CGRectMake(self->_draggingPointView.center.x,  self->_boardView.frame.origin.y , self->_sliderRimView.frame.origin.x - self->_draggingPointView.center.x, self->_boardView.frame.size.height);
                                
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:.25f * ratioMove2 delay:.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                                    self->_draggingPointView.center = CGPointMake(self->_draggingPointView.center.x + move2, self->_draggingPointView.center.y);
                                    self->_boardView.frame = CGRectMake(self->_draggingPointView.center.x,  self->_boardView.frame.origin.y , self->_sliderRimView.frame.origin.x - self->_draggingPointView.center.x, self->_boardView.frame.size.height);
                                    
                                } completion:^(BOOL finished) {
                                    self->_value = [self updateValue];
                                    [self->_delegate sliderChangeValue:self];
                                }];
                            }];
                        }
                    }
                        break;
                    default:
                        break;
                }
                
            }
        }
            break;
        default:
            break;
    }
}

@end
