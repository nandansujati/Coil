//
//  CalenderVC.h
//  COIL
//
//  Created by Aseem 13 on 22/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
#import "Header.h"
@interface CalenderVC : UIViewController<JTCalendarDelegate>
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarWeekDayView *weekDayView;
@property (weak, nonatomic) IBOutlet JTVerticalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet UILabel *lblDateSelected;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSString *KeyClicked;
@property(nonatomic,strong) NSArray *ArrayEvents;
@property(nonatomic,strong)NSArray *ArrayDateEvents;
@property(nonatomic,strong)NSString *groupName;
- (IBAction)btnSync:(id)sender;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
- (IBAction)btnBack:(id)sender;

@end
