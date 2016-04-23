//
//  GroupsMenu.m
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupsMenu.h"
#define CellIdentifierGroupsMenu @"GroupsMenuCell"
@implementation GroupsMenu

-(void)awakeFromNib
{
     self.tableView.dataSource = self.datasource;
    _ArrayItems=[NSArray arrayWithObjects:@"File",@"Image",@"Video",@"Text", nil];
    _ArrayImageItems=[NSArray arrayWithObjects:@"ic_file",@"ic_picture",@"ic_video",@"ic_text",nil];
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
    TableViewCellConfigureBlock configureCell = ^(GroupsMenuCell *cell,id item,id imageItems,NSIndexPath *indexPath)
    {
        
        [cell configureForCellWithCountry:item :imageItems];
    };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GroupsMenuCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifierGroupsMenu];
    

        
        self.datasource = [[DataSourceClass alloc] initWithItems:_ArrayItems
                           imageItems:_ArrayImageItems
                                                  cellIdentifier:CellIdentifierGroupsMenu
                                              configureCellBlock:configureCell];
        self.tableView.dataSource = _datasource;
        [self.tableView reloadData];
        
    
}


@end
