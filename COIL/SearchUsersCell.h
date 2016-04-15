//
//  SearchUsersCell.h
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModal.h"
@interface SearchUsersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)configureForCellWithName:(NSString *)modal :(NSIndexPath*)indexPath ;
@end
