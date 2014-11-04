//
//  ViewController.m
//  ACGesture
//
//  Created by Cyrilshanway on 2014/11/4.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --one tap-->背景顏色更改
- (IBAction)oneTapRecognizer:(id)sender {
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    tapGesture.view.backgroundColor = [UIColor greenColor];
    tapGesture.view.alpha = 1;
}

#pragma mark --two tap -->放大/縮回
- (IBAction)twoTapRecognizer:(id)sender {
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    tapGesture.view.backgroundColor = [UIColor brownColor];
    tapGesture.view.alpha = 1;
    
    
    BOOL isScaled = ! CGAffineTransformIsIdentity(tapGesture.view.transform);
    
    if (!isScaled) {
        CGAffineTransform scalingTransform;
        scalingTransform = CGAffineTransformMakeScale(1.2, 1.2);
        tapGesture.view.transform = scalingTransform;
    } else {
        tapGesture.view.transform = CGAffineTransformIdentity;
    }
}


@end
