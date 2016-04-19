//
//  CommentCell.m
//  COIL
//
//  Created by Taran on 07/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureForCellWithCountry:(CommentsModal *)modal
{
    if (modal.image)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.image]];
        [self.userImage sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.userImage.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    
    
    
    NSString *labelText = modal.comment;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    
    _lblcomment.attributedText=attributedString;
    _username.text=modal.Username;
    _lblCreated_at.text=[self GetTimePeriodLeft:modal];
}
-(NSString*)GetTimePeriodLeft:(CommentsModal*)modal
{
    NSString *start = modal.created_at;
    //  NSString *end = modal.subscription_end_at;
    [self getDateAndTime :modal];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [f dateFromString:start];
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* endDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
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



-(void)getDateAndTime:(CommentsModal*)modal
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
    
    NSString *Month=[[SharedClass SharedManager] getMonth:[arrayDate objectAtIndex:1]];
    Date=[NSString stringWithFormat:@"%@ %@,%@",Month,[arrayDate objectAtIndex:2],[arrayDate objectAtIndex:0]];
    
}

@end
