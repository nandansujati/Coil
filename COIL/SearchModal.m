//
//  SearchModal.m
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SearchModal.h"

@implementation SearchModal
-(id)ListAttributes :(NSDictionary*)Dict
{
    SearchModal *data=[[SearchModal alloc]init];
    
    data.name = [Dict valueForKey:@"name"];
    data.image = [Dict valueForKey:@"image"];
    data.email = [Dict valueForKey:@"email"];
    data.Group_Id=[Dict valueForKey:@"id"];
    return data;
    
}



-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer
{
    _FinalArray=[[NSMutableArray alloc]init];
    
    for(NSDictionary *eachPlace in arrayFromServer)
    {
        SearchModal *obj = [[SearchModal alloc] ListAttributes:eachPlace];
        
        [_FinalArray addObject:obj];
        
    }
    return _FinalArray;
}



@end
