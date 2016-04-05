//
//  AddPeopleCell.m
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "AddPeopleCell.h"

@implementation AddPeopleCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureForCellWithCountry:(ContactModal *)item ;
{
    self.labelName.text=item.fullName;
    if (item.Image)
    {
        _URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,item.Image]];
         [self.image sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.image.image=[UIImage imageNamed:@"img_placeholder_user"];
}


-(void)configureForCellWithModal:(MyGroupsModal *)item
{
    _image.layer.cornerRadius=5.0;
    self.labelName.text=item.name;
    if (item.image)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,item.image]];
        [self.image sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.image.image=[UIImage imageNamed:@"img_placeholder_user"];
}

- (IBAction)btnInvite:(id)sender
{
    [_delegate BtnInvite:_indexPath];
}

- (IBAction)btnCheckbox:(id)sender {
    [self.delegate BtnCheckboxClicked:_indexPath];
}
@end
