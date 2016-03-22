//
//  GroupDetailMembersCell.h
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetailsModal.h"
#import "Header.h"

@interface GroupDetailMembersCell : UITableViewCell
{
   // NSString *month;
    NSInteger minutes;
    NSInteger hour;
    NSInteger day;
    NSString *Time;
    NSString *Date;
}
@property (weak, nonatomic) IBOutlet UILabel *labelGroupAdmin;
@property (weak, nonatomic) IBOutlet UIImageView *imageMember;
@property (weak, nonatomic) IBOutlet UILabel *labelMemberName;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberLastSeen;
-(void)configureForCellWithCountry:(GroupDetailsModal *)item;
@end
