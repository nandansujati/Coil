//
//  ChangePasswordView.h
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ButtonPressedFromChnagePasword
-(void)btnDonePressed;
-(void)btnCancelPressed;
@end
@interface ChangePasswordView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)id<ButtonPressedFromChnagePasword>delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmNewPassword;
@property(nonatomic,strong)UITextField *activeField;
- (IBAction)btnDone:(id)sender;
- (IBAction)btnCancel:(id)sender;
@end
