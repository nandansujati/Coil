//
//  SelectGroupsBroadcast.m
//  COIL
//
//  Created by Aseem 9 on 31/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SelectGroupsBroadcast.h"
#define CellIdentifierAddPeople @"AddPeopleCell"
@interface SelectGroupsBroadcast ()<bntClicked>
@property(nonatomic,strong)AddPeopleCell *Addcell;
@property(nonatomic,strong)MyGroupsModal *modal;
@property DataSourceClass *datasource;
@end

@implementation SelectGroupsBroadcast

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
      // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUI
{
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
    _values = [[NSMutableArray alloc]init];
    _ArrayGroupIds=[[NSMutableArray alloc]init];
     _ArrayAllStrings=[[NSMutableArray alloc]init];
    _FinalGroupsArray=[[NSMutableArray alloc]init];
    
    [self loadData];
}


-(void)loadParameters
{
     _DictParameters=@{@"access_token":_Access_Token};
}
-(void)loadData
{
    
    _modal=[[MyGroupsModal alloc]init];
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlMyGroups :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                Usersarray=[response_success valueForKey:@"groups"];
                _FinalGroupsArray = [_modal ListmethodCall:Usersarray];
                _NewFinalArray=_FinalGroupsArray;
                for (_modal in _FinalGroupsArray) {
                    [_ArrayAllStrings addObject:_modal.name];
                }
                [self.tableView reloadData];

               
            }
            
        }
                            :^(NSError *response_error) {
                                
                                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                [[SharedClass SharedManager]removeLoader];
                            }];
    }
    
}

#pragma  mark- TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _FinalGroupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _Addcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierAddPeople];
    if (_Addcell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddPeopleCell" owner:self options:nil];
        _Addcell = [nib objectAtIndex:0];
        
    }
    
    _modal=[_FinalGroupsArray objectAtIndex:indexPath.row];
    for (int i = 0; i<[_FinalGroupsArray count]; i++)
    {
        [_values addObject:@"NO"];
    }
    
        _Addcell.btnInvite.hidden=YES;

    
    _Addcell.indexPath = indexPath;
    _Addcell.delegate = self;
    
    if([[_values objectAtIndex:indexPath.row]isEqualToString:@"NO"])
    {
        [_Addcell.btnCheckbox setSelected:NO];
    }
    else
    {
        [_Addcell.btnCheckbox setSelected:YES];
    }
    
    [_Addcell configureForCellWithModal:_modal];
    
    
    
    return _Addcell;
}


#pragma mark- TextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *array= [self SearchResults:newString];
    _FinalGroupsArray =[[NSMutableArray alloc]init];
    [_FinalGroupsArray addObjectsFromArray:array];
    [_tableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(NSMutableArray*)SearchResults:(NSString*)SearchString
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",SearchString];
    NSArray *results = [_ArrayAllStrings filteredArrayUsingPredicate:predicate];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    if (results.count>0) {
        for (NSString *str in results)
        {
            for (MyGroupsModal *data in _NewFinalArray)
            {
                if ([str isEqualToString:data.name])
                {
                    [array addObject:data];
                }
            }
            
        }
    }
    else
        [array addObjectsFromArray:_NewFinalArray];
    
    
    
    
    return array;
}

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

#pragma mark- Delegate Methods
-(void)BtnCheckboxClicked:(NSIndexPath *)indexpath
{
    _Addcell = (AddPeopleCell*)[self.tableView cellForRowAtIndexPath:indexpath];
    _modal = [_FinalGroupsArray objectAtIndex:indexpath.row];
    if([_Addcell.btnCheckbox isSelected])
    {
        [_values replaceObjectAtIndex:indexpath.row withObject:@"NO"];
        [_Addcell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_inactive"] forState:UIControlStateSelected];
        [_Addcell.btnCheckbox setSelected:NO];
       // [_ArrayUserEmails removeObject:[_modal.Email firstObject]];
        [_ArrayGroupIds removeObject:_modal.GroupId];
        
    }
    
    else if (![_Addcell.btnCheckbox isSelected])
    {
        [_values replaceObjectAtIndex:indexpath.row withObject:@"YES"];
        [_Addcell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_active"] forState:UIControlStateSelected];
        [_Addcell.btnCheckbox setSelected:YES];
       // [_ArrayUserEmails addObject:[_Modal.Email firstObject]];
        [_ArrayGroupIds addObject:_modal.GroupId];
        
        
    }
    
    
    // [self CheckSelected];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPost:(id)sender {
    [self loadDataForPost];
}

-(void)loadParametersForPost
{
    NSString *StringGroupIds=[_ArrayGroupIds componentsJoinedByString:@","];
    _DictParametersForPost= @{@"access_token":_Access_Token,@"group_id":StringGroupIds,@"post_type":@"1", @"title":_TextViewPost};
}


-(void)loadDataForPost
{
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParametersForPost];
        
        if (_VideoData==NO)
        {
            [iOSRequest postMutliPartData:UrlCreatePost :@"image" :_DictParametersForPost :_dataMedia :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                   // [_delegate ReloadFeeds];
                   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
                }
                
            } :^(NSError *response_error)
             {
                 [[SharedClass SharedManager]removeLoader];
                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                 [self.view endEditing:YES];
             }];
        }
        else
        {
            [iOSRequest postMutliPartVideoData:UrlCreatePost :@"video" :_DictParametersForPost :_dataMedia :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                   // [_delegate ReloadFeeds];
                   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
                    //[self dismissViewControllerAnimated:YES completion:nil];
                }
                
            } :^(NSError *response_error)
             {
                 [[SharedClass SharedManager]removeLoader];
                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                 [self.view endEditing:YES];
             }];
        }
        
    }
    else
    {
        [[SharedClass SharedManager]removeLoader];
    }
    
}




@end
