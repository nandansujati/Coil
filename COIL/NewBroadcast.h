//
//  NewBroadcast.h
//  COIL
//
//  Created by Aseem 9 on 30/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBroadcast : UIViewController

- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;
- (IBAction)btnNext:(id)sender;

@end
