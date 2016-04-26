//
//  NotificationCell2.h
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "NotificationsModal.h"
@interface NotificationCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageUser;
@property (weak, nonatomic) IBOutlet UILabel *lblNotificationTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblPost;

-(void)configureCell:(NotificationsModal*)modal;
- (IBAction)btnConfirm:(id)sender;
- (IBAction)btnReject:(id)sender;
@end
