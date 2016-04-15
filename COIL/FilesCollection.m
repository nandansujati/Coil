//
//  FilesCollection.m
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "FilesCollection.h"

@implementation FilesCollection

-(void)configureForCellWithCountry:(GroupDetailsModal *)item ;
{
    if (![item.fileThumb isEqualToString:@""])
    {
        _URLImage=[NSURL URLWithString:item.fileThumb];
        [self.imageFile sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        _btnPlay.hidden=NO;
       
    }
    else
    {
        _URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/150/150",ImagePath,item.fileMedia]];
        [self.imageFile sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        _btnPlay.hidden=YES;
        
    }

}
@end
