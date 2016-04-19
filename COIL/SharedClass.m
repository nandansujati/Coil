//
//  SharedClass.m
//  SingletonClass
//
//  Created by Aseem 9 on 30/01/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SharedClass.h"
@interface SharedClass()
{
    BLMultiColorLoader *loader;
}
@end

@implementation SharedClass

+(SharedClass*)SharedManager {
    static SharedClass *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        _str = @"Default Property Value";
        _arrayAllContactList=[[NSMutableArray alloc]init];
        _store=[[CNContactStore alloc] init];
    }
    return self;
}

-(void)AlertErrors:(NSString*)Title :(NSString*)Message :(NSString*)btnTitle
{
    TLAlertView *alert=[[TLAlertView alloc]initWithTitle:Title message:Message buttonTitle:btnTitle];
    [alert show];
}

-(NSInteger)NetworkCheck
{
   __block int value = 0;
    if (value==0)
    {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
         {
             
             if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
             {}
             else
             {
                 [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                 
                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"The network connection was lost" :@"OK"];
                 value=1;
             }
             
         }];
   
    }
    return value;
}

-(NSMutableArray*)AddressBookFetch
{
    NSMutableArray *ContactArray=[[NSMutableArray alloc]init];
  
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey,CNContactEmailAddressesKey];
            NSString *containerId = _store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [_store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error) {
                NSLog(@"error fetching contacts %@", error);
            } else {
                NSString *firstName;
                NSString *fullName;
                NSString *lastName;
                NSString *Phone;
                NSString *Email;
                for (CNContact *contact in cnContacts)
                {
                    NSMutableArray *contactNumbersArray=[[NSMutableArray alloc]init];
                    NSMutableArray *EmailArray=[[NSMutableArray alloc]init];
                    // copy data to my custom Contacts class.
                    firstName = contact.givenName;
                    lastName = contact.familyName;
                    if (lastName == nil) {
                        fullName=[NSString stringWithFormat:@"%@",firstName];
                    }else if (firstName == nil){
                        fullName=[NSString stringWithFormat:@"%@",lastName];
                    }
                    else{
                        fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
                    }
                    
                    for (CNLabeledValue *label in contact.phoneNumbers) {
                        Phone = [label.value stringValue];
                        if ([Phone length] > 0) {
                            [contactNumbersArray addObject:Phone];
                        }
                    }
                    
                    for (CNLabeledValue *labelEmail in contact.emailAddresses)
                    {
                        Email = labelEmail.value ;
                        if ([Email length] > 0) {
                            [EmailArray addObject:Email];
                        }
                    }
                    
//                    NSData *data= contact.imageData;
                    
                    NSDictionary* personDict = [[NSDictionary alloc] initWithObjectsAndKeys:firstName,@"first_name",lastName,@"last_name",fullName,@"fullname",contactNumbersArray,@"contact",EmailArray,@"contact_emails", nil];
                    [ContactArray addObject:personDict];
                }
              
            }
    
   return ContactArray;
    
}

-(void)Loader:(UIView*)view
{
     View1= [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [View1 setAlpha:0.5];
    [View1 setBackgroundColor:[UIColor blackColor]];
    [view addSubview:View1];
    
    loader=[[BLMultiColorLoader alloc]initWithFrame:CGRectMake(view.frame.size.width/2-20, view.frame.size.height/2-20, 40, 40)];
    [view addSubview:loader];
    [loader startAnimation];
    
}


-(void)LoaderWhiteOverlay:(UIView*)view
{
    View1= [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //[View1 setAlpha:0.5];
    [View1 setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:View1];
    
    loader=[[BLMultiColorLoader alloc]initWithFrame:CGRectMake(view.frame.size.width/2-20, view.frame.size.height/2-20, 40, 40)];
    [view addSubview:loader];
    [loader startAnimation];
    
}

-(void)removeLoader
{
    [View1 removeFromSuperview];
    [loader removeFromSuperview];
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
    
    NSString *Month=[self getMonth:[arrayDate objectAtIndex:1]];
    Date=[NSString stringWithFormat:@"%@ %@,%@",Month,[arrayDate objectAtIndex:2],[arrayDate objectAtIndex:0]];
    
}

-(NSString*)GetTimePeriodLeftFromUser:(UserProfileModal*)modal
{
    NSString *start = modal.PostCreatedAt;
    //  NSString *end = modal.subscription_end_at;
    [self getDateAndTimeFromUser :modal];
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



-(void)getDateAndTimeFromUser:(UserProfileModal*)modal
{
    NSArray *array=[modal.PostCreatedAt componentsSeparatedByString:@" "];
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
    
    NSString *Month=[self getMonth:[arrayDate objectAtIndex:1]];
    Date=[NSString stringWithFormat:@"%@ %@,%@",Month,[arrayDate objectAtIndex:2],[arrayDate objectAtIndex:0]];
    
}



-(NSString*)getMonth:(NSString*)Month
{
     NSString *str;
    if ([Month isEqualToString:@"01"])
        str=@"Jan";
    else if ([Month isEqualToString:@"02"])
        str=@"Feb";
    else if ([Month isEqualToString:@"03"])
        str=@"Mar";
    else if ([Month isEqualToString:@"04"])
        str=@"Apr";
    else if ([Month isEqualToString:@"05"])
        str=@"May";
    else if ([Month isEqualToString:@"06"])
        str=@"June";
    else if ([Month isEqualToString:@"07"])
        str=@"July";
    else if ([Month isEqualToString:@"08"])
        str=@"Aug";
    else if ([Month isEqualToString:@"09"])
        str=@"Sept";
    else if ([Month isEqualToString:@"10"])
        str=@"Oct";
    else if ([Month isEqualToString:@"11"])
        str=@"Nov";
    else if ([Month isEqualToString:@"12"])
        str=@"Dec";
    return str;
}

@end
