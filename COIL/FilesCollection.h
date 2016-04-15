//
//  FilesCollection.h
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "GroupDetailsModal.h"
@interface FilesCollection : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageFile;

@property(nonatomic,strong)NSURL *URLImage;
-(void)configureForCellWithCountry:(GroupDetailsModal *)item ;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@end
