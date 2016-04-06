//
//  CommentsVC.m
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CommentsVC.h"

@interface CommentsVC ()

@end

@implementation CommentsVC

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
    previousRect = CGRectZero;
    [self registerForKeyboardNotifications];
  //  self.tableView.estimatedRowHeight=50;
    
    [self configurePost:_FeedModal];
}



- (void)registerForKeyboardNotifications

{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        _constraintBottomView.constant = keyboardSize.height ;
        
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height-216, 0);
//        [self.tableView setContentOffset: CGPointMake(0, keyboardSize.height) animated: NO];
    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    [UIView animateWithDuration:0.3 animations:^{
        _constraintBottomView.constant = 0;
    }];
    
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y)
    {
        if (_constraintBottomViewHeight.constant<90)
        {
            _constraintBottomViewHeight.constant=_constraintBottomViewHeight.constant+20;
            
            [self adjustFrames];
        }
    }
    else if (currentRect.origin.y < previousRect.origin.y && _constraintBottomViewHeight.constant>70)
    {
        _constraintBottomViewHeight.constant=_constraintBottomViewHeight.constant-20;
    }
    previousRect = currentRect;
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if (range.length == 0) {
        if ([text isEqualToString:@"\n"]) {
            textView.text = [NSString stringWithFormat:@"%@\n",textView.text];
            
            return NO;
        }
    }
    //self.txtViewComment.layer.borderWidth = 2;
    return YES;
    
}
-(void)adjustFrames
{
    CGRect textFrame = self.txtViewComment.frame;
    textFrame.size.height = self.txtViewComment.contentSize.height;
    self.txtViewComment.frame = textFrame;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Comment.."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Comment..";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(void)removeKeyboardObservers

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    
}

-(void)configurePost:(GroupFeedModal *)modal
{
    if (modal.MemberImage)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.MemberImage]];
        [self.imagePost sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imagePost.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    
    
    
    NSString *labelText = modal.title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    
    _lblPost.attributedText=attributedString;
    _lblUserName.text=modal.MemberName;
    _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments . %@ likes",modal.comment_count,modal.like_count];
    
    _lblTimeAdded.text=[self GetTimePeriodLeft:modal];
    
}



-(NSString*)GetTimePeriodLeft:(GroupFeedModal*)modal
{
    NSString *start = modal.created_at;
    //  NSString *end = modal.subscription_end_at;
    [self getDateAndTime :modal];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [NSDate date];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units =  NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *components = [gregorianCalendar components:units
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    seconds=[components second];
    day=[components day];
    hour = [components hour];
    minutes = [components minute];
    NSString *TimeString;
    if (day==0)
    {
        
        if (hour >0) {
            TimeString=[NSString stringWithFormat:@"%ld h",(long)hour];
        }
        else
            if (minutes>0) {
                TimeString=[NSString stringWithFormat:@"%ld m",(long)minutes];
            }
            else
                TimeString=[NSString stringWithFormat:@"%ld s",(long)seconds];
    }
    else if (day==1)
    {
        TimeString=[NSString stringWithFormat:@"yesterday at: %@ ",Time];
    }
    else if (day>1)
    {
        TimeString=[NSString stringWithFormat:@"%@ ",Date];
    }
    return TimeString;
    
}



-(void)getDateAndTime:(GroupFeedModal*)modal
{
    NSArray *array=[modal.created_at componentsSeparatedByString:@" "];
    NSString *str=[array objectAtIndex:1];
    NSArray *arrayTime=[str componentsSeparatedByString:@":"];
    
    if ( [[arrayTime objectAtIndex:0]integerValue] >12)
    {
        NSInteger st=[[arrayTime objectAtIndex:0]integerValue] -12;
        Time=[NSString stringWithFormat:@"%ld:%@ PM",(long)st,[arrayTime objectAtIndex:1]];
    }
    else
    {
        Time=[NSString stringWithFormat:@"%@:%@ AM",[arrayTime objectAtIndex:0],[arrayTime objectAtIndex:1]];
    }
    
    NSString *strDate=[array objectAtIndex:0];
    NSArray *arrayDate=[strDate componentsSeparatedByString:@"-"];
    
    Date=[NSString stringWithFormat:@"%@/%@/%@",[arrayDate objectAtIndex:2],[arrayDate objectAtIndex:1],[arrayDate objectAtIndex:0]];
    
}


- (IBAction)btnLikePressed:(id)sender
{
   
}

- (IBAction)btnCommentPressed:(id)sender
{
    [_txtViewComment becomeFirstResponder];
}

- (IBAction)btnSend:(id)sender {
    self.txtViewComment.text=@"";
    [self.txtViewComment resignFirstResponder];
    _constraintBottomView.constant = 0 ;
    _constraintBottomViewHeight.constant=70;

}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
