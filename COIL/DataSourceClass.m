//
//  DataSourceClass.m
//  SeparateOutDataSource
//
//  Created by Aseem 9 on 17/09/15.
//  Copyright (c) 2015 Aseem 9. All rights reserved.
//

#import "DataSourceClass.h"

@interface DataSourceClass ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *Imageitems;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@end

@implementation DataSourceClass

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
         imageItems:(NSArray*)Imageitems
cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    id ImageItem=[self imageAtIndexPath:indexPath];
    _configureCellBlock(cell,item,ImageItem);
   
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 90;
//}

@end
