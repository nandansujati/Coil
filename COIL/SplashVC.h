//
//  SplashVC.h
//  COIL
//
//  Created by Aseem 9 on 09/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface SplashVC : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtView;
- (IBAction)btnLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)btnSignUp:(id)sender;

@end
