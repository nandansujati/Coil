//
//  SelectGroupsBroadcast.h
//  COIL
//
//  Created by Aseem 9 on 31/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface SelectGroupsBroadcast : UIViewController
@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSMutableArray *FinalGroupsArray;
@property(nonatomic,strong)NSMutableArray *values;
@property(nonatomic,strong)NSMutableArray *ArrayGroupIds;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSArray *NewFinalArray;
@property(nonatomic,strong)NSMutableArray *ArrayAllStrings;
@property DataSourceClass *datasource;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
