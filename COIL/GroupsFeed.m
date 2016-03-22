//
//  GroupsFeed.m
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupsFeed.h"
#define CellIdentifierGroupFeedCell @"GroupFeedCell"
@interface GroupsFeed ()<menuPressed,BtnFeedCellPressed>
{
    RNBlurModalView *modalView;
}
@property DataSourceClass *datasource;
@property(nonatomic,strong)GroupSettingMenu *GroupsMenu;
@property(nonatomic,strong)GroupDetailVC *groupDetailsVC;
@property(nonatomic,strong)groupFeedCell *cell;
@end

@implementation GroupsFeed
@synthesize cell;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [modalView hide];
}

-(void)loadParameters
{
    _dictParameters=@{@"access_token":_accessToken,@"group_id":_Group_Id,@"page":@"0"};
}


-(void)setUp
{
    _values = [[NSMutableArray alloc]init];
    _finalFeedArray=[[NSMutableArray alloc]init];
    self.tableView.estimatedRowHeight=123;
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _accessToken=[Dictionary valueForKey:@"access_token"];
     [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    [self loadData];
}

-(void)loadData
{
    GroupFeedModal *modal=[[GroupFeedModal alloc]init];
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        
        [iOSRequest postData:UrlGroupFeed :_dictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                
                NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                Usersarray=[response_success valueForKey:@"feed"];
                _finalFeedArray = [modal ListmethodCall:Usersarray];
                _groupName.text=[[response_success valueForKey:@"group"]valueForKey:@"name"];
                [[SharedClass SharedManager]removeLoader];
                [self CallDataSource];
                
                //[_collectionView reloadData];
            }
            else
                [[SharedClass SharedManager]removeLoader];
            
        }
                            :^(NSError *response_error) {
                                [[SharedClass SharedManager]removeLoader];
                                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                [[SharedClass SharedManager]removeLoader];
                            }];
    }
    else
    {
        [[SharedClass SharedManager]removeLoader];
    }
    
}



-(void)CallDataSource
{
//    TableViewCellConfigureBlock configureCell = ^(groupFeedCell *cell,id item,id imageItems)
//    {
//        cell.indexPath
//        cell.delegate=self;
//        [cell configureForCellWithCountry:item];
//    };
//    
//    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([groupFeedCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifierGroupFeedCell];
//    
//    
//    
//    self.datasource = [[DataSourceClass alloc] initWithItems:_finalFeedArray
//                                                  imageItems:nil
//                                              cellIdentifier:CellIdentifierGroupFeedCell
//                                          configureCellBlock:configureCell];
//    self.tableView.dataSource = _datasource;
//    [self.tableView reloadData];
    
    
    
    
    if (!(_finalFeedArray.count==0) )
    {
        _tableView.hidden=NO;
        [self.tableView reloadData];
    }
    else
        _tableView.hidden=YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _finalFeedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (groupFeedCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifierGroupFeedCell];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"groupFeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
//    id item = [self itemAtIndexPath:indexPath];
//    id ImageItem=[self imageAtIndexPath:indexPath];
      GroupFeedModal *modal=[_finalFeedArray objectAtIndex:indexPath.row];
     [cell configureForCellWithCountry:modal];
    cell.delegate=self;
    cell.indexPath=indexPath;
    
    for (int i = 0; i<[_finalFeedArray count]; i++)
    {
        [_values addObject:@"NO"];
    }
    
    if([[_values objectAtIndex:indexPath.row]isEqualToString:@"NO"])
    {
        [cell.btnLike setSelected:NO];
    }
    else
    {
        [cell.btnLike setSelected:YES];
    }
    
    
    
    NSInteger IsFavourite=[modal.is_liked intValue];
    
    if (IsFavourite ==1)
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"YES"];
        [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
        [cell.btnLike setSelected:YES];
    }
    else
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"NO"];
        [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
        [cell.btnLike setSelected:NO];
    }
    
    return cell;
}


