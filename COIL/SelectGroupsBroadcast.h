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

@property BOOL VideoData;
@property(nonatomic,strong)NSData *dataMedia;
@property(nonatomic,strong)NSString *TextViewPost;
@property(nonatomic,strong)NSString *Access_Token;
@property(nonatomic,strong)NSMutableArray *FinalGroupsArray;
@property(nonatomic,strong)NSMutableArray *values;
@property(nonatomic,strong)NSMutableArray *ArrayGroupIds;
@property(nonatomic,strong)NSDictionary *DictParameters;
@property(nonatomic,strong)NSDictionary *DictParametersForPost;
@property(nonatomic,strong)NSArray *NewFinalArray;
@property(nonatomic,strong)NSMutableArray *ArrayAllStrings;

- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)btnPost:(id)sender;

@end
