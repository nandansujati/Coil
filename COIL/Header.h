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
#define UrlCreatePost [NSString stringWithFormat:@"%@%@",BasePath,@"createPost"]
#define UrlMakeAdmin [NSString stringWithFormat:@"%@%@",BasePath,@"makeAdmin"]
#define UrlAddNewMembers [NSString stringWithFormat:@"%@%@",BasePath,@"addUserToGroup"]
#define UrlCommentOnPost [NSString stringWithFormat:@"%@%@",BasePath,@"commentPost"]
#define UrlgetCommentsOnPost [NSString stringWithFormat:@"%@%@",BasePath,@"getComments"]
#define UrlGetCanvasCourses [NSString stringWithFormat:@"%@%@",BasePath,@"listCourses"]
#define UrlGetUserProfile [NSString stringWithFormat:@"%@%@",BasePath,@"viewUserProfile"]
#define UrlRemoveMember [NSString stringWithFormat:@"%@%@",BasePath,@"removeUserFromGroup"]
#define UrlGetDummyImages [NSString stringWithFormat:@"%@%@",BasePath,@"getDummyImages"]
#define UrlChangePassword [NSString stringWithFormat:@"%@%@",BasePath,@"changePassword"]
#define UrlGetCalenderEvents [NSString stringWithFormat:@"%@%@",BasePath,@"getCalenderEvent"]

#define UrlUpdateCourseIds [NSString stringWithFormat:@"%@%@",BasePath,@"updateGroupCourse"]
#define UrlGetNotifications [NSString stringWithFormat:@"%@%@",BasePath,@"notifications"]


#define ImagePath [NSString stringWithFormat:@"%@%@",BasePath,@"photo/"]
#define VideoPath @"https://s3-us-west-2.amazonaws.com/cbdevs3/uploads/"

#define CellIdentifierNotificationCell1 @"NotificationCell1"
#define CellIdentifierNotificationCell2 @"NotificationCell2"


#import "DataSource2Cells.h"
#import "NotificationsModal.h"
#import "NotificationCell1.h"
#import "NotificationCell2.h"
#import "NotificationsVC.h"
#import "TabBarController.h"
#import "ViewCanvasIntegration.h"
#import "YPBubbleTransition.h"
#import "GetImagesView.h"
#import "ViewProfileHeader.h"
#import "UserProfileVC.h"
#import "DummyImagesCell.h"
#import "UserProfileModal.h"
#import "ImageView.h"
#import "CanvasGroupsModal.h"
#import "SelectGroupsBroadcast.h"
#import "CanvasGroupsCell.h"
#import "UINavigationController+RadialTransaction.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "CommentCell.h"
#import "UIViewController+PortalTransition.h"
#import "UINavigationController+PortalTransition.h"
#import "CYViewControllerTransitioningDelegate.h"
#import "CYNavigationControllerDelegate.h"
#import "CommentsModal.h"
#import "CommentsVC.h"
#import "AppDelegate.h"
#import "SignUp1Screen.h"
#import "PostVideoCell.h"
#import "CommentsVC.h"
#import "PostImagesCell.h"
#import "groupFeedImageCell.h"
#import "FilesCollection.h"
#import "VCFloatingActionButton.h"
#import "SignUp2Screen.h"
#import "NewPostVC.h"
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
#import "CalenderVC.h"
#import "GroupsFeed.h"
#import "DataSourceClass.h"
#import "GroupDetailMembersCell.h"
#import "GroupsMenuCell.h"
#import "SplashVC.h"
#import "ChangePasswordView.h"
#import "SettingsVC.h"
#import "SettingsCell.h"
#import "GroupSettingsCell.h"
#import "EventsCell.h"
#import "RNBlurModalView.h"
#import "GroupsMenu.h"
#import "CanvasEventsModal.h"
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
