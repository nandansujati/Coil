//
//  DataSource2Cells.h
//  COIL
//
//  Created by Aseem 13 on 26/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Header.h"
@interface DataSource2Cells : NSObject<UITableViewDataSource>
typedef void (^TableViewConfigureBlock)(id cell, id item,id imageItems ,id indexPath);

- (id)initWithItems:(NSArray *)anItems
         imageItems:(NSArray*)Imageitems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewConfigureBlock)aConfigureCellBlock;



@end
