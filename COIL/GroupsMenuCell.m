//
//  GroupsMenuCell.m
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupsMenuCell.h"

@implementation GroupsMenuCell

-(void)configureForCellWithCountry:(NSString *)item :(NSString*)imageItems
{
    
    self.labelBroadcastNames.text=item;
    self.image.image=[UIImage imageNamed:imageItems];
}
@end
