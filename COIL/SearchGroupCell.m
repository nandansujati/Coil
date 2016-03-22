//
//  SearchGroupCell.m
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SearchGroupCell.h"

@implementation SearchGroupCell

-(void)configureForCellWithName:(NSString *)modal :(NSIndexPath*)indexPath :(BOOL)GroupClicked ;
{
    if (indexPath.row==2 && GroupClicked==NO)
    {
        _labelName.textColor=[UIColor colorWithRed:244.0/255.0 green:152.0/255.0 blue:120.0/255.0 alpha:1.0f];
    }
    else
    {
        _labelName.textColor=[UIColor whiteColor];

    }
   
        self.labelName.text=modal;
    
}


@end
