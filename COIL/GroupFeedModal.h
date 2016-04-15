//
//  GroupFeedModal.h
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupFeedModal : NSObject
@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *post_type;
@property (nonatomic,strong) NSString *media;
@property (nonatomic,strong) NSString *media_type;
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *groupName;
@property(nonatomic,strong)NSString *activeMemberCount;
@property(nonatomic,strong)NSString *MemberImage;
@property(nonatomic,strong)NSString *MemberName;
@property(nonatomic,strong)NSString *like_count;
@property(nonatomic,strong)NSString *comment_count;
@property(nonatomic,strong)NSString *is_liked;
@property(nonatomic,strong)NSString *MemberStatus;
@property(nonatomic,strong)NSString *thumb;

-(id)ListAttributes :(NSDictionary*)Dict;
-(NSMutableArray*)ListmethodCall:(NSMutableArray*)arrayFromServer;
@property(strong, nonatomic)NSMutableArray *FinalArray;
@end
