//
//  ViewHeaderGroupDetail.h
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "MyGroupsDataSource.h"
@protocol buttonPressedDelegate
-(void)btnBackPressed;
-(void)btnEditPressed;
-(void)btnDiscoverablitypPressed;
-(void)btnNotificationsPressed;
-(void)imagePressed;
-(void)btnAddPeoplePressed;
@end
@interface ViewHeaderGroupDetail : UIView
@property(nonatomic,strong)id<buttonPressedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageGroup;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UIButton *btnDiscoverability;
@property(nonatomic,strong)NSArray *filesArray;
-(void)setFilesData :(NSArray *)FilesArray;
- (IBAction)btnDiscoverabilty:(id)sender;
@property MyGroupsDataSource *datasource;
@property (weak, nonatomic) IBOutlet UILabel *labelActiveMembers;
@property (weak, nonatomic) IBOutlet UILabel *memberCount;
- (IBAction)btnNotifications:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnNotifications;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFiles;
@property (weak, nonatomic) IBOutlet UILabel *filesCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintFilesHeight;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnAddPeople:(id)sender;
@end
