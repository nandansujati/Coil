//
//  ViewCanvasIntegration.h
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol btnPressedfromCanvasView
@optional
-(void)btnCrossPressed;
-(void)btnSyncPressed :(NSString *)CourseIds;
@end
@interface ViewCanvasIntegration : UIView
@property(nonatomic,strong)id<btnPressedfromCanvasView>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCanvas;
@property(nonatomic,strong)NSArray *GroupsArray;
@property(nonatomic,strong)NSArray *CourseIdsSelected;
- (IBAction)btnCross:(id)sender;
-(void)getCourse_Ids:(NSArray *)course_Ids;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property(nonatomic,strong)NSMutableArray *CourseIds;
- (IBAction)btnSync:(id)sender;
@end
