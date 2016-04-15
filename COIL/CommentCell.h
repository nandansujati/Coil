//
//  CommentCell.h
//  COIL
//
//  Created by Taran on 07/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsModal.h"
#import "Header.h"

@interface CommentCell : UITableViewCell
{
    // NSString *month;
    NSInteger minutes;
    NSInteger hour;
    NSInteger day;
    NSInteger seconds;
    NSString *Time;
    NSString *Date;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *lblcomment;
@property (weak, nonatomic) IBOutlet UILabel *lblCreated_at;
-(void)configureForCellWithCountry:(CommentsModal *)modal;
@end
