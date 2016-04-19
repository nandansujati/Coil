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
-(void)awakeFromNib
{
    
    self.tableView.dataSource = self.datasource;
    _ArrayItems=[NSArray arrayWithObjects:@"View Tiffany's Profile",@"Make Group Admin",@"Remove Tiffany", nil];
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
