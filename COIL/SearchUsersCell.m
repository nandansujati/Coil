//
//  SearchUsersCell.m
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SearchUsersCell.h"

@implementation SearchUsersCell

-(void)configureForCellWithName:(NSString *)modal :(NSIndexPath*)indexPath ;
{
    if (indexPath.row==3)
    {
        _label.textColor=[UIColor colorWithRed:244.0/255.0 green:152.0/255.0 blue:120.0/255.0 alpha:1.0f];
       
    }
    else
    {
        _label.textColor=[UIColor whiteColor];
        
    }
    self.label.text=modal;
   
    
}

@end
