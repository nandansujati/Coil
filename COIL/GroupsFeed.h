//
//  GroupsFeed.h
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface GroupsFeed : UIViewController
- (IBAction)btn3Dots:(id)sender;

@property(nonatomic,strong)NSDictionary *dictParameters;
@property(nonatomic,strong)NSMutableArray *finalFeedArray;
@property(nonatomic,strong)NSString *Group_Id;
@property(nonatomic,strong)NSString *accessToken;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)btnBack:(id)sender;
@property(nonatomic,strong)NSMutableArray *values;
@property (weak, nonatomic) IBOutlet UILabel *lblNoPosts;

@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPost;

- (IBAction)btnAddPost:(id)sender;
@end