- (IBAction)btn3Dots:(id)sender
{
    BOOL useCustomView = YES;
        if (useCustomView)
        {
            _GroupsMenu = (GroupSettingMenu *)[[[NSBundle mainBundle] loadNibNamed:@"GroupSettingMenu" owner:self options:nil] objectAtIndex:0];
            _GroupsMenu.frame = CGRectMake(20, self.view.frame.size.height/2-_GroupsMenu.frame.size.height/2, self.view.frame.size.width-40, _GroupsMenu.frame.size.height);
            _GroupsMenu.layer.cornerRadius = 3.f;
            _GroupsMenu.layer.borderColor = [UIColor clearColor].CGColor;
            _GroupsMenu.layer.borderWidth = 3.f;
            _GroupsMenu.delegate=self;
            modalView = [[RNBlurModalView alloc] initWithViewController:self view:_GroupsMenu];
        }
        [modalView show];

}

-(void)groupDetailsPressed
{
    _groupDetailsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupDetailVC"];
    _groupDetailsVC.Group_Id=self.Group_Id;
    [self.navigationController pushViewController:_groupDetailsVC animated:YES];
    [modalView hide];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedheightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 123;
}

-(void)btnLikePressed :(NSIndexPath*)indexPath
{
    cell = (groupFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
   NSString *postId=modal.postId;
  NSDictionary * DictMarklist=@{@"access_token" :_accessToken, @"post_id": postId };
    
    if([cell.btnLike isSelected])
    {
        [self UnLikePost :DictMarklist:indexPath];
    }
    
    else if (![cell.btnLike isSelected])
    {
        [self likePost:DictMarklist :indexPath];
    }

}




-(void)UnLikePost :(NSDictionary*)DictMarklist :(NSIndexPath*)indexPath
{
    [_values replaceObjectAtIndex:indexPath.row withObject:@"NO"];
    [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
    [cell.btnLike setSelected:NO];
    
    [iOSRequest postData:UrlUnlikePost :DictMarklist :^(NSDictionary *response_success)
     {
         GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
         
         NSInteger Value=[modal.is_liked intValue];
         NSInteger likeCount=[modal.like_count intValue];
         
         if (Value==1)
             Value=0;
         else
             Value=1;
         
         likeCount-=1;
         
         NSString *ValueChanged=[NSString stringWithFormat:@"%li",(long)Value];
          NSString *ValueLikeCount=[NSString stringWithFormat:@"%li",(long)likeCount];
         modal.is_liked=ValueChanged;
         modal.like_count=ValueLikeCount;
         
         [_finalFeedArray replaceObjectAtIndex:indexPath.row withObject:modal];
         
         [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
     }
                        :^(NSError *response_error)
     {
         
         [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
         NSLog(@"%@",response_error.localizedDescription);
     }];

}

-(void)likePost :(NSDictionary*)DictMarklist :(NSIndexPath*)indexPath
{
    [_values replaceObjectAtIndex:indexPath.row withObject:@"YES"];
    [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
    [cell.btnLike setSelected:YES];
    
    
    [iOSRequest postData:UrlLikePost :DictMarklist :^(NSDictionary *response_success)
     {
         GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
         NSInteger likeCount=[modal.like_count intValue];
         
         
        
         NSInteger Value=[modal.is_liked intValue];
         if (Value==1)
             Value=0;
         else
             Value=1;
         
         likeCount+=1;
         NSString *ValueChanged=[NSString stringWithFormat:@"%li",(long)Value];
         NSString *ValueLikeCount=[NSString stringWithFormat:@"%li",(long)likeCount];
        modal.like_count=ValueLikeCount;
         modal.is_liked=ValueChanged;
         [_finalFeedArray replaceObjectAtIndex:indexPath.row withObject:modal];
         
         [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
     }
                :^(NSError *response_error)
     {
        [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
         NSLog(@"%@",response_error);
     }];

}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
