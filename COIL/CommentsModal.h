//
//  CommentsModal.h
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModal : NSObject
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *Username;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *created_at;


-(id)ListAttributes :(NSDictionary*)Dict;
-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;
@property(strong, nonatomic)NSMutableArray *FinalArray;

@end
