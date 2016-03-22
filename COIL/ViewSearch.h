//
//  ViewSearch.h
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol PushFromSearchDelegate<NSObject>
@optional
-(void)PushFromUserSearch:(NSInteger)IndexPathRow :(NSArray*)UsersArray;

@end
@interface ViewSearch : UIView<UITextFieldDelegate>
{
    NSInteger UserSearchCountMore;
    
    }


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSDictionary *DictParameters;
@property(nonatomic,strong)NSString *Access_token;
@property(nonatomic,strong)NSArray *FinalGroupArray;
@property(nonatomic,strong)NSArray *FinalUserArray;
@property BOOL MoreGroupClicked;

@property(nonatomic,strong)NSMutableArray *ArrayAllGroups;
@property(nonatomic,strong)NSMutableArray *SplittedArray;
@property(nonatomic,strong)id<PushFromSearchDelegate>delegate;
-(void)GetGroupsAndUsers:(NSString*)newString;

@property(nonatomic,strong)NSArray *HeadersList;
@end
