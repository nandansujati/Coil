//
//  ChangePasswordView.m
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ChangePasswordView.h"

@implementation ChangePasswordView

-(void)awakeFromNib
{
    [self setUpUI];
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:YES];
//    [self removeKeyboardObservers];
//}

-(void)setUpUI
{
    //Change placeHolder TextColour
    NSArray *Array= [NSArray arrayWithObjects:_txtNewPassword,_txtOldPassword,_txtConfirmNewPassword, nil];
    for (UITextField *textField in Array) {
        [self setupTextField:textField];
    }
    
    
    [self registerForKeyboardNotifications];//KeyboardNotifications
}

#pragma mark- TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder)
    {
        [nextResponder becomeFirstResponder];
    } else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)setupTextField:(UITextField*)textfield
{
    textfield.delegate=self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if (textField==_txtFieldEmail) {
//    }
    
    _activeField = textField;
}
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField==_txtFieldEmail)
//    {
//        
//    }
//}
#pragma mark- Keyboard notifications
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}
//Keyboard Shown
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    CGRect kbRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
   
    CGRect tfRect = [self.superview convertRect:_activeField.bounds fromView:_activeField];
    
    tfRect = CGRectMake(tfRect.origin.x, tfRect.origin.y, tfRect.size.width, tfRect.size.height);
    
    float OFFSET = (self.superview.frame.size.height -kbRect.size.height) - (tfRect.origin.y+tfRect.size.height);
    
    if (OFFSET < 0) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, OFFSET);
        }];
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

//Keyboard Hidden
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.transform = CGAffineTransformIdentity;
}

-(void)removeKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}


-(void)loadParameters
{
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    NSString *Access_Token=[Dictionary valueForKey:@"access_token"];
    _DictParameters=@{@"access_token":Access_Token,@"current_password":_txtOldPassword.text,@"new_password":_txtNewPassword.text};
  
}
-(void)loadPasswordApi
{
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest getData:UrlChangePassword :_DictParameters :^(NSArray *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                [_delegate btnDonePressed];
                [self removeKeyboardObservers];
            }
            else
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :[response_success valueForKey:@"msg"] :@"OK"];
            
        }  :^(NSError *response_error) {
            
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                [[SharedClass SharedManager]removeLoader];
            }];
        }
        
  

}
-(NSInteger)textFieldValidations
{
    NSInteger ValueValidation=0;
    if ([_txtOldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your Old password" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
        ValueValidation=1;
    }
  else  if ([_txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your New password" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
        ValueValidation=1;
    }
   else if ([_txtConfirmNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your password again" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
        ValueValidation=1;
    }
    else if (_txtNewPassword.text.length <6)
    {
        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Password must be of atleast 6 characters" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
        ValueValidation=1;
    }
    else if (![_txtConfirmNewPassword.text isEqualToString:_txtNewPassword.text])
    {
        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Password not matched" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
        ValueValidation=1;
    }
    return ValueValidation;
}
- (IBAction)btnDone:(id)sender
{
   NSInteger Vlaue= [self textFieldValidations];
    if (Vlaue==0) {
        [[SharedClass SharedManager]Loader:self];
        [self loadPasswordApi];
    }
   
 
}

- (IBAction)btnCancel:(id)sender {
    [_delegate btnCancelPressed];
}
@end
