//
//  GroupsScreen.h
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#define CellIdentifierMyGroups @"MyGroupsCell"
@interface GroupsScreen : UIViewController


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *labelNoData;

@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSMutableArray *FinalGroupsArray;
- (IBAction)btnGroupsMenu:(id)sender;
- (IBAction)btnBroadcast:(id)sender;

@end
