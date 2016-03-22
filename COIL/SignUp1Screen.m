//
//  SignUp1Screen.m
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SignUp1Screen.h"
@interface SignUp1Screen ()
@property(nonatomic,strong)SignUp2Screen *SetUpPrfile;
@end

@implementation SignUp1Screen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self removeKeyboardObservers];
}
#pragma mark- Call from ViewDidLoad
-(void)setUpUI
{
    //Change placeHolder TextColour
    NSArray *Array= [NSArray arrayWithObjects:_txtFieldEmail,_txtFieldPassword, nil];
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
    _DictParameters = @{@"email" :_txtFieldEmail.text,@"password":_txtFieldPassword.text};
}

-(void)SignUpCall
{
    [[SharedClass SharedManager]Loader:self.view];
    [self loadParameters];
    
    NSInteger value=[[SharedClass SharedManager]NetworkCheck];
    if (value==0)
    {
        [iOSRequest postData:UrlSignUp :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSString *str=[response_success valueForKey:@"success"];
            NSString *msg=[response_success valueForKey:@"msg"];
            _Access_token=[[response_success valueForKey:@"user"]valueForKey:@"access_token"];
            int successValue=[str intValue];
            if (successValue==1)
            {
                [self performSegueWithIdentifier:@"SegueSignUp2" sender:self];
                
            }
            else
            {
                [[SharedClass SharedManager]removeLoader];
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :msg :@"OK"];
            }
            
        }
                            :^(NSError *response_error)
         {
             [[SharedClass SharedManager]removeLoader];
             [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
             
         }];
        
    }
    else
    {
         [[SharedClass SharedManager]removeLoader];
    }
    
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
    if (textField==_txtFieldEmail) {
    }
    
    _activeField = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_txtFieldEmail)
    {
        
    }
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
    
//    CGRect tfRect = CGRectMake(self.activeField.frame.origin.x, self.activeField.frame.origin.y, self.activeField.frame.size.width, self.activeField.frame.size.height);
    
     CGRect tfRect = [self.view.window convertRect:_activeField.bounds fromView:_activeField];
    
    tfRect = CGRectMake(tfRect.origin.x, tfRect.origin.y, tfRect.size.width, tfRect.size.height);
    
    float OFFSET = (self.view.frame.size.height -kbRect.size.height) - (tfRect.origin.y+tfRect.size.height+10);
    
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
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_EMAIL];

    ValueValidation=0;
    if (ValueValidation==0)
    {
        
        if ([_txtFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your email" :@"Ok"];
            [[SharedClass SharedManager]removeLoader];
            ValueValidation=1;
            
        }
        
        else if ([_txtFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your password" :@"Ok"];
             [[SharedClass SharedManager]removeLoader];
            ValueValidation=1;
        }
        else if (![emailTest evaluateWithObject:_txtFieldEmail.text])
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter valid email" :@"Ok"];
            [[SharedClass SharedManager]removeLoader];
            ValueValidation=1;
        }
        else if (_txtFieldPassword.text.length <6)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Password must be of atleast 6 characters" :@"Ok"];
            [[SharedClass SharedManager]removeLoader];
            ValueValidation=1;
        }
       
    }
    return ValueValidation;
}



#pragma mark- SegueMethos
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueSignUp2"])
    {
        _SetUpPrfile = [segue destinationViewController];
        _SetUpPrfile.access_token=self.Access_token;
    }
   
}
#pragma mark- Button Actions
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnContinue:(id)sender
{
    [[SharedClass SharedManager]Loader:self.view];
    if ([_txtFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0 &&[_txtFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {

        [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your email and password first..!!" :@"Ok"];
        [[SharedClass SharedManager]removeLoader];
    }
    else
    {
        NSInteger Value=[self TextFieldValidations];
        if (Value==0)
        {
            NSInteger NetworkValue=[[SharedClass SharedManager]NetworkCheck];
            if (NetworkValue==0)
            {
                [iOSRequest postData:UrlIsEmailAvailable :@{@"email":_txtFieldEmail.text} :^(NSDictionary *response_success) {
                    [[SharedClass SharedManager]removeLoader];
                    NSString *str=[response_success valueForKey:@"success"];
                    NSString *msg=[response_success valueForKey:@"msg"];
                    int successValue=[str intValue];
                    if (successValue==0)
                    {
                        [[SharedClass SharedManager]removeLoader];
                        [[SharedClass SharedManager]AlertErrors:@"Error !!" :msg :@"OK"];
                        
                    }
                    else
                    {
                        
                        [self SignUpCall];
                    }
                    
                }
                                    :^(NSError *response_error)
                 {
                     [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                     
                 }];
            }
            
      
        }
    
    }
}

@end
