//
//  NewPostVC.h
//  COIL
//
//  Created by Aseem 9 on 31/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol GroupsFeedReload
-(void)ReloadFeeds;
@end
@interface NewPostVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGSize keyboardSize;
    CGRect previousRect ;
    BOOL FloatingButtonRemoved;
}
@property(nonatomic,strong)NSData *dataMedia;
@property(nonatomic,strong)NSMutableArray *arrayData;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVideos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *ArrayImages;
@property(nonatomic,strong)NSMutableArray *ArrayVideos;
@property(nonatomic,strong)NSData *VideoData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintVideoHieght;
@property(nonatomic,strong)NSURL *VideoUrl;
@property(nonatomic,strong)id<GroupsFeedReload>delegate;
@property(nonatomic,strong)NSDictionary *dictParameters;
@property(nonatomic,strong)NSString *accessToken;
@property(nonatomic,strong)NSString *group_Id;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;
- (IBAction)btnPost:(id)sender;
- (IBAction)btnBack:(id)sender;
@end
