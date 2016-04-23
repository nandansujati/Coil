//
//  CanvasGroupsModal.m
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CanvasGroupsModal.h"

@implementation CanvasGroupsModal

-(id)ListAttributes :(NSDictionary*)Dict
{
    CanvasGroupsModal *data=[[CanvasGroupsModal alloc]init];
    
    data.CourseName = [Dict valueForKey:@"name"];
    data.CourseId = [Dict valueForKey:@"id"];
//    data.Username = [Dict valueForKey:@"name"];
//    data.image = [Dict valueForKey:@"image"];
//    data.created_at=[Dict valueForKey:@"created_at"];
    
    return data;
    
}

-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        CanvasGroupsModal *obj = [[CanvasGroupsModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
    }
    return _FinalArray;
}


@end
