//
//  GroupsMenu.h
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface GroupsMenu : UIView

@property DataSourceClass *datasource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *ArrayItems;
@property(nonatomic,strong)NSArray *ArrayImageItems;

@property (weak, nonatomic) IBOutlet UIButton *btnNewGroup;


@end
