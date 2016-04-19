//
//  SearchUserExplore.m
//  COIL
//
//  Created by Aseem 9 on 13/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SearchUserExplore.h"
#define CellIdentifierUserExploreCell @"UsersExploreCell"
@interface SearchUserExplore ()<PushFromSearchDelegate>
{
    RNBlurModalView *modalView;
}
@property(nonatomic,strong)ViewSearch *ViewSearch;
@property(nonatomic,strong)ViewSearch *ViewSearchExplore;
@end

@implementation SearchUserExplore

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)viewWillAppear:(BOOL)animated
{
    [self setupUI];
    _txtFieldSearch.text=@"";
     [_ViewSearchExplore GetGroupsAndUsers:@""];
}
#pragma mark- Call From ViewDidload
-(void)setupUI
{
    _tableView.hidden=YES;
    [self CallSearchView];
    _txtFieldSearch.delegate=self;
    [_txtFieldSearch setValue:[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:119.0/255.0 alpha:1.0f]
                 forKeyPath:@"_placeholderLabel.textColor"];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma  mark- TextField Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _tableView.hidden=YES;
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length>0)
    {
        if (!removedView==NO) {
           [self CallSearchView];
            removedView=NO;
        }
            [_ViewSearchExplore GetGroupsAndUsers:newString];
    }
    else
        [_ViewSearchExplore GetGroupsAndUsers:@""];
        return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark- AddSearchView
-(void)CallSearchView
{
    _ViewSearchExplore = (ViewSearch *)[[[NSBundle mainBundle] loadNibNamed:@"ViewSearch" owner:self options:nil] objectAtIndex:0];
    _ViewSearchExplore.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, 60, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-110);
    _ViewSearchExplore.delegate=self;
    [self.view addSubview:_ViewSearchExplore];
}

#pragma mark- Delegate Methods
-(void)PushFromUserSearch :(NSInteger)IndexPathRow :(NSArray*)UsersArray
{
    if (IndexPathRow==3)
    {
//        [_ViewSearchExplore removeFromSuperview];
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[ViewSearch class]]) {
                [view removeFromSuperview];
            }
           
        }
        
         removedView=YES;
         _UserArray=UsersArray;
        [self setData];

    }
}



-(void)PushFromGroupSearch:(NSString *)GroupId
{
   GroupsFeed *GroupsFeedController=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupsFeedController"];
    GroupsFeedController.Group_Id=GroupId;
    [self.navigationController radialPushViewController:GroupsFeedController withDuration:0.3 comlititionBlock:^{
    
        }];

}
-(void)setData
{
    TableViewCellConfigureBlock configureCell = ^(UserExploreCell *cell,id item,id imageItems)
    {
        [cell configureForCellWithCountry:item];
    };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserExploreCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifierUserExploreCell];
    
    
    
    self.datasource = [[DataSourceClass alloc] initWithItems:_UserArray
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierUserExploreCell
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    
    if (!(_UserArray.count==0) )
    {
        _tableView.hidden=NO;
    }
    else
        _tableView.hidden=YES;

    
}

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    SearchModal *modal=[_UserArray objectAtIndex:indexPath.row];
    UserProfileVC *userVC=[self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    userVC.User_Id=modal.Group_Id;
    userVC.OtherUserProfile=YES;
    [modalView hide];
    [self.navigationController pushViewController:userVC animated:YES];

}



- (IBAction)btnCross:(id)sender {
    _tableView.hidden=YES;
    _txtFieldSearch.text=@"";
//    [_ViewSearchExplore removeFromSuperview];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[ViewSearch class]]) {
            [view removeFromSuperview];
        }
        
    }
    removedView=YES;
    [self.view endEditing:YES];
}
@end
