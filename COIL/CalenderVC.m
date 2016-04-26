//
//  CalenderVC.m
//  COIL
//
//  Created by Aseem 13 on 22/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CalenderVC.h"
#define CellIdentifierEvents @"CellEvents"
@interface CalenderVC()<btnPressedfromCanvasView,btnClickedFromEvents>
{
    NSMutableDictionary *_eventsByDate;
    RNBlurModalView *modalView;
     NSDate *_dateSelected;
}
@property DataSourceClass *datasource;
@property(nonatomic,strong)ViewCanvasIntegration *ViewCanvas;
@end
@implementation CalenderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblGroupName.text=_groupName;
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    _calendarManager.settings.pageViewHaveWeekDaysView = NO;
    _calendarManager.settings.pageViewNumberOfWeeks = 0; // Automatic
    
    _weekDayView.manager = _calendarManager;
    [_weekDayView reload];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    [self setDateOnLabel:[NSDate date]];
    _dateSelected=[NSDate date];
    [self GetEvents];
    
   
    _calendarMenuView.scrollView.scrollEnabled = NO; // Scroll not supported with JTVerticalCalendarView
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.datasource = [[DataSourceClass alloc] init];
    }
    return self;
}


-(void)loadParameters
{
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    
    _DictParameters=@{@"access_token":[Dictionary valueForKey:@"access_token"],@"group_id":_GroupId,@"course_id":_UpdatedCourses};
    
}
#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Hide if from another month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:214.0f/255.0f green:83.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}


-(void)setDateOnLabel :(NSDate*)date
{
    NSString *strDate= [[self dateFormatter] stringFromDate:date];;
    NSArray *arrayDate=[strDate componentsSeparatedByString:@"-"];
    
    NSString *Month=[[SharedClass SharedManager] getFullMonth:[arrayDate objectAtIndex:1]];
    _lblDateSelected.text=[NSString stringWithFormat:@"%@ %@, %@",Month,[arrayDate objectAtIndex:0],[arrayDate objectAtIndex:2]];
    
}
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    [self setDateOnLabel:_dateSelected];
    _KeyClicked = [[self dateFormatter] stringFromDate:_dateSelected];
   BOOL value= [self containsKey:_KeyClicked];
    _ArrayDateEvents=[[NSArray alloc]init];
    if (value==YES) {
        _ArrayDateEvents=[_eventsByDate valueForKey:_KeyClicked];
        
    }
    [self setEvents];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)setEventsOnCalender
{
    _eventsByDate = [NSMutableDictionary new];
    
    for (CanvasEventsModal *modal in _ArrayEvents) {
       
        NSDate *randomDate = [self convertDate:modal.EventStartAt];


        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:modal];
    }
    
    
    [_calendarManager reload];
}

- (BOOL)containsKey: (NSString *)key {
    BOOL retVal = 0;
    NSArray *allKeys = [_eventsByDate allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}


-(NSDate*)convertDate:(NSString *)strDate
{
   // NSString *dateString = strDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    NSDate *date = [formatter dateFromString:strDate];
    NSLog(@"date = %@", date);
    return date;
}
-(void)showView
{
    _ViewCanvas = (ViewCanvasIntegration *)[[[NSBundle mainBundle] loadNibNamed:@"ViewCanvasIntegration" owner:self options:nil] objectAtIndex:0];
    _ViewCanvas.frame = CGRectMake(20, self.view.frame.size.height/2-_ViewCanvas.frame.size.height/2, self.view.frame.size.width-40, _ViewCanvas.frame.size.height);
    _ViewCanvas.layer.cornerRadius = 10.f;
    _ViewCanvas.layer.borderColor = [UIColor clearColor].CGColor;
    _ViewCanvas.layer.borderWidth = 3.f;
    _ViewCanvas.delegate=self;
    NSArray *array=[_SelectedCourses componentsSeparatedByString:@","];
    [_ViewCanvas getCourse_Ids:array];
    //    currentIndexPath=indexPath;
    modalView = [[RNBlurModalView alloc] initWithViewController:self view:_ViewCanvas];
    [modalView show];
}
-(void)btnCrossPressed
{
    [modalView hide];
 
}

-(void)btnSyncPressed:(NSString *)CourseIds
{
    [modalView hide];
    if (CourseIds !=nil && CourseIds.length!=0) {
        
        [self GetEvents];
     
    }
    _UpdatedCourses=CourseIds;
    [self updateCourseIds];
}

-(void)updateCourseIds
{
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
         [self loadParameters];
        [iOSRequest getData:UrlUpdateCourseIds :_DictParameters :^(NSArray *response_success) {
           

        }  :^(NSError *response_error) {
           
        }];
    }

}


-(void)GetEvents
{
    CanvasEventsModal *modal=[[CanvasEventsModal alloc]init];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
       // [self loadParameters];
        [iOSRequest getData:UrlGetCalenderEvents :nil :^(NSArray *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSMutableArray *array=[[NSMutableArray alloc]init];
            [array addObjectsFromArray:response_success];
            _ArrayEvents = [modal ListmethodCall:array ];
            [self setEventsOnCalender];
            
            _KeyClicked = [[self dateFormatter] stringFromDate:_dateSelected];
            BOOL value= [self containsKey:_KeyClicked];
            _ArrayDateEvents=[[NSArray alloc]init];
            if (value==YES) {
                _ArrayDateEvents=[_eventsByDate valueForKey:_KeyClicked];
                
            }
            [self setEvents];
        }  :^(NSError *response_error) {
            
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
            [[SharedClass SharedManager]removeLoader];
        }];
    }

}
-(void)setEvents
{
    TableViewCellConfigureBlock configureCell = ^(EventsCell *cell,id item,id imageItems,NSIndexPath *indexPath)
    {
        cell.btnReminder.selected=YES;
        cell.delegate=self;
        cell.indexPath=indexPath;
        [cell configureCellWithModal:item];
    };
    
    
    
    
    self.datasource = [[DataSourceClass alloc] initWithItems:_ArrayDateEvents
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierEvents
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    
    
}
-(void)btnReminderClicked:(NSIndexPath *)indexPath
{
     EventsCell *cell = (EventsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if([cell.btnReminder isSelected])
    {
        cell.btnReminder.selected=NO;
    }
    
    else if (![cell.btnReminder isSelected])
    {
        cell.btnReminder.selected=YES;
    }

}

- (IBAction)btnBack:(id)sender {
//    [self.navigationController popFromBottom];
//    [self.navigationController popViewControllerAnimated:YES];
      [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnSync:(id)sender {
    [self showView];
}
@end
