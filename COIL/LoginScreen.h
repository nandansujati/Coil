//
//  LoginScreen.h
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface LoginScreen : UIViewController<UITextFieldDelegate>
{
    NSInteger ValueValidation;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(strong,nonatomic)UITextField *activeField;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnLoginContinue:(id)sender;
- (IBAction)btnForgotPassword:(id)sender;
@end
