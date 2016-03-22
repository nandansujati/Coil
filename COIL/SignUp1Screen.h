//
//  SignUp1Screen.h
//  COIL
//
//  Created by Aseem 9 on 10/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface SignUp1Screen : UIViewController<UITextFieldDelegate>
{
    NSInteger ValueValidation;
    
}
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;
@property(nonatomic,strong)NSString* Access_token;

@property(nonatomic,strong)NSDictionary *DictParameters;


@property(strong,nonatomic)UITextField *activeField;
- (IBAction)btnBack:(id)sender;

- (IBAction)btnContinue:(id)sender;
@end
