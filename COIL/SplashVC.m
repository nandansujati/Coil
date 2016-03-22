//
//  SplashVC.m
//  COIL
//
//  Created by Aseem 9 on 09/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SplashVC.h"
@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     self.navigationController.navigationBarHidden=YES;//hide Navigation Bar
}
#pragma mark- Call From ViewDidLoad
-(void)setUpUI
{
    [self TextViewLinksMethod];//Set Links in PrivacyPolicy
}

#pragma mark- Function Calls
#pragma mark TextViewLinkMethod
-(void)TextViewLinksMethod
{
    _txtView.editable=NO;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    UIFont *font_bold=[UIFont fontWithName:@"SFUIText-Bold" size:10.0f];
    UIFont *font_regular=[UIFont fontWithName:@"SFUIText-Medium" size:10.0f];
    
    NSMutableAttributedString* agreeAttributedString = [[NSMutableAttributedString alloc] initWithString:@"By signing up you agree to the {                } and {            }" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:160 green:160 blue:163 alpha:0.6f ],NSFontAttributeName:font_regular}];
    
    
   
    
    NSAttributedString* termsAttributedString = [[NSAttributedString alloc] initWithString:@"terms & conditions"
                                                                                attributes:@{
                                                                                             @"termsTag" : @(YES),
                                                                                             NSForegroundColorAttributeName : [UIColor colorWithRed:160 green:160 blue:163 alpha:0.7f ]}];
   
    
    NSAttributedString* policyAttributedString = [[NSAttributedString alloc]initWithString:@"privacy policy"
                                                                                attributes:@{
                                                                                             @"policyTag" : @(YES),
                                                                                             NSForegroundColorAttributeName : [UIColor colorWithRed:160 green:160 blue:163 alpha:0.7f ]
                                                                                             }];
    
    NSRange range0 = [[agreeAttributedString string] rangeOfString:@"{                }"];
    if(range0.location != NSNotFound)
        [agreeAttributedString replaceCharactersInRange:range0 withAttributedString:termsAttributedString];
    
    NSRange range1 = [[agreeAttributedString string] rangeOfString:@"{            }"];
    if(range1.location != NSNotFound)
        [agreeAttributedString replaceCharactersInRange:range1 withAttributedString:policyAttributedString];
    
    [agreeAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [agreeAttributedString length])];
    
      [agreeAttributedString addAttribute:NSFontAttributeName value:font_bold range:range0];
    [agreeAttributedString addAttribute:NSFontAttributeName value:font_bold range:range1];
    
    self.txtView.attributedText = agreeAttributedString;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(txtViewTextTouched:)];
    [self.txtView addGestureRecognizer:tap];
}

//TextViewTapped Text
-(void)txtViewTextTouched:(UITapGestureRecognizer *)recognizer
{
    UITextView *textView = (UITextView *)recognizer.view;
    
    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textView.textStorage.length) {
        
        NSRange range0;
        NSRange range1;
        id termsValue = [textView.textStorage attribute:@"termsTag" atIndex:characterIndex effectiveRange:&range0];
        id policyValue = [textView.textStorage attribute:@"policyTag" atIndex:characterIndex effectiveRange:&range1];
        
        if(termsValue)
        {
            NSLog(@"TERMS TAPPED");
            return;
        }
        
        if(policyValue)
        {
            NSLog(@"POLICY TAPPED");
            return;
        }
    }
}

#pragma  mark- Button Actions
- (IBAction)btnLogin:(id)sender {
    
    [self performSegueWithIdentifier:@"SegueLogin" sender:self];
}
- (IBAction)btnSignUp:(id)sender {
    [self performSegueWithIdentifier:@"SegueSignUp1" sender:self];
 
}
@end
