//
//  SignUp2Screen.h
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Header.h"
@interface SignUp2Screen : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    CGRect previousRect;
    NSInteger ValueValidation;
}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextView *txtViewBio;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeightTextView;
@property(nonatomic,strong)NSString* access_token;
@property(nonatomic,strong)NSDictionary *DictParameters;

@property(strong,nonatomic)UITextField *activeField;
@property(strong,nonatomic)UITextView *activeTextView;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlus;
- (IBAction)btnFinishSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ImageBubble;
@property (weak, nonatomic) IBOutlet UILabel *labelOnImage;

@property (weak, nonatomic) IBOutlet UIImageView *ImageStretched;
@end
