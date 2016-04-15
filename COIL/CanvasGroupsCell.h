//
//  CanvasGroupsCell.h
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "CanvasGroupsModal.h"
@protocol btnCheckboxClickedfromCanvas
-(void)checkBoxClicked :(NSIndexPath*)indexPath;
@end
@interface CanvasGroupsCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath*indexPath;
@property(nonatomic,strong)id<btnCheckboxClickedfromCanvas>delegate;
-(void)configureCellWithModal:(CanvasGroupsModal*)modal;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
- (IBAction)btnCheckbox:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckbox;
@end
