//
//  GroupSettingMenu.h
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol menuPressed
-(void)groupDetailsPressed;
@end
@interface GroupSettingMenu : UIView
@property DataSourceClass *datasource;
@property(nonatomic,strong)id<menuPressed>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *ArrayItems;
@end
