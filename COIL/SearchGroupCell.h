//
//  SearchGroupCell.h
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModal.h"
@interface SearchGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
-(void)configureForCellWithName:(NSString *)modal :(NSIndexPath*)indexPath :(BOOL)GroupClicked ;
@end
