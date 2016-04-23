//
//  SettingsVC.h
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface SettingsVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *ArraySettings;

@end
