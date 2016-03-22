//
//  UserExploreCell.m
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "UserExploreCell.h"

@implementation UserExploreCell

- (void)awakeFromNib {
    // Initialization code
    _image.layer.cornerRadius=3.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureForCellWithCountry:(SearchModal *)item
{
    self.labelUserName.text=item.name;
    if (item.image)
    {
        _URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,item.image]];
        [self.image sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.image.image=[UIImage imageNamed:@"img_placeholder_user"];
}

@end
