//
//  NotificationsVC.h
//  COIL
//
//  Created by Aseem 13 on 25/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface NotificationsVC : UIViewController
@property(nonatomic,strong) NSString *AccessToken;
@property(nonatomic,strong)NSMutableArray *NotificationsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
