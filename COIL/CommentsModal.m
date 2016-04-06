//
//  CommentsModal.m
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CommentsModal.h"

@implementation CommentsModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    CommentsModal *data=[[CommentsModal alloc]init];
    
    data.user_id = [Dict valueForKey:@"user_id"];
    data.comment = [Dict valueForKey:@"comment"];
    data.Username = [Dict valueForKey:@"name"];
    data.image = [Dict valueForKey:@"image"];
    data.created_at=[Dict valueForKey:@"created_at"];
    
    return data;
    
}

-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        CommentsModal *obj = [[CommentsModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
    }
    return _FinalArray;
}

@end
