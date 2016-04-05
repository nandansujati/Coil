//
//  NewBroadcast.m
//  COIL
//
//  Created by Aseem 9 on 30/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NewBroadcast.h"

@interface NewBroadcast ()

@end

@implementation NewBroadcast

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUI
{
    _constraintTextViewHeight.constant=self.view.frame.size.height-300;
   
    
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if (range.length == 0) {
        if ([text isEqualToString:@"\n"]) {
            textView.text = [NSString stringWithFormat:@"%@\n",textView.text];
            [self.view endEditing:YES];
            return NO;
        }
    }
   
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Type here"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Type here";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}


- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnNext:(id)sender {
    [self performSegueWithIdentifier:@"SelectGroupsBroadcast" sender:self];
}
@end
