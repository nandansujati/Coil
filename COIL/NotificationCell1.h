//
//  NotificationCell1.h
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "NotificationsModal.h"
@interface NotificationCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageUser;
@property (weak, nonatomic) IBOutlet UILabel *lblNotificationText;
@property (weak, nonatomic) IBOutlet UILabel *lblPost;
@property (weak, nonatomic) IBOutlet UILabel *lblPostedAt;
-(void)configureCell:(NotificationsModal*)modal;
@end
