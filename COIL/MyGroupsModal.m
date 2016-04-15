//
//  MyGroupsModal.m
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "MyGroupsModal.h"

@implementation MyGroupsModal

-(id)ListAttributes :(NSDictionary*)Dict
{
    MyGroupsModal *data=[[MyGroupsModal alloc]init];
    
    data.GroupId = [Dict valueForKey:@"id"];
    data.name = [Dict valueForKey:@"name"];
    data.image = [Dict valueForKey:@"image"];
    data.member_count = [Dict valueForKey:@"member_count"];
 
    return data;
    
}



-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        MyGroupsModal *obj = [[MyGroupsModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
        
    }
    return _FinalArray;
}

@end
