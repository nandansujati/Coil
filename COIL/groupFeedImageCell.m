//
//  groupFeedImageCell.m
//  COIL
//
//  Created by Aseem 9 on 05/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "groupFeedImageCell.h"

@implementation groupFeedImageCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblPost setPreferredMaxLayoutWidth:250];
}

-(void)layoutSubviews
{
    
    CGRect newCellSubViewsFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGRect newCellViewFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    self.contentView.frame = self.contentView.bounds = self.backgroundView.frame = self.accessoryView.frame = newCellSubViewsFrame;
    self.frame = newCellViewFrame;
    
    [super layoutSubviews];
}
-(void)configureForCellWithCountry:(GroupFeedModal *)modal
{
    if (modal.MemberImage)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.MemberImage]];
        [self.imageUser sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imageUser.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    
    if (modal.media)
    {
        
        if ([modal.media_ext isEqualToString:@""])
        {
            _btnPlay.hidden=NO;
        }
        else
        {
            NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/400/400",ImagePath,modal.media]];
            _btnPlay.hidden=YES;
            [self.imagePosted sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        }
       
    }
    else
        self.imagePosted.image=[UIImage imageNamed:@"img_placeholder_group"];
    
    
    
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


- (IBAction)btnLikePressed:(id)sender {
    [_delegate btnLikePressedImage:_indexPath];
}

- (IBAction)btnCommentPressed:(id)sender {
}

@end
