//
//  UserExploreCell.h
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModal.h"
#import "Header.h"
@interface UserExploreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;

@property(nonatomic,strong)NSURL *URLImage;
-(void)configureForCellWithCountry:(SearchModal *)item;
@end
