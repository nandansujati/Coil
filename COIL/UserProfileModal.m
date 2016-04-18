//
//  UserProfileModal.m
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "UserProfileModal.h"

@implementation UserProfileModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    UserProfileModal *data=[[UserProfileModal alloc]init];
    
    data.mutual_group_count = [Dict valueForKey:@"mutual_group_count"];
      data.user_posts=[UserProfileModal parserArray:[Dict valueForKey:@"user_posts"]];
    //    data.comment = [Dict valueForKey:@"comment"];
    //    data.Username = [Dict valueForKey:@"name"];
    //    data.image = [Dict valueForKey:@"image"];
    //    data.created_at=[Dict valueForKey:@"created_at"];
    
    return data;
    
}

-(NSMutableArray*)ListmethodCall:(NSDictionary*)DictFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
//
//    for(NSDictionary *eachPlace in arrayFromServer)
//    {
        UserProfileModal *obj = [[UserProfileModal alloc] ListAttributes:DictFromServer];
        
        [_FinalArray addObject:obj];
//    }
    return _FinalArray;
}


+(NSArray*)parserArray:(NSArray*)arr
{
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in arr)
    {
        
        UserProfileModal * obj=[[UserProfileModal alloc]init];
        obj=[UserProfileModal parserDict:dict];
        [temparr addObject:obj];
    }
    return temparr;
}


+(UserProfileModal*)parserDict:(NSDictionary*)dict
{
    UserProfileModal* data=[[UserProfileModal alloc]init];
    
    data.PostTitle=[dict valueForKey:@"title"];
    data.PostMedia=[dict valueForKey:@"media"];
    data.PostThumb=[dict valueForKey:@"thumb"];
    data.PostCreatedAt=[dict valueForKey:@"created_at"];
    data.PostUserId=[dict valueForKey:@"user_id"];
    data.PostName=[dict valueForKey:@"name"];
    data.PostLikeCount=[dict valueForKey:@"like_count"];
    data.PostCommentCount=[dict valueForKey:@"comment_count"];
    data.PostIsLiked=[dict valueForKey:@"i_liked"];
    return data;
    
}

@end
