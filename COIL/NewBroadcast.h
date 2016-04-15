//
//  NewBroadcast.h
//  COIL
//
//  Created by Aseem 9 on 30/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface NewBroadcast : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGSize keyboardSize;
    CGRect previousRect ;
    BOOL FloatingButtonRemoved;
}

@property(nonatomic,strong)NSData *dataMedia;
@property(nonatomic,strong)NSMutableArray *arrayData;
@property(nonatomic,strong)NSMutableArray *ArrayImages;
@property(nonatomic,strong)NSMutableArray *ArrayVideos;
@property(nonatomic,strong)NSData *VideoData;
@property(nonatomic,strong)NSURL *VideoUrl;
@property(nonatomic,strong)NSString *accessToken;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;
- (IBAction)btnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewVideos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conColHeightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conColHeightVideo;

@end
