//
//  GroupsMenuCell.h
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *labelBroadcastNames;
-(void)configureForCellWithCountry:(NSString *)item :(NSString*)imageItems;
@end
