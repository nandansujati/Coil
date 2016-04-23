//
//  SettingsCell.h
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
-(void)configureCell:(NSString*)Str;
- (IBAction)btnNotification:(id)sender;
@end
