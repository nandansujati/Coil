//
//  GroupDetailMembersCell.m
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupDetailMembersCell.h"

@implementation GroupDetailMembersCell

- (void)awakeFromNib {
    _imageMember.layer.cornerRadius=3.0f;
    // Initialization code
}

-(void)configureForCellWithCountry:(GroupDetailsModal *)item
{
    self.labelMemberName.text=item.MemberName;
    if (item.image)
    {
       NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,item.image]];
        [self.imageMember sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imageMember.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    _lblMemberLastSeen.text=[self GetTimePeriodLeft:item];
    
    if ([item.MemberAdmin_Access integerValue]==1) {
        _labelGroupAdmin.hidden=NO;
    }
    else
        _labelGroupAdmin.hidden=YES;

}


-(NSString*)GetTimePeriodLeft:(GroupDetailsModal*)modal
{
    NSString *start = modal.MemberLastSeen;
  //  NSString *end = modal.subscription_end_at;
    [self getDateAndTime :modal];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [NSDate date];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units =  NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitHour |NSCalendarUnitMinute ;
    NSDateComponents *components = [gregorianCalendar components:units
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    day=[components day];
    hour = [components hour];
    minutes = [components minute];
    NSString *TimeString;
    if (day==0)
    {
        if (hour >0) {
           TimeString=[NSString stringWithFormat:@"Last seen : %ld hours ago",(long)hour];
        }
        else
        TimeString=[NSString stringWithFormat:@"Last seen : %ld mins ago",(long)minutes];
    }
   else if (day==1)
   {
       TimeString=[NSString stringWithFormat:@"Last seen yesterday at: %@ ",Time];
   }
    else if (day>1)
    {
        TimeString=[NSString stringWithFormat:@"Last seen at: %@ ",Date];
    }
    return TimeString;
    
}



-(void)getDateAndTime:(GroupDetailsModal*)modal
{
    NSArray *array=[modal.MemberLastSeen componentsSeparatedByString:@" "];
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
@end
