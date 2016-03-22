//
//  MyGroupsModal.h
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGroupsModal : NSObject

@property (nonatomic, strong) NSString *GroupId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *member_count;

-(id)ListAttributes :(NSDictionary*)Dict;


-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;

@property(strong, nonatomic)NSMutableArray *FinalArray;

@end
