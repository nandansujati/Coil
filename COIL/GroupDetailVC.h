//
//  GroupDetailVC.h
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface GroupDetailVC : UIViewController<UITableViewDataSource,buttonPressedDelegate>
@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSString *Group_Id;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSMutableArray *GroupsArray;
@property (strong, nonatomic) NSString *UrlImage;


@property (strong, nonatomic)  NSString *labelGroupName;
@property (strong, nonatomic)  NSString *labelActiveMembers;
@property (strong, nonatomic) NSString *memberCount;

@property (strong, nonatomic)  NSString *textDiscoverability;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *MemberArray;
@property (strong, nonatomic)  UICollectionView *collectionViewFiles;
@property (strong, nonatomic)  NSString *filesCount;

@end
