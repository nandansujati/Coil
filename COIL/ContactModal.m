//
//  ContactModal.m
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ContactModal.h"

@implementation ContactModal

-(id)ListAttributes :(NSDictionary*)Dict
{
    ContactModal *data=[[ContactModal alloc]init];
    
    data.firstName = [Dict valueForKey:@"first_name"];
    data.lastName = [Dict valueForKey:@"last_name"];
    data.fullName = [Dict valueForKey:@"fullname"];
    data.Email = [Dict valueForKey:@"contact_emails"];
    data.Phone = [Dict valueForKey:@"contact"];
    data.UserId = [Dict valueForKey:@"id"];
    data.Image = [Dict valueForKey:@"image"];
    data.Match = [Dict valueForKey:@"match"];
    return data;
    
}



-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        ContactModal *obj = [[ContactModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
        
    }
    return _FinalArray;
}

@end
