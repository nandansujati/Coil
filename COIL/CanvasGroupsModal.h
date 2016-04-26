//
//  CanvasGroupsModal.h
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CanvasGroupsModal : NSObject
@property (nonatomic, strong) NSString *CourseName;
@property (nonatomic, strong) NSString *CourseId;



-(id)ListAttributes :(NSDictionary*)Dict;
-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;
@property(strong, nonatomic)NSMutableArray *FinalArray;

@end
