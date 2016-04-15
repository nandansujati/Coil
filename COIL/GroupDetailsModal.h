//
//  GroupDetailsModal.h
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupDetailsModal : NSObject
@property (nonatomic, strong) NSString *GroupId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic,strong) NSString *AdminId;
@property (nonatomic,strong) NSString *Privacy;
@property (nonatomic, strong) NSArray *FilesArray;
@property(nonatomic,strong) NSString *fileMedia;
@property(nonatomic,strong) NSString *fileMediaType;
@property(nonatomic,strong)NSString *fileThumb;
@property (nonatomic, strong) NSArray *MembersArray;

@property(nonatomic,strong)NSString *MemberId;
@property(nonatomic,strong)NSString *MemberImage;
@property(nonatomic,strong)NSString *MemberName;
@property(nonatomic,strong)NSString *MemberLastSeen;
@property(nonatomic,strong)NSString *MemberAdmin_Access;
@property(nonatomic,strong)NSString *MemberIsBlocked;
@property(nonatomic,strong)NSString *MemberStatus;
@property(nonatomic,strong)NSString *notification;

@property (nonatomic, strong) NSString *member_count;
@property (nonatomic, strong) NSString *file_count;
@property (nonatomic, strong) NSString *is_admin;

-(id)ListAttributes :(NSDictionary*)Dict;


-(NSMutableArray*)ListmethodCall:(NSDictionary*)DictFromServer;

@property(strong, nonatomic)NSMutableArray *FinalArray;

@end


