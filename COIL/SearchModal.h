//
//  SearchModal.h
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModal : NSObject
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *image;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString * Group_Id;
-(id)ListAttributes :(NSDictionary*)Dict;


-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;

@property(strong, nonatomic)NSMutableArray *FinalArray;

@end
