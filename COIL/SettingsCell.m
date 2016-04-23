//
//  SettingsCell.m
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell
-(void)configureCell:(NSString*)Str
{
    _lblName.text=Str;
}

- (IBAction)btnNotification:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag==0) {
        if (_btnArrow.selected==NO) {
            _btnArrow.selected=YES;
             [_btnArrow setImage:[UIImage imageNamed:@"switch_pressed"] forState:UIControlStateNormal];
        }
        else
        {
            _btnArrow.selected=NO;
             [_btnArrow setImage:[UIImage imageNamed:@"switch_normal"] forState:UIControlStateNormal];
        }
        
    }
    
}
@end
