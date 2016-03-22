//
//  SignUp2Screen.m
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SignUp2Screen.h"

@interface SignUp2Screen ()

@end

@implementation SignUp2Screen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
-(void)setupUI
{
    UIImage * backgroundImg = [UIImage imageNamed:@"Patch"];
    
    backgroundImg = [backgroundImg resizableImageWithCapInsets:UIEdgeInsetsMake(2,2, 2, 2)];
    
    [_ImageStretched setImage:backgroundImg];
    
    _image.layer.cornerRadius=3.0f;
   [ _txtFullName setValue:[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:119.0/255.0 alpha:1.0f]
             forKeyPath:@"_placeholderLabel.textColor"];
    
    _txtFullName.delegate=self;
    [self registerForKeyboardNotifications];//KeyboardNotifications
    
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleTap:)];
    pgr.delegate = self;
    self.image.userInteractionEnabled=YES;
    self.image.clipsToBounds = YES;
    [self.image addGestureRecognizer:pgr];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark- Api Methods
-(void)loadParameters
{
    _DictParameters=@{@"access_token":_access_token,@"name":_txtFullName.text,@"bio":_txtViewBio.text};
}
#pragma mark- TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextTag==1)
    {
        [_txtViewBio becomeFirstResponder];
        
    }
    else
    {
        if (nextResponder)
        {
            [nextResponder becomeFirstResponder];
        } else
        {
            [textField resignFirstResponder];
        }
    }

    return YES;
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
    CGSize kbRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect tfRect = CGRectMake(self.activeField.frame.origin.x, self.activeField.frame.origin.y, self.activeField.frame.size.width, self.activeField.frame.size.height);
    CGRect tvRect = CGRectMake(self.activeTextView.frame.origin.x, self.activeTextView.frame.origin.y, self.activeTextView.frame.size.width, self.activeTextView.frame.size.height);
   
    if (_activeTextView == nil)
    {
          float OFFSET = (self.view.frame.size.height -kbRect.height) - (tfRect.origin.y+tfRect.size.height);
            
            if (OFFSET < 0) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, OFFSET);
                }];
                
            }
    }
    else
    {
       float OFFSET = (self.view.frame.size.height -kbRect.height) - (tvRect.origin.y+tvRect.size.height);
        
        if (OFFSET < 0)
        {
            
            [UIView animateWithDuration:0.4 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, OFFSET-40);
            }];
            
        }
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

#pragma mark- TextView Delegate Methods
- (void)textViewDidChange:(UITextView *)textView
{
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y)
    {
        if (_HeightTextView.constant<100 && previousRect.origin.x!=0 && _txtViewBio.text.length> 3)
        {
            _HeightTextView.constant=_HeightTextView.constant+20;
            
            [self adjustFrames];
        }
    }
    else if (currentRect.origin.y < previousRect.origin.y && _HeightTextView.constant>25)
    {
        _HeightTextView.constant=_HeightTextView.constant-20;
    }
    previousRect = currentRect;
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if (range.length == 0) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            
            return NO;
        }
    }
    
    if(textView.text.length + (text.length - range.length) > 140)
    {
        return NO;
    }
    
    return YES;
    
}

-(void)adjustFrames
{
    CGRect textFrame = self.txtViewBio.frame;
    textFrame.size.height = self.txtViewBio.contentSize.height;
    self.txtViewBio.frame = textFrame;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    self.activeTextView=textView;
    if ([textView.text isEqualToString:@"Bio"]) {
        textView.text = @"";
        textView.textColor=[UIColor whiteColor];
    }
    
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _activeTextView = nil;
    if ([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        textView.text = @"";
        textView.text = @"Bio";
        textView.textColor=[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:119.0/255.0 alpha:1.0f];
    }
}


#pragma mark- ImagePicker Methods
- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSString *actionSheetTitle = @"UPLOAD IMAGES";
    NSString *destructiveTitle = @"CANCEL";
    NSString*btn1=@"Upload Picture";
    NSString *btn2=@"Take Photo";
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:actionSheetTitle
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction* Done = [UIAlertAction actionWithTitle:btn1
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                           {
                               UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                               picker.delegate = self;
                               picker.allowsEditing = YES;
                               picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               
                               [self presentViewController:picker animated:YES completion:NULL];
                               
                               
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           } ];
    
    UIAlertAction* Camera = [UIAlertAction
                             actionWithTitle:btn2
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                     
                                     [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"Device has no Camera" :@"OK"];
                                 }
                                 else
                                 {
                                     picker.delegate = self;
                                     picker.allowsEditing = YES;
                                     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                     
                                     [self presentViewController:picker animated:YES completion:NULL];
                                 }
                             }];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:destructiveTitle
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                           {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           } ];
    
    [alert addAction:Done];
    [alert addAction:Camera];
    [alert addAction:Cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image.image=chosenImage;
    self.imagePlus.hidden=YES;
    _ImageStretched.hidden=YES;
    _ImageBubble.hidden=YES;
    _labelOnImage.hidden=YES;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark- Function Calls
-(NSInteger)TextFieldValidations
{
    ValueValidation=0;
    if (ValueValidation==0)
    {
        
        if ([_txtFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your FullName" :@"Ok"];
            
            ValueValidation=1;
            
        }
        
        else if ([_txtViewBio.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0 || [_txtViewBio.text isEqualToString:@"Bio"])
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your Bio Description" :@"Ok"];
            ValueValidation=1;
            
        }
        
    }
    return ValueValidation;
}

#pragma mark- ButtonActions
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnFinishSignUp:(id)sender
{
    
    NSData *data = UIImageJPEGRepresentation(self.image.image, 0.5);
    
    NSInteger Value=[self TextFieldValidations];
    if (Value==0)
    {
        NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
        if (valueNetwork==0)
        {
            [[SharedClass SharedManager]Loader:self.view];
            [self loadParameters];
            [iOSRequest postMutliPartData:UrlsetUpProfile :_DictParameters :data :^(NSDictionary *response_success)
             {
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
                                             
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
            [[SharedClass SharedManager]removeLoader];
            }];
        }
        else
            [[SharedClass SharedManager]removeLoader];
    }
    
    
    
    


}
@end
