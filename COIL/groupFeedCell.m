//
//  groupFeedCell.m
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "groupFeedCell.h"

@implementation groupFeedCell

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
    [_delegate btnLikePressed:_indexPath];
}

- (IBAction)btnCommentPressed:(id)sender
{
    [_delegate btnCommentClicked:_indexPath];
}
@end
