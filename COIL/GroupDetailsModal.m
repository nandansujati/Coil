//
//  GroupDetailsModal.m
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupDetailsModal.h"

@implementation GroupDetailsModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    GroupDetailsModal *data=[[GroupDetailsModal alloc]init];
    
    data.GroupId = [[Dict valueForKey:@"group"] valueForKey:@"id"];
    data.name = [[Dict valueForKey:@"group"] valueForKey:@"name"];
    data.image = [[Dict valueForKey:@"group"] valueForKey:@"image"];
    data.member_count = [Dict valueForKey:@"member_count"];
    data.AdminId=[[Dict valueForKey:@"group"]valueForKey:@"owner_id"];
    data.Privacy=[[Dict valueForKey:@"group"]valueForKey:@"privacy"];
    data.FilesArray=[Dict valueForKey:@"files"];
    data.MembersArray=[GroupDetailsModal parserArray:[Dict valueForKey:@"members"]];
    data.is_admin=[Dict valueForKey:@"is_admin"];
    data.file_count=[Dict valueForKey:@"file_count"];
    data.notification=[Dict valueForKey:@"notification"];
    return data;
    
}



-(NSMutableArray*)ListmethodCall:(NSDictionary*)DictFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
//    for(NSDictionary *eachPlace in arrayFromServer)
//    {
        GroupDetailsModal *obj = [[GroupDetailsModal alloc] ListAttributes:DictFromServer];
        
        [_FinalArray addObject:obj];
        
//    }
    return _FinalArray;
}



+(NSArray*)parserArray:(NSArray*)arr
{
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in arr)
    {
        
        GroupDetailsModal * obj=[[GroupDetailsModal alloc]init];
        obj=[GroupDetailsModal parserDict:dict];
        [temparr addObject:obj];
    }
    return temparr;
}


+(GroupDetailsModal*)parserDict:(NSDictionary*)dict
{
    GroupDetailsModal* data=[[GroupDetailsModal alloc]init];
    
    data.MemberId=[dict valueForKey:@"id"];
    data.MemberImage=[dict valueForKey:@"image"];
    data.MemberName=[dict valueForKey:@"name"];
    data.MemberAdmin_Access=[dict valueForKey:@"admin_access"];
    data.MemberIsBlocked=[dict valueForKey:@"is_blocked"];
    data.MemberLastSeen=[dict valueForKey:@"last_seen"];
    data.MemberStatus=[dict valueForKey:@"status"];
    
    return data;
    
}


@end
