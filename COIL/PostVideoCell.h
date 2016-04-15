//
//  PostVideoCell.h
//  COIL
//
//  Created by Aseem 9 on 04/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostVideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
-(void)configureForCellWithCountry:(UIImage *)item;
@end
