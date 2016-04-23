//
//  SharedClass.h
//  SingletonClass
//
//  Created by Aseem 9 on 30/01/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import <Contacts/Contacts.h>
@interface SharedClass : NSObject
{
    BOOL grant;
    UIView *View1;
    NSInteger minutes;
    NSInteger hour;
    NSInteger day;
    NSInteger seconds;
    NSString *Time;
    NSString *Date;
    
}
@property(nonatomic,retain)NSString *str;
+(SharedClass*)SharedManager;
-(void)AlertErrors:(NSString*)Title :(NSString*)Message :(NSString*)btnTitle;
@property(strong,nonatomic)TLAlertView *Alert;
-(NSInteger)NetworkCheck;
-(NSMutableArray*)AddressBookFetch;
@property(nonatomic,strong)CNContactStore *store;
@property(nonatomic,strong)NSMutableArray *arrayAllContactList;
-(NSString*)GetTimePeriodLeft:(GroupFeedModal*)modal;
-(NSString*)GetTimePeriodLeftFromUser:(UserProfileModal*)modal;
-(NSString*)getMonth:(NSString*)Month;
-(NSString*)getFullMonth:(NSString*)Month;
-(void)Loader:(UIView*)view;
-(void)LoaderWhiteOverlay:(UIView*)view;
-(void)removeLoader;
-(BOOL)isAnimating;
@end
