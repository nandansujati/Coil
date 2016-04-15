//
//  UINavigationController+PushPopAnimation.h
//  Herbo
//
//  Created by RICHA on 12/29/15.
//  Copyright © 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <QuartzCore/QuartzCore.h>

@interface UINavigationController (PushPopAnimation)
-(void)pushFromTop:(UIViewController *)VC;
-(void)popFromBottomToParticularViewController:(UIViewController *)VC;
-(void)popFromBottom;
@end
