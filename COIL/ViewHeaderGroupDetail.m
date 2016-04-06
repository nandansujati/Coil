//
//  ViewHeaderGroupDetail.m
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewHeaderGroupDetail.h"
#define CellidentifierFilesCell @"FilesCollection"
@interface ViewHeaderGroupDetail()

@end
@implementation ViewHeaderGroupDetail




-(void)awakeFromNib
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_imageGroup.frame.size.height);
    
    // Add colors to layer
    UIColor *centerColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:0.25];
    UIColor *endColor = [UIColor grayColor];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[endColor CGColor],
                       nil];
    
    [self.imageGroup.layer insertSublayer:gradient atIndex:0];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_imageGroup addGestureRecognizer:gesture];
   // gesture.delegate = self;
    self.imageGroup.userInteractionEnabled=YES;
    self.imageGroup.clipsToBounds = YES;
     UINib *nib = [UINib nibWithNibName:@"FilesCollection" bundle: nil];
    [self.collectionViewFiles registerNib:nib  forCellWithReuseIdentifier:CellidentifierFilesCell];

//     _collectionViewFiles.dataSource = _datasource;
//
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    
//    if (self)
//    {
//        _datasource = [[MyGroupsDataSource alloc] init];
//    }
//    return self;
//}

-(void)setFilesData :(NSArray *)FilesArray
{
    _filesArray=FilesArray;
    
    if (!(FilesArray.count==0) )
    {
//        CollectionViewCellConfigureBlock configureCell = ^(FilesCollection *cell,id item)
//        {
//            
//            [cell configureForCellWithCountry:item ];
//        };
        
        //        CollectionViewCellDelegateConfigureBlock configureDelegateCell=^(id item)
        //        {
        //
        //            [self CallGroupDetail:item];
        //
        //        };
        
        
//        self.datasource = [[MyGroupsDataSource alloc] initWithItems:FilesArray
//                                                            cellIdentifier:CellidentifierFilesCell
//                                                        configureCellBlock:configureCell configureDelegateBlock:nil];
//        self.collectionViewFiles.dataSource =  _datasource;
        //        self.collectionView.delegate= _datasource;
        [self.collectionViewFiles reloadData];
    }
    else
        self.collectionViewFiles.hidden=YES;
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _filesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FilesCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellidentifierFilesCell forIndexPath:indexPath];
    cell.layer.cornerRadius=5.0f;
 //   id item = [self itemAtIndexPath:indexPath];
    GroupDetailsModal *modal=[_filesArray objectAtIndex:indexPath.row];
    [cell configureForCellWithCountry:modal ];
//    _configureCellBlock(_cell,item);
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    id item = [self itemAtIndexPath:indexPath];
//    _configureCellDelegateBlock(item);
}


-(void)handleTap:(UITapGestureRecognizer*)gesure
{
    [_delegate imagePressed];
}
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ViewHeaderGroupDetail" owner:self options:nil] lastObject];
        [self setFrame:frame];
    }
    return self;
}

- (IBAction)btnBack:(id)sender;
{
    [_delegate btnBackPressed];
}

- (IBAction)btnEdit:(id)sender
{
    [_delegate btnEditPressed];
    
}

- (IBAction)btnAddPeople:(id)sender {
    [_delegate btnAddPeoplePressed];
}

- (IBAction)btnDiscoverabilty:(id)sender {
    [_delegate btnDiscoverablitypPressed];
}
- (IBAction)btnNotifications:(id)sender {
    [_delegate btnNotificationsPressed];
}
@end
