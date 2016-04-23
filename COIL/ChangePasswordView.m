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
   
    CGRect tfRect = [self convertRect:_activeField.bounds fromView:_activeField];
    
    tfRect = CGRectMake(tfRect.origin.x, tfRect.origin.y, tfRect.size.width, tfRect.size.height);
    
    float OFFSET = (self.frame.size.height -kbRect.size.height) - (tfRect.origin.y+tfRect.size.height);
    
    if (OFFSET < 0) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, OFFSET);
        }];
        
    }
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

- (IBAction)btnDone:(id)sender {
    [_delegate btnDonePressed];
    [self removeKeyboardObservers];
}

- (IBAction)btnCancel:(id)sender {
    [_delegate btnCancelPressed];
}
@end
