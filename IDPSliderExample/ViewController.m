//
//  ViewController.m
//  IDPSliderExample
//
//  Created by 能登 要 on 2014/03/24.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "ViewController.h"
#import "IDPSlider.h"

@interface ViewController () <IDPSliderDelegate>
{
    __weak IBOutlet IDPSlider *_slider;
    __weak IBOutlet IDPSlider *_sliderSlim;
    __weak IBOutlet UILabel *_labelValue;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _slider.value = .25f;
    
    _labelValue.text = [NSString stringWithFormat:@"%@",@(_slider.value)];
    
    _sliderSlim.value = .25;
    _sliderSlim.sliderStyle = IDPSliderStyleSlim;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sliderChangeValue:(IDPSlider *)slider
{
    _labelValue.text = [NSString stringWithFormat:@"%@",@(slider.value)];
}


@end
