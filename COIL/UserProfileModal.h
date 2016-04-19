//
//  UserProfileModal.h
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfileModal : NSObject

@property (nonatomic, strong) NSString *mutual_group_count;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userImage;
@property(nonatomic,strong)NSString *userBiography;

@property (nonatomic, strong) NSArray *userPosts;
@property(nonatomic,strong)NSString *PostId;
@property (nonatomic, strong) NSString *PostTitle;
@property (nonatomic,strong) NSString *PostMedia;
@property(nonatomic,strong) NSString *PostImage;
@property (nonatomic,strong) NSString *PostThumb;
@property (nonatomic,strong) NSString *PostCreatedAt;
@property (nonatomic,strong) NSString *PostUserId;
@property (nonatomic,strong) NSString *PostName;
@property (nonatomic,strong) NSString *PostLikeCount;
@property (nonatomic,strong) NSString *PostCommentCount;
@property (nonatomic,strong) NSString *PostIsLiked;

-(id)ListAttributes :(NSDictionary*)Dict;
-(NSMutableArray*)ListmethodCall:(NSDictionary*)DictFromServer;
@property(strong, nonatomic)NSMutableArray *FinalArray;
@end
