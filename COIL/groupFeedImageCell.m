//
//  groupFeedImageCell.m
//  COIL
//
//  Created by Aseem 9 on 05/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "groupFeedImageCell.h"
#import <AVFoundation/AVFoundation.h>
@implementation groupFeedImageCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblPost setPreferredMaxLayoutWidth:250];
}

-(void)layoutSubviews
{
    
    CGRect newCellSubViewsFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGRect newCellViewFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    self.contentView.frame = self.contentView.bounds = self.backgroundView.frame = self.accessoryView.frame = newCellSubViewsFrame;
    self.frame = newCellViewFrame;
    
    [super layoutSubviews];
}
-(void)configureForCellWithCountry:(GroupFeedModal *)modal
{
    if (modal.MemberImage)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.MemberImage]];
        [self.imageUser sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imageUser.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    
    if (modal.media)
    {
        
        if (![modal.thumb isEqualToString:@""])
        {
             NSURL *URLImage=[NSURL URLWithString:modal.thumb];
            _btnPlay.hidden=NO;
          [  self.imagePosted sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
            
        }
        else
        {
            NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/400/400",ImagePath,modal.media]];
            _btnPlay.hidden=YES;
            [self.imagePosted sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        }
       
    }
    else
        self.imagePosted.image=[UIImage imageNamed:@"img_placeholder_group"];
    
    
    
    NSString *labelText = modal.title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    
    _lblPost.attributedText=attributedString;
    _lblUserName.text=modal.MemberName;
    _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments • %@ likes",modal.comment_count,modal.like_count];
    
    _lblTimeAdded.text=[[SharedClass SharedManager] GetTimePeriodLeft:modal];
    
}



- (IBAction)btnLikePressed:(id)sender {
    [_delegate btnLikePressedImage:_indexPath];
}

- (IBAction)btnCommentPressed:(id)sender {
    [_delegate btnCommentClickedImage:_indexPath];
}

- (IBAction)btnPlayVideo:(id)sender{
    [_delegate btnPlayVideoPressed:_indexPath];
}

@end
