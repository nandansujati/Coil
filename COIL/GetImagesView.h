//
//  GetImagesView.h
//  COIL
//
//  Created by Aseem 13 on 19/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol dummyImageDelegate
-(void)getDummyImage:(UIImage*)image;
@end
@interface GetImagesView : UIView
@property(nonatomic,strong)id<dummyImageDelegate>delegate;
@property(nonatomic,strong)NSArray *ImagesArray;
-(void)getImagesArray :(NSArray *)ImagesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)btnBack:(id)sender;
@end
