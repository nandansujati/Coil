//
//  DataSource2Cells.m
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "DataSource2Cells.h"
@interface DataSource2Cells()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *Imageitems;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewConfigureBlock configureCellBlock;
@end

@implementation DataSource2Cells
- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
imageItems:(NSArray*)Imageitems
cellIdentifier:(NSString *)aCellIdentifier
configureCellBlock:(TableViewConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self)
    {
        self.items = anItems;
        self.Imageitems=Imageitems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
        
    }
    return self;
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return _items[indexPath.row];
}
- (id)imageAtIndexPath:(NSIndexPath *)indexPath
{
    return _Imageitems[indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self SwitchCellIdentifier:indexPath]
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    id ImageItem=[self imageAtIndexPath:indexPath];
    _configureCellBlock(cell,item,ImageItem ,indexPath);
    
    return cell;
}

-(NSString *)SwitchCellIdentifier:(NSIndexPath*)indexPath
{
    NotificationsModal *modal=[_items objectAtIndex:indexPath.row];
    
    if ([modal.NotificationType integerValue]==1) {
        self.cellIdentifier=CellIdentifierNotificationCell2;
    }
    else
    {
        self.cellIdentifier=CellIdentifierNotificationCell1;
    }
    return  _cellIdentifier;
}
@end
