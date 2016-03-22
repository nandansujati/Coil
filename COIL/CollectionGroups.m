//
//  CollectionGroups.m
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CollectionGroups.h"

@implementation CollectionGroups

- (void)awakeFromNib {
    

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2-1,[UIScreen mainScreen].bounds.size.width/2);
    
    // Add colors to layer
    UIColor *centerColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:0.25];
    UIColor *endColor = [UIColor grayColor];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[endColor CGColor],
                       nil];
    
    [self.imageGroup.layer insertSublayer:gradient atIndex:0];

}

-(void)configureForCellWithCountry:(MyGroupsModal *)item ;
{
    self.GroupName.text=item.name;
    
   
    
    if (item.image.length>0)
    {
        _URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/150/150",ImagePath,item.image]];
        [self.imageGroup sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
       
    }
    else
    {

        [self.imageGroup setImage:[UIImage imageNamed:@"img_placeholder_group"]];
        
    }
}
@end
