//
//  groupFeedCell.h
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupFeedModal.h"
#import "Header.h"
@protocol BtnFeedCellPressed
-(void)btnLikePressed :(NSIndexPath*)indexPath;
-(void)btnCommentClicked:(NSIndexPath*)indexPath;
@end

@interface groupFeedCell : UITableViewCell

@property(nonatomic,strong)id<BtnFeedCellPressed>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *imageUser;
-(void)configureForCellWithCountry:(GroupFeedModal *)modal;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPost;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UILabel *lblComment_Likes;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeAdded;
- (IBAction)btnLikePressed:(id)sender;
- (IBAction)btnCommentPressed:(id)sender;
@end
