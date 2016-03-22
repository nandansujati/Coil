//
//  SearchUserExplore.h
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


@interface SearchUserExplore : UIViewController<UITextFieldDelegate>
{
    BOOL removedView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSearch;
@property DataSourceClass *datasource;
- (IBAction)btnCross:(id)sender;
@property(nonatomic,strong)NSArray*UserArray;
@end
