//
//  CanvasGroupsCell.m
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CanvasGroupsCell.h"

@implementation CanvasGroupsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configureCellWithModal:(CanvasGroupsModal*)modal
{
    _lblGroupName.text=[modal.CourseName capitalizedString];
    
}

- (IBAction)btnCheckbox:(id)sender {
    [_delegate checkBoxClicked :_indexPath];
}
@end
