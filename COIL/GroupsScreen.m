//
//  GroupsScreen.m
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupsScreen.h"

@interface GroupsScreen ()
{
    RNBlurModalView *modalView;
}
@property MyGroupsDataSource *datasource;
@property(nonatomic,strong)GroupsMenu *GroupsMenu;
@property(nonatomic,strong)GroupsFeed *GroupsFeedController;

@end

@implementation GroupsScreen

-(void)viewDidLoad
{
     [super viewDidLoad];
    [self setupUI];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _datasource = [[MyGroupsDataSource alloc] init];
    }
    return self;
}
-(void)setupUI
{
    _labelNoData.hidden=YES;
    _collectionView.dataSource = _datasource;
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:255.0f/255.0f green:153.0/255.0f blue:120.0f/255.0f alpha:1.0f ]];
   // [[UITabBar appearance]setDelegate:self];
    [[SharedClass SharedManager]Loader:self.view];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [modalView hide];
}


-(void)loadParameters
{
    _DictParameters=@{@"access_token":_Access_Token};
}


-(void)loadData
{
    
    MyGroupsModal *modal=[[MyGroupsModal alloc]init];
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlMyGroups :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                Usersarray=[response_success valueForKey:@"groups"];
                _FinalGroupsArray = [modal ListmethodCall:Usersarray];
                if (_FinalGroupsArray.count>0) {
                    _labelNoData.hidden=YES;
                    [self CallDataSource];
                }
                else
                    _labelNoData.hidden=NO;
            }
            
        }
            :^(NSError *response_error) {
                                
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
           [[SharedClass SharedManager]removeLoader];
                    }];
    }
    
}

-(void)CallDataSource
{
    CollectionViewCellConfigureBlock configureCell = ^(CollectionGroups *cell,id item)
    {
        
        [cell configureForCellWithCountry:item ];
    };
    
    CollectionViewCellDelegateConfigureBlock configureDelegateCell=^(id item)
    {
        
        [self CallGroupDetail:item];
        
    };
    
    self.datasource = [[MyGroupsDataSource alloc] initWithItems:_FinalGroupsArray
                                              cellIdentifier:CellIdentifierMyGroups
                                          configureCellBlock:configureCell configureDelegateBlock:configureDelegateCell];
    self.collectionView.dataSource = _datasource;
    self.collectionView.delegate= _datasource;
    [self.collectionView reloadData];
    

}


-(void)CallGroupDetail:(MyGroupsModal*)modal
{
    NSLog(@"%@", modal.name);
    NSLog(@"%@",modal.GroupId);
    _GroupsFeedController=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupsFeedController"];
    _GroupsFeedController.Group_Id=modal.GroupId;
    //[self.navigationController pushViewController:_GroupsFeedController animated:YES];
    [self.navigationController radialPushViewController:_GroupsFeedController withDuration:0.3 comlititionBlock:^{
        
    }];
    

}
//-(void)PushNewGroupVC
//{
//    [modalView hide];
//    [self performSegueWithIdentifier:@"NewGroupVC" sender:self];
//}
//
//-(void)btnViewHide
//{
//    [modalView hide];
//    
//}


- (IBAction)btnGroupsMenu:(id)sender
{
//    BOOL useCustomView = YES;
//    if (useCustomView)
//    {
//        _GroupsMenu = (GroupsMenu *)[[[NSBundle mainBundle] loadNibNamed:@"GroupsMenu" owner:self options:nil] objectAtIndex:0];
//        _GroupsMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-_GroupsMenu.frame.size.width-16, 16, _GroupsMenu.frame.size.width, _GroupsMenu.frame.size.height);
//        _GroupsMenu.layer.cornerRadius = 3.f;
//        _GroupsMenu.layer.borderColor = [UIColor clearColor].CGColor;
//        _GroupsMenu.layer.borderWidth = 3.f;
//        modalView = [[RNBlurModalView alloc] initWithViewController:self view:_GroupsMenu];
//        [_GroupsMenu.btnNewGroup addTarget:self action:@selector(PushNewGroupVC) forControlEvents:UIControlEventTouchUpInside];
//    }
//    [modalView show];
    
    [self performSegueWithIdentifier:@"NewGroupVC" sender:self];
}

- (IBAction)btnBroadcast:(id)sender
{
  [self performSegueWithIdentifier:@"NewBroadcast" sender:self];
}


@end
