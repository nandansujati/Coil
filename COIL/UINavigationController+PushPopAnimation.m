//
//  UINavigationController+PushPopAnimation.m
//  Herbo
//
//  Created by RICHA on 12/29/15.
//  Copyright © 2015 Richa. All rights reserved.
//

#import "UINavigationController+PushPopAnimation.h"

@implementation UINavigationController (PushPopAnimation)
-(void)pushFromTop:(UIViewController *)VC {
   
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromBottom ;
    transition.delegate = self;
    [VC.view.layer addAnimation:transition forKey:nil];
    [self presentViewController:VC animated:YES completion:nil];
    
    
}

-(void)popFromBottomToParticularViewController:(UIViewController *)VC {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self popViewControllerAnimated:NO];
    
}
-(void)popFromBottom
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self popViewControllerAnimated:NO];
    
}

@end
