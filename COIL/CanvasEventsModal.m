//
//  CanvasEventsModal.m
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CanvasEventsModal.h"

@implementation CanvasEventsModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    CanvasEventsModal *data=[[CanvasEventsModal alloc]init];
    
    data.EventTitle = [Dict valueForKey:@"title"];
    data.EventStartAt = [Dict valueForKey:@"start_at"];
    
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
        CanvasEventsModal *obj = [[CanvasEventsModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
    }
    return _FinalArray;
}

@end
