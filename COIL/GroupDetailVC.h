//
//  GroupDetailVC.h
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol settingGroupChanged
-(void)groupNmaeChanged:(NSString *)groupName;
@end
@interface GroupDetailVC : UIViewController<UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
   // NSString *discoverabilityString;
    NSInteger discoverabilityTag;
    NSInteger notificationTag;
    BOOL notificationTrue;
    NSIndexPath *currentIndexPath;
}

@property(nonatomic,strong)id<settingGroupChanged>delegate;
@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSString *Group_Id;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSDictionary *DictUpdateParameters;
@property(nonatomic,strong)NSMutableArray *GroupsArray;
@property (strong, nonatomic) NSString *UrlImage;
@property(nonatomic,strong)NSString *notificationFromModal;
@property(nonatomic,strong)NSMutableArray *arrayImage;

@property (strong, nonatomic)  NSString *labelGroupName;
@property (strong, nonatomic)  NSString *labelActiveMembers;
@property (strong, nonatomic) NSString *memberCount;

@property (strong, nonatomic)  NSString *textDiscoverability;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *MemberArray;
@property (nonatomic,strong) NSMutableArray *FilesArray;
//@property (strong, nonatomic)  UICollectionView *collectionViewFiles;
@property (strong, nonatomic)  NSString *filesCount;

@end
