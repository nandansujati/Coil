//
//  ViewProfileHeader.h
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ButtonPressedFromProfileHeader
-(void)btnBackPressed;
@end
@interface ViewProfileHeader : UIView
@property(nonatomic,strong)id<ButtonPressedFromProfileHeader>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property (weak, nonatomic) IBOutlet UIImageView *ImageBackground;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@property (weak, nonatomic) IBOutlet UILabel *lblBiography;
@property (weak, nonatomic) IBOutlet UILabel *lblMutualGroups;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@end
