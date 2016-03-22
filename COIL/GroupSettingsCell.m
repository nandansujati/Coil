//
//  GroupSettingsCell.m
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupSettingsCell.h"

@implementation GroupSettingsCell


-(void)configureForCellWithCountry:(NSString *)item
{
    self.labelNames.text=item;
}

@end
