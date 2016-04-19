//
//  DummyImagesCell.h
//  COIL
//
//  Created by Aseem 13 on 19/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface DummyImagesCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
-(void)configureForCellWithCountry:(NSString *)image;
@end
