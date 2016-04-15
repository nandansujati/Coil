//
//  PostImagesCell.h
//  COIL
//
//  Created by Aseem 9 on 01/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostImagesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
-(void)configureForCellWithCountry:(UIImage *)item;
@end
