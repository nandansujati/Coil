//
//  EventsCell.h
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "CanvasEventsModal.h"
@interface EventsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblEventTime;
@property (weak, nonatomic) IBOutlet UILabel *lblEventName;
-(void)configureCellWithModal:(CanvasEventsModal*)modal;
@end
