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


-(BOOL)isAnimating
{
    BOOL Value=[loader isAnimating];
    return Value;
}
@end
