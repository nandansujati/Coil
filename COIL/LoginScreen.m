//
//  LoginScreen.m
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "LoginScreen.h"

@interface LoginScreen ()

@end

@implementation LoginScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Call from ViewDidLoad
-(void)setUpUI
{
//    [[UITabBar appearance]setDelegate:self];
    _txtEmail.text=@"taran.codebrew@gmail.com";
    _txtPassword.text=@"1";
    //Change placeHolder TextColour
    NSArray *Array= [NSArray arrayWithObjects:_txtEmail,_txtPassword, nil];
    for (UITextField *textField in Array) {
        [self changeTextFieldTextColour:textField];
        [self setupTextField:textField];
    }
    
     [self registerForKeyboardNotifications];//KeyboardNotifications
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)changeTextFieldTextColour:(UITextField*)TextField
{
    [TextField setValue:[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:119.0/255.0 alpha:1.0f]
             forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark- API Methods
-(void)loadParameters
{
    _DictParameters=@{@"email":_txtEmail.text,@"password":_txtPassword.text};
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
    _activeField = textField;
}


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
    
    CGRect tfRect = [self.view.window convertRect:_activeField.bounds fromView:_activeField];
    
    float OFFSET = (self.view.frame.size.height -kbRect.size.height) - (tfRect.origin.y+tfRect.size.height);
    
    if (OFFSET < 0) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, OFFSET);
        }];
        
    }
}


//Keyboard Hidden
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.view.transform = CGAffineTransformIdentity;
}

-(void)removeKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}


#pragma mark- Function Calls
-(NSInteger)TextFieldValidations
{
    ValueValidation=0;
    if (ValueValidation==0)
    {
        
        if ([_txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your Email" :@"Ok"];
            
            ValueValidation=1;
            
        }
        
        else if ([_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your Password" :@"Ok"];
            ValueValidation=1;
        }
        
    }
   
    return ValueValidation;
}
#pragma mark- Button Actions
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSignUp:(id)sender {
    SignUp1Screen *SgnUp=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUp1Screen"];
    [self.navigationController pushViewController:SgnUp animated:YES];
}

- (IBAction)btnLoginContinue:(id)sender {
    
   
    
    NSInteger Value=[self TextFieldValidations];
    if (Value==0)
    {
        NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
        if (valueNetwork==0)
        {
             [[SharedClass SharedManager]Loader:self.view];
            [self loadParameters];
            [iOSRequest postData:UrlLogin :_DictParameters :^(NSDictionary *response_success) {
                
                [[SharedClass SharedManager]removeLoader];
                 NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                 if (value==1)
                 {
                     NSDictionary *DictionaryLastAccessed=@{@"access_token":[[response_success valueForKey:@"user"]valueForKey:@"access_token"]};
                     
                     [[NSUserDefaults standardUserDefaults] setObject:DictionaryLastAccessed forKey:@"AccessToken"];
                     [self performSegueWithIdentifier:@"SegueTabBar" sender:self];
                 }
                else
                {
                    [[SharedClass SharedManager]AlertErrors:@"Error !!" :[response_success valueForKey:@"msg"] :@"OK"];
                
                }
                 
             }
                    :^(NSError *response_error) {
                        
                    [[SharedClass SharedManager]removeLoader];
                    [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                    }];
        }
          
    }
    

}

- (IBAction)btnForgotPassword:(id)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Forgot Password ?"
                                  message:@"Enter Your Email Address"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         
         textField.placeholder = @"Enter email here...";
         textField.keyboardType=UIKeyboardTypeEmailAddress;
     }];
    
    
//    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_EMAIL];
    
    
    UIAlertAction* Done = [UIAlertAction actionWithTitle:@"Done"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                           {
                               
                               [alert dismissViewControllerAnimated:YES completion:nil];
                               if ([alert.textFields.firstObject.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
                               {
                    
                                   [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"Please enter your email..!!" :@"OK"];
                               }
                               else
                               {
                                   if (![emailTest evaluateWithObject:alert.textFields.firstObject.text] == YES)
                                   {
                                      [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"Please enter a valid email..!!" :@"OK"];
                                   }
                                   else
                                   {
                                        [[SharedClass SharedManager]Loader:self.view];
                                       [iOSRequest postData:UrlForgotPassword :@{@"email" :alert.textFields.firstObject.text } :^(NSDictionary *response_success)
                                        {
                                            [[SharedClass SharedManager]removeLoader];
                                            
                                            if ([[response_success valueForKey:@"success"]integerValue]==1)
                                            {
                                            
                                                [[SharedClass SharedManager]AlertErrors:nil :@"Password reset link sent.Check your inbox..!!" :@"OK"];
                                            }
                                            else
                                            {
                                                [[SharedClass SharedManager]AlertErrors:nil :@"Email not registered..!!" :@"OK"];
                                                
                                            }
                                        }
                                                           :^(NSError *response_error) {
                                                               
                                                               [[SharedClass SharedManager]removeLoader];
                                                               [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                                               
                                                           }];
                                   }
                                   
                                   
                               }
                               
                               
                           }];
    UIAlertAction* Cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [self.view endEditing:YES];
                             }];
    
    [alert addAction:Done];
    [alert addAction:Cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
