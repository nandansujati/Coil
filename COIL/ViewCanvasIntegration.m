//
//  ViewCanvasIntegration.m
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewCanvasIntegration.h"
#define CellIdentifierCanvasCell  @"CanvasGroupCell"

@interface ViewCanvasIntegration()<btnCheckboxClickedfromCanvas>

@end
@implementation ViewCanvasIntegration

-(void)awakeFromNib
{
     _viewContainer.layer.cornerRadius =10.0f;
     _CourseIds=[[NSMutableArray alloc]init];
    
}
//-(void)loadUpdateParameters
//{
//    _DictParameters=@{@"access_token":_Access_Token,@"group_id":_Group_Id,@"name":_labelGroupName,@"privacy":[NSString stringWithFormat:@"%ld",(long)discoverabilityTag],@"notification":[NSString stringWithFormat:@"%ld",(long)notificationTag]};
//    
//}

-(void)getCourse_Ids:(NSArray *)course_Ids
{
    _CourseIdsSelected=course_Ids;
    NSLog(@"%@",_CourseIdsSelected);
     [self loadData];
}
-(void)loadData
{
    CanvasGroupsModal *modal=[[CanvasGroupsModal alloc]init];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        //[self loadParameters];
        [iOSRequest getData:UrlGetCanvasCourses :nil :^(NSArray *response_success) {
            [[SharedClass SharedManager]removeLoader];

            NSMutableArray *array=[[NSMutableArray alloc]init];
            [array addObjectsFromArray:response_success];
                _GroupsArray = [modal ListmethodCall:array ];
                [self.tableViewCanvas reloadData];
              

            
        }  :^(NSError *response_error) {
                                
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                [[SharedClass SharedManager]removeLoader];
            }];
    }
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _GroupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CanvasGroupsCell *cell = (CanvasGroupsCell*)[self.tableViewCanvas dequeueReusableCellWithIdentifier:CellIdentifierCanvasCell];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CanvasGroupsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    CanvasGroupsModal *modal=[_GroupsArray objectAtIndex:indexPath.row];
    [cell configureCellWithModal:modal];
    if ([_CourseIdsSelected containsObject:[NSString stringWithFormat:@"%@",modal.CourseId]]) {
        [cell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_active"] forState:UIControlStateSelected];
        [cell.btnCheckbox setSelected:YES];
        [_CourseIds addObject:modal.CourseId];
    }
    cell.delegate=self;
    cell.indexPath=indexPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}

- (IBAction)btnCross:(id)sender {
    [_delegate btnCrossPressed];
}

-(void)checkBoxClicked:(NSIndexPath *)indexPath
{
     CanvasGroupsModal *modal=[_GroupsArray objectAtIndex:indexPath.row];
    CanvasGroupsCell *cell = (CanvasGroupsCell*)[self.tableViewCanvas cellForRowAtIndexPath:indexPath];

    if([cell.btnCheckbox isSelected])
    {
      
        [cell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_inactive"] forState:UIControlStateSelected];
        [cell.btnCheckbox setSelected:NO];
        [_CourseIds removeObject:modal.CourseId];
        
    }
    
    else if (![cell.btnCheckbox isSelected])
    {

        [cell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_active"] forState:UIControlStateSelected];
        [cell.btnCheckbox setSelected:YES];
        [_CourseIds addObject:modal.CourseId];
        
        
    }

}
- (IBAction)btnSync:(id)sender
{
    NSString *str=[_CourseIds componentsJoinedByString:@","];
    [_delegate btnSyncPressed :str];
}
@end
