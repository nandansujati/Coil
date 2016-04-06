//
//  CommentsVC.h
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "GroupFeedModal.h"
@protocol CommentPostedDelegate
-(void)commentPosted;
@end
@interface CommentsVC : UIViewController
{
    // NSString *month;
    NSInteger minutes;
    NSInteger hour;
    NSInteger day;
    NSInteger seconds;
    NSString *Time;
    NSString *Date;
    CGRect previousRect ;
    CGSize keyboardSize;
}
@property(nonatomic,strong)id<CommentPostedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *arrayComments;
@property(nonatomic,strong)NSDictionary*DictParameters;
@property(nonatomic,strong)NSString *Access_token;
@property(nonatomic,strong)NSString *postId;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong) GroupFeedModal *FeedModal;
@property (weak, nonatomic) IBOutlet UIImageView *imagePost;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextView *txtViewComment;
- (IBAction)btnSend:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomView;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPost;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UILabel *lblComment_Likes;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeAdded;
- (IBAction)btnLikePressed:(id)sender;
- (IBAction)btnCommentPressed:(id)sender;
@end
