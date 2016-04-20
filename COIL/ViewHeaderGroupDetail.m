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
@property(nonatomic,strong)ImageView *imageView;
@end
@implementation ViewHeaderGroupDetail


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ViewHeaderGroupDetail" owner:self options:nil] lastObject];
        [self setFrame:frame];
    }
    return self;
}

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


-(void)setFilesData :(NSArray *)FilesArray
{
    _filesArray=FilesArray;
    
    if (!(FilesArray.count==0) )
    {
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

    GroupDetailsModal *modal=[_filesArray objectAtIndex:indexPath.row];
    [cell configureForCellWithCountry:modal ];

    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailsModal *modal=[_filesArray objectAtIndex:indexPath.row];
    NSString *videoUrl;
    if (![modal.fileThumb isEqualToString:@""])
    {

        _ImageFromFile=[NSURL URLWithString:modal.fileThumb];
        videoUrl=modal.fileMedia;
        VideoIsDere=YES;
    }
    else
    {
        _ImageFromFile=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/400/400",ImagePath,modal.fileMedia]];
        VideoIsDere=NO;
        
    }
    
    [self imageTapped :videoUrl];
}


-(void)imageTapped :(NSString *)videoUrl
{
    
    _imageView = (ImageView *)[[[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self options:nil] objectAtIndex:0];
    _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_imageView getImage:_ImageFromFile :VideoIsDere :videoUrl];
    [self addSubview:_imageView];
    
}

-(void)handleTap:(UITapGestureRecognizer*)gesure
{
    [_delegate imagePressed];
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
