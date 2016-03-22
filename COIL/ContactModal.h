//
//  ContactModal.h
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModal : NSObject
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSArray *Email;
@property(nonatomic,strong) NSArray *Phone;
@property (nonatomic, strong) NSString *UserId;
@property (nonatomic, strong) NSString *Image;
@property(nonatomic,strong) NSString *Match;

-(id)ListAttributes :(NSDictionary*)Dict;


-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;

@property(strong, nonatomic)NSMutableArray *FinalArray;
@end
