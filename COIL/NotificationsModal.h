//
//  NotificationsModal.h
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationsModal : NSObject
@property (nonatomic, strong) NSString *UserImage;
@property (nonatomic, strong) NSString *NotificationType;
@property (nonatomic,strong ) NSString *NotificationText;
@property (nonatomic,strong ) NSString *GroupName;
@property (nonatomic,strong )NSString *userName;
@property (nonatomic,strong )NSString *createdAt;
-(id)ListAttributes :(NSDictionary*)Dict;
-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;
@property(strong, nonatomic)NSMutableArray *FinalArray;
@end
