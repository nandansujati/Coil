//
//  UserProfileVC.h
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface UserProfileVC : UIViewController
@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSString *User_Id;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSMutableArray *ProfileArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
