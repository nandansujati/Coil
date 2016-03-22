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
    _ArrayItems=[NSArray arrayWithObjects:@"Group Details",@"Invite People",@"Take Attendance", nil];
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
    
    
}

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [_delegate groupDetailsPressed];
    }

   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 43;
}



@end
