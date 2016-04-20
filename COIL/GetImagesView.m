//
//  GetImagesView.m
//  COIL
//
//  Created by Aseem 13 on 19/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GetImagesView.h"
#define CellIdentifierDummyImages @"ImagesCell"
@interface GetImagesView()

@end
@implementation GetImagesView
-(void)awakeFromNib
{
    UINib *nib = [UINib nibWithNibName:@"DummyImagesCell" bundle: nil];
    [self.collectionView registerNib:nib  forCellWithReuseIdentifier:CellIdentifierDummyImages];
}

-(void)getImagesArray :(NSArray *)ImagesArray
{
    _ImagesArray=ImagesArray;
    [_collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _ImagesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DummyImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierDummyImages forIndexPath:indexPath];
    cell.layer.cornerRadius=5.0f;
    NSString *imageString=[_ImagesArray objectAtIndex:indexPath.row];
    [cell configureForCellWithCountry:imageString ];
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *ImageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/150/150",ImagePath,[_ImagesArray objectAtIndex:indexPath.row]]];
    NSData *fileData = [NSData dataWithContentsOfURL:ImageURL];
    UIImage *image=[UIImage imageWithData:fileData];
    [_delegate getDummyImage:image];
}
- (IBAction)btnBack:(id)sender {
    [self removeFromSuperview];
}
@end
