//
//  MyGroupsDataSource.h
//  COIL
//
//  Created by Aseem 9 on 18/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyGroupsDataSource : NSObject<UICollectionViewDataSource,UICollectionViewDelegate>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item );
typedef void (^CollectionViewCellDelegateConfigureBlock)(id item );

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
configureDelegateBlock:(CollectionViewCellDelegateConfigureBlock)aConfigureCellDelegateBlock;


@end
