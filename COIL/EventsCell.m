//
//  EventsCell.m
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "EventsCell.h"

@implementation EventsCell

-(void)configureCellWithModal:(CanvasEventsModal*)modal
{
    _lblEventName.text=modal.EventTitle;
    NSDate *randomDate = [self convertDate:modal.EventStartAt];
    
    NSString *key = [[self dateFormatter]stringFromDate:randomDate];
    _lblEventTime.text=key;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"hh:mm a";
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    
    return dateFormatter;
}

-(NSDate*)convertDate:(NSString *)strDate
{
 
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
     NSDate *date = [dateFormatter dateFromString:strDate];
    NSTimeInterval secondsInEightHours = (1 * 60 * 60)/2;
    NSDate *dateHalfAhead = [date dateByAddingTimeInterval:secondsInEightHours];
    
    
      NSLog(@"date = %@", dateHalfAhead);


    return  dateHalfAhead;
}
- (IBAction)btnReminder:(id)sender {
    [_delegate btnReminderClicked:_indexPath];
               
}
@end
