//
//  CollectionGroups.h
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "MyGroupsModal.h"
@interface CollectionGroups : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageGroup;


@property (weak, nonatomic) IBOutlet UILabel *GroupName;
@property(nonatomic,strong)NSURL *URLImage;
-(void)configureForCellWithCountry:(MyGroupsModal *)item ;
@end
