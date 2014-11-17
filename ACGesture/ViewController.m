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
    
    //判斷是否變形
    BOOL isScaled = ! CGAffineTransformIsIdentity(tapGesture.view.transform);
    
    if (!isScaled) {
        CGAffineTransform scalingTransform;
        scalingTransform = CGAffineTransformMakeScale(1.2, 1.2);
        tapGesture.view.transform = scalingTransform;
    } else {
        tapGesture.view.transform = CGAffineTransformIdentity;
    }
}

#pragma mark -- pinch(拇指+食指)放大縮小
- (IBAction)pinchRecognizer:(id)sender {
    //固定寫法(用哪個手勢就用哪個來宣告)
    UIPinchGestureRecognizer *pinchGesture = (UIPinchGestureRecognizer *)sender;
    //兩指分開愈大透明度也會隨之更改(距離愈遠愈透明)
    pinchGesture.view.alpha = pinchGesture.scale / 5.f;
    NSLog(@"Scale:%f", pinchGesture.scale);
}

#pragma mark -- swipe(右上左下)滑行
- (IBAction)swipeRecognizer:(id)sender {
    UISwipeGestureRecognizer *swipeRightRecognizer = (UISwipeGestureRecognizer *)sender;
    
    switch (swipeRightRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            swipeRightRecognizer.view.backgroundColor = [UIColor redColor];
            break;
        case UISwipeGestureRecognizerDirectionUp:
            swipeRightRecognizer.view.backgroundColor = [UIColor orangeColor];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            swipeRightRecognizer.view.backgroundColor = [UIColor blackColor];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            swipeRightRecognizer.view.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    
}

#pragma mark --longPress(長按)
- (IBAction)longPressRecognizer:(id)sender {
    UILongPressGestureRecognizer *longPressedRecognizer = (UILongPressGestureRecognizer *)sender;
    //離開頁面
    NSLog(@"長按ing....");
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --旋轉
- (IBAction)rotationRecognizer:(id)sender {
    UIRotationGestureRecognizer *rotationRecognizer = (UIRotationGestureRecognizer *)sender;
    
    rotationRecognizer.view.transform = CGAffineTransformMakeRotation(rotationRecognizer.rotation);
}
#pragma mark --推拉手勢
- (IBAction)panRecognizer:(id)sender {
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    // 設定CGPoint
    CGPoint translation = [panGesture translationInView:self.view];
    panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x, panGesture.view.center.y + translation.y);
    [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [panGesture velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(panGesture.view.center.x + (velocity.x * slideFactor),
                                         panGesture.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            panGesture.view.center = finalPoint;
        } completion:nil];
        
    }
}


@end
