//
//  GroupSettingsCell.h
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupSettingsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelNames;
-(void)configureForCellWithCountry:(NSString *)item;
@end
