//
//  ViewSearch.m
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewSearch.h"
#define CellIdentifierGroupsItems @"GroupsItemsCell"
#define CellIdentifierUsersItems @"UsersItemsCell"
@interface ViewSearch()


@property SearchUserExplore *SearchExplorre;
@property (nonatomic,strong)NSArray* SplittedGroupArray;
@property (nonatomic,strong)NSArray* SplittedUserArray;

@end
@implementation ViewSearch

-(void)awakeFromNib
{
    [self setupUI];
}



-(void)setupUI
{
    _tableView.hidden=YES;

    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    
    _Access_token=[Dictionary valueForKey:@"access_token"];
    _HeadersList=[NSArray arrayWithObjects:@"Groups",@"People", nil];
   
}

#pragma mark- Api Methods


-(void)GetGroupsAndUsers:(NSString*)newString
{
    if (!newString.length>0) {
        _tableView.hidden=YES;
    }
    else
    {
        _ArrayAllGroups=[[NSMutableArray alloc]init];
        SearchModal *modal=[[SearchModal alloc]init];
        
        NSInteger NetworkValue=[[SharedClass SharedManager]NetworkCheck];
        if (NetworkValue==0)
        {
            _DictParameters=@{@"access_token":_Access_token,@"keyword":newString};
            
            [iOSRequest postData:UrlSearch :_DictParameters :^(NSDictionary *response_success) {
                
                NSInteger successValue=[[response_success valueForKey:@"success"]integerValue];
                if (successValue==1)
                {
                    NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                    Usersarray=[[response_success valueForKey:@"users"]valueForKey:@"data"];
                    _FinalUserArray = [modal ListmethodCall:Usersarray];
                    
                    NSMutableArray *Grouparray=[[NSMutableArray alloc]init];
                    Grouparray=[[response_success valueForKey:@"groups"]valueForKey:@"data"];
                    _FinalGroupArray = [modal ListmethodCall:Grouparray];
                    
                    [self getSplittedArray];
                    [_tableView reloadData];
                    
                    
                    
                }
                
                
            }
                                :^(NSError *response_error)
             {
//                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                 
             }];
        }

    }
   
    
 
}





#pragma mark - UITableViewDataSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, tableView.frame.size.width, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    NSString *string =[_HeadersList objectAtIndex:section];
    [label setText:string];
    [label setTextColor:[UIColor lightGrayColor]];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:(33.0f/255.0f) green:(33.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f]];

    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_FinalGroupArray.count>0 &&_FinalUserArray.count>0) {
        return 40.0f;
    }
    else if (_FinalUserArray.count>0 && _FinalGroupArray.count==0) {
        if (section==0) {
            return 0.0f;
        }
        else
            return 40.0f;
    }
    else if (_FinalGroupArray.count>0 && _FinalUserArray.count==0) {
        if (section==0) {
            return 40.0f;
        }
        else
            return 0.0f;
    }
    else
        return 0.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return [_SplittedGroupArray count];
    } else if(section==1)
    {
        return [_SplittedUserArray count];
    }
    else
        return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setBackgroundColor:[UIColor colorWithRed:(38.0f/255.0f) green:(36.0f/255.0f) blue:(43.0f/255.0f) alpha:1.0f]];
    SearchGroupCell *groupCell= [tableView dequeueReusableCellWithIdentifier:CellIdentifierGroupsItems];
    if (groupCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchGroupCell" owner:self options:nil];
        groupCell = [nib objectAtIndex:0];
        
    }
    SearchUsersCell *userCell= [tableView dequeueReusableCellWithIdentifier:CellIdentifierUsersItems];
    if (userCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchUsersCell" owner:self options:nil];
        userCell = [nib objectAtIndex:0];
        
    }
    
    
    if (!(_FinalUserArray.count==0 &&_FinalGroupArray.count==0) )
    {
        _tableView.hidden=NO;
    }
    else
        _tableView.hidden=YES;

    if (indexPath.section==0)
    {
        
        [groupCell configureForCellWithName : [_SplittedGroupArray objectAtIndex:indexPath.row] :indexPath : _MoreGroupClicked];
        return groupCell;
    }
    else
    {
        [userCell configureForCellWithName:[_SplittedUserArray objectAtIndex:indexPath.row]:indexPath];
        return userCell;
    }

    
   

}

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _MoreGroupClicked=NO;
    [self endEditing:YES];
  if (indexPath.section==1)
    {

        if (indexPath.row==3)
        {
            [_delegate PushFromUserSearch:indexPath.row : _FinalUserArray];
        }
    }
    else if(indexPath.section==0)
    {
        if (indexPath.row==2)
        {
            _MoreGroupClicked=YES;
             [self getSplittedArray];
            
            [_tableView reloadData];
        }

    }
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 40;
}




-(void)getSplittedArray
{
    
    if (_MoreGroupClicked==NO)
        _SplittedGroupArray=[self SplitGroupSearchArray:_FinalGroupArray];
    
    else
    {
        _SplittedGroupArray=_ArrayAllGroups;
//        _MoreGroupClicked=NO;
    }
    
    _SplittedUserArray=[self SplitUserSearchArray:_FinalUserArray];
}


-(NSArray*)SplitUserSearchArray:(NSArray*)UsersArray
{
    _SplittedArray=[[NSMutableArray alloc]init];
    UserSearchCountMore=0;
    for (SearchModal *modal in UsersArray)
    {
        if (_SplittedArray.count<3)
        {
            [_SplittedArray addObject:modal.name];
        }
        if (![_SplittedArray containsObject:modal.name])
        {
            UserSearchCountMore++;
        }
       
    }
    if (UserSearchCountMore>0) {
        [_SplittedArray addObject:[NSString stringWithFormat:@"+ %lu more",(long)UserSearchCountMore]];
    }
    
    return _SplittedArray;
}


-(NSArray*)SplitGroupSearchArray:(NSArray*)GroupArray
{
    _SplittedArray=[[NSMutableArray alloc]init];
    UserSearchCountMore=0;
    for (SearchModal *modal in GroupArray)
    {
        if (_SplittedArray.count<2)
        {
            [_SplittedArray addObject:modal.name];
        }
        if (![_SplittedArray containsObject:modal.name])
        {
            UserSearchCountMore++;
           
        }
         [_ArrayAllGroups addObject:modal.name];
    }
    if (UserSearchCountMore>0) {
        [_SplittedArray addObject:[NSString stringWithFormat:@"+ %lu more",(long)UserSearchCountMore]];
    }
    
    return _SplittedArray;
}


@end
