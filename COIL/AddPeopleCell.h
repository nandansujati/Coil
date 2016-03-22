//
//  AddPeopleCell.h
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModal.h"
#import "Header.h"
@protocol  bntClicked
-(void)BtnCheckboxClicked:(NSIndexPath *)indexpath;
@end
@interface AddPeopleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
-(void)configureForCellWithCountry:(ContactModal *)item ;
@property(nonatomic,strong)NSURL *URLImage;
@property (nonatomic, weak) id <bntClicked> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckbox;
@property (weak, nonatomic) IBOutlet UIButton *btnInvite;
- (IBAction)btnInvite:(id)sender;
- (IBAction)btnCheckbox:(id)sender;
@end
