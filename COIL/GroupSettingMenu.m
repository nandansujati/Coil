//
//  GroupSettingMenu.m
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupSettingMenu.h"
#define CellIdentifierGroupsSettingsMenu @"GroupsSettingsMenuCell"
@implementation GroupSettingMenu

-(void)getName :(NSString*)Name andId :(NSString*)Id
{
    _memberId=[Id integerValue];
    _MemberName=[Name capitalizedString];
    NSString *IstObject;
    self.tableView.dataSource = self.datasource;
    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:@"AccessToken"];
    NSString *userId=[dict valueForKey:@"user_Id"];
    if ([userId integerValue]==_memberId) {
        IstObject=@"View My Profile";
         _ArrayItems=[NSArray arrayWithObjects:IstObject, nil];
    }
    else
    {
        IstObject=[NSString stringWithFormat:@"View %@'s Profile",_MemberName];
        NSString *ThirdObject=[NSString stringWithFormat:@"Remove %@",_MemberName];
        _ArrayItems=[NSArray arrayWithObjects:IstObject,@"Make Group Admin",ThirdObject, nil];

    }
       [self setData];
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

-(void)setData
{
    TableViewCellConfigureBlock configureCell = ^(GroupSettingsCell *cell,id item,id imageItems)
    {
        
        [cell configureForCellWithCountry:item];
    };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GroupSettingsCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifierGroupsSettingsMenu];
    
    
    
    self.datasource = [[DataSourceClass alloc] initWithItems:_ArrayItems
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierGroupsSettingsMenu
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    AppDelegate *appDelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window setUserInteractionEnabled:YES];
    
    
}

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [_delegate ViewUserProfile];
    }
    else if (indexPath.row==1)
    {
        [_delegate makeGroupAdminPressed];
    }
    else if (indexPath.row==2)
    {
        [_delegate removeMember];
    }

   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 43;
}



@end
