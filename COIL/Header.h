//
//  Header.h
//  COIL
//
//  Created by Aseem 9 on 09/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define BasePath @"http://52.36.66.185/apiv1/"

#define UrlSignUp [NSString stringWithFormat:@"%@%@",BasePath,@"signup"]
#define UrlIsEmailAvailable [NSString stringWithFormat:@"%@%@",BasePath,@"isEmailAvailable"]
#define UrlsetUpProfile [NSString stringWithFormat:@"%@%@",BasePath,@"setProfile"]
#define UrlLogin [NSString stringWithFormat:@"%@%@",BasePath,@"login"]
#define UrlSearch [NSString stringWithFormat:@"%@%@",BasePath,@"search"]
#define UrlCreateGroup [NSString stringWithFormat:@"%@%@",BasePath,@"createGroup"]
#define UrlSyncContact [NSString stringWithFormat:@"%@%@",BasePath,@"syncContact"]
#define UrlMyGroups [NSString stringWithFormat:@"%@%@",BasePath,@"myGroups"]
#define UrlForgotPassword [NSString stringWithFormat:@"%@%@",BasePath,@"forgotPassword"]
#define UrlGroupDetails [NSString stringWithFormat:@"%@%@",BasePath,@"getGroupDetail"]
#define UrlGroupFeed [NSString stringWithFormat:@"%@%@",BasePath,@"getGroupFeed"]
#define UrlLikePost [NSString stringWithFormat:@"%@%@",BasePath,@"likePost"]
#define UrlUnlikePost [NSString stringWithFormat:@"%@%@",BasePath,@"unlikePost"]
#define UrlUpdateGroup [NSString stringWithFormat:@"%@%@",BasePath,@"updateGroup"]



#define ImagePath [NSString stringWithFormat:@"%@%@",BasePath,@"photo/"]
#import "AppDelegate.h"
#import "SignUp1Screen.h"
#import "SignUp2Screen.h"
#import "UINavigationController+PushPopAnimation.h"
#import "TLAlertView.h"
#import "ViewHeaderGroupDetail.h"
#import "NSString+TrimmingCharacters.h"
#import "iOSRequest.h"
#import "SharedClass.h"
#import "CustomButton.h"
#import "groupFeedCell.h"
#import "GroupFeedModal.h"
#import "GroupsScreen.h"
#import "GroupDetailsModal.h"
#import "GroupDetailVC.h"
#import "GroupsFeed.h"
#import "DataSourceClass.h"
#import "GroupDetailMembersCell.h"
#import "GroupsMenuCell.h"
#import "GroupSettingsCell.h"
#import "RNBlurModalView.h"
#import "GroupsMenu.h"
#import "GroupSettingMenu.h"
#import "NewGroupVC.h"
#import "AddPeopleVC.h"
#import "ViewSearch.h"
#import "MyGroupsModal.h"
#import "SearchGroupCell.h"
#import "SearchUsersCell.h"
#import "SearchModal.h"
#import "SearchUserExplore.h"
#import "ContactModal.h"
#import <Contacts/Contacts.h>
#import "AddPeopleCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyGroupsDataSource.h"
#import "CollectionGroups.h"
#import "UserExploreCell.h"
#import "BLMultiColorLoader.h"

#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{1,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#endif /* Header_h */
