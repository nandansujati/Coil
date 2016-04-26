//
//  NotificationsModal.m
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NotificationsModal.h"

@implementation NotificationsModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    NotificationsModal *data=[[NotificationsModal alloc]init];
    
    data.UserImage = [Dict valueForKey:@"image"];
    data.NotificationType = [Dict valueForKey:@"notification_type"];
    data.NotificationText=[Dict valueForKey:@"notification_text"];
    data.userName=[Dict valueForKey:@"username"];
    data.GroupName=[Dict valueForKey:@"groupname"];
    data.createdAt=[Dict valueForKey:@"created_at"];
    return data;
    
}

-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        NotificationsModal *obj = [[NotificationsModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
    }
    return _FinalArray;
}

@end
