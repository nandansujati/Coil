//
//  DataSourceClass.h
//  SeparateOutDataSource
//
//  Created by Aseem 9 on 17/09/15.
//  Copyright (c) 2015 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface DataSourceClass : NSObject<UITableViewDataSource>

typedef void (^TableViewCellConfigureBlock)(id cell, id item,id imageItems ,id indexPath);

- (id)initWithItems:(NSArray *)anItems
         imageItems:(NSArray*)Imageitems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;





@end
