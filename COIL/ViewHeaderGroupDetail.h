//
//  ViewHeaderGroupDetail.h
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol buttonPressedDelegate
-(void)btnBackPressed;
@end
@interface ViewHeaderGroupDetail : UIView
@property(nonatomic,strong)id<buttonPressedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageGroup;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UIButton *btnDiscoverability;



@property (weak, nonatomic) IBOutlet UILabel *labelActiveMembers;
@property (weak, nonatomic) IBOutlet UILabel *memberCount;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFiles;
@property (weak, nonatomic) IBOutlet UILabel *filesCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintFilesHeight;
- (IBAction)btnBack:(id)sender;
@end
