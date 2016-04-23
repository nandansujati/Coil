//
//  GroupsFeed.m
//  COIL
//
//  Created by Aseem 9 on 21/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupsFeed.h"

#define CellIdentifierGroupFeedCell @"GroupFeedCell"
#define CellIdentifierGroupFeedImageCell @"GroupFeedImageCell"
@interface GroupsFeed ()<BtnFeedCellPressed,UIViewControllerAnimatedTransitioning,GroupsFeedReload,floatMenuDelegate,settingGroupChanged,BtnFeedImageCellPressed,CommentPostedDelegate>
{
    NSIndexPath *currentIndexpath;
     NSIndexPath *IndexpathUpdate;
}

@property(nonatomic,strong)ImageView *imageView;

@property(nonatomic,strong)YPBubbleTransition * transition;
@property DataSourceClass *datasource;
@property (nonatomic, strong) CYViewControllerTransitioningDelegate *viewControllerTransitionDelegate;
@property (nonatomic, strong) CYNavigationControllerDelegate *navDelegate;

@property(nonatomic,strong)GroupDetailVC *groupDetailsVC;
@property(nonatomic,strong)CalenderVC *calVC;
@property(nonatomic,strong)groupFeedCell *cell;
@property(nonatomic,strong)groupFeedImageCell *cellImage;

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


- (YPBubbleTransition *)transition
{
    if (!_transition) {
    _transition = [[YPBubbleTransition alloc] init];
    }
    return _transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transition.transitionMode = YPBubbleTransitionModePresent;
    self.transition.startPoint = self.btnAddPost.center;
     self.transition.bubbleColor = [UIColor colorWithRed:255.0/255.0f green:153.0/255.0f blue:120.0/255.0f alpha:1.0f];
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.transitionMode = YPBubbleTransitionModeDismiss;
    self.transition.startPoint = self.btnAddPost.center;
    self.transition.bubbleColor = [UIColor colorWithRed:255.0/255.0f green:153.0/255.0f blue:120.0/255.0f alpha:1.0f];
    return self.transition;
}


-(void)loadParameters
{
    _dictParameters=@{@"access_token":_accessToken,@"group_id":_Group_Id,@"page":@"0"};
}


-(void)setUp
{
    
    
    self.viewControllerTransitionDelegate = [CYViewControllerTransitioningDelegate new];
    self.navDelegate = [CYNavigationControllerDelegate new];
    
    _lblNoPosts.hidden=YES;
    _values = [[NSMutableArray alloc]init];
    _finalFeedArray=[[NSMutableArray alloc]init];
    self.tableView.estimatedRowHeight=200;
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
            
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                
                NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                Usersarray=[response_success valueForKey:@"feed"];
                _finalFeedArray = [modal ListmethodCall:Usersarray];
                _groupName.text=[[response_success valueForKey:@"group"]valueForKey:@"name"];
                if (Usersarray.count==0) {
                    _lblNoPosts.hidden=NO;
                    _tableView.hidden=YES;
                }
                [[SharedClass SharedManager]removeLoader];
                [self CallDataSource];
                

            }
            else
            {
                [[SharedClass SharedManager]removeLoader];
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :[response_success valueForKey:@"msg"] :@"OK"];
            }
            
        }
                            :^(NSError *response_error) {
                                [[SharedClass SharedManager]removeLoader];
                                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                [self.view endEditing:YES];
                            }];
    }
    else
    {
        [[SharedClass SharedManager]removeLoader];
    }
    
}



-(void)CallDataSource
{
    if (!(_finalFeedArray.count==0) )
    {
        _tableView.hidden=NO;
        _lblNoPosts.hidden=YES;
        [self.tableView reloadData];
    }
    else
    {
        _lblNoPosts.hidden=NO;
        _tableView.hidden=YES;
    }
    
}

-(void)ReloadFeeds
{
    [self loadData];
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
    
    _cellImage = (groupFeedImageCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifierGroupFeedImageCell];
    
    if (_cellImage == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"groupFeedImageCell" owner:self options:nil];
        _cellImage = [nib objectAtIndex:0];
        
    }

      GroupFeedModal *modal=[_finalFeedArray objectAtIndex:indexPath.row];
    
    for (int i = 0; i<[_finalFeedArray count]; i++)
    {
        [_values addObject:@"NO"];
    }
    
      if ([modal.media isEqualToString:@""]) {
          [self configureFeedCell:cell:modal :indexPath];
          
        return cell;

    }
    else
    {
        [self configureFeedImageCell :_cellImage: modal :indexPath];
                return _cellImage;

    }
}



-(void)configureFeedCell:(groupFeedCell*)FeedCell :(GroupFeedModal*)modal :(NSIndexPath*)indexPath
{
    [FeedCell configureForCellWithCountry:modal];
    FeedCell.delegate=self;
    FeedCell.indexPath=indexPath;
   
    
    if([[_values objectAtIndex:indexPath.row]isEqualToString:@"NO"])
    {
        [FeedCell.btnLike setSelected:NO];
    }
    else
    {
        [FeedCell.btnLike setSelected:YES];
    }
    
    
    
    NSInteger IsFavourite=[modal.is_liked intValue];
    
    if (IsFavourite ==1)
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"YES"];
        [FeedCell.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
        [FeedCell.btnLike setSelected:YES];
    }
    else
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"NO"];
        [FeedCell.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
        [FeedCell.btnLike setSelected:NO];
    }

}

-(void)configureFeedImageCell:(groupFeedImageCell*)FeedCell :(GroupFeedModal*)modal :(NSIndexPath*)indexPath
{
    [_cellImage configureForCellWithCountry:modal];
    _cellImage.delegate=self;
    _cellImage.indexPath=indexPath;
    
   
    
    if([[_values objectAtIndex:indexPath.row]isEqualToString:@"NO"])
    {
        [_cellImage.btnLike setSelected:NO];
    }
    else
    {
        [_cellImage.btnLike setSelected:YES];
    }
    
    
    
    NSInteger IsFavourite=[modal.is_liked intValue];
    
    if (IsFavourite ==1)
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"YES"];
        [_cellImage.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
        [_cellImage.btnLike setSelected:YES];
    }
    else
    {
        [_values replaceObjectAtIndex:indexPath.row withObject:@"NO"];
        [_cellImage.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
        [_cellImage.btnLike setSelected:NO];
    }
    

}
- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentV
{
    
}
- (IBAction)btn3Dots:(id)sender
{
    [self groupDetailsPressed];


}

-(void)groupDetailsPressed
{
    _groupDetailsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupDetailVC"];
    _groupDetailsVC.Group_Id=self.Group_Id;
    _groupDetailsVC.delegate=self;
    [self.navigationController pushViewController:_groupDetailsVC animated:YES];
  
}

-(void)groupNmaeChanged:(NSString *)groupName
{
    _groupName.text=groupName;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}



-(void)btnPlayVideoPressed:(NSIndexPath *)indexPath
{
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
    //    NSString *postId=modal.postId;
    NSURL  *ImageFromFile=[NSURL URLWithString:[NSString stringWithFormat:@"%@",modal.thumb]];

    NSString *fileURL = [NSString stringWithFormat:@"%@",modal.media];

    
    [self imageTapped:ImageFromFile :YES :fileURL];


}


-(void)ImagePressed:(NSIndexPath *)indexPath
{
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
    NSURL  *ImageFromFile=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/400/400",ImagePath,modal.media]];
    [self imageTapped:ImageFromFile :NO:nil];
}


-(void)imageTapped:(NSURL*)ImageFromFile :(BOOL)isVideoAvailable :(NSString *)VideoUrl
{
    
    _imageView = (ImageView *)[[[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self options:nil] objectAtIndex:0];
    _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_imageView getImage:ImageFromFile :isVideoAvailable :VideoUrl];
    [self.view addSubview:_imageView];
    
}
-(void)btnCommentClicked:(NSIndexPath *)indexPath
{
    cell = (groupFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];

    currentIndexpath=indexPath;
    CommentsVC *commentsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsVC"];
    commentsVC.FeedModal=modal;
    commentsVC.delegate=self;
//    [self.navigationController pushViewController:commentsVC animated:YES];
//    [self.navigationController radialPushViewController:commentsVC withDuration:0.3 comlititionBlock:^{
//        
//    }];
   
        commentsVC.modalPresentationStyle = UIModalPresentationCustom;
        self.viewControllerTransitionDelegate.viewController = commentsVC;
    
        [self presentPortalTransitionViewController:commentsVC completion:nil];
    
    
    


    
}


-(void)btnCommentClickedImage:(NSIndexPath *)indexPath
{
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
   
    currentIndexpath=indexPath;
    CommentsVC *commentsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsVC"];
    commentsVC.FeedModal=modal;
     commentsVC.delegate=self;
//    [self.navigationController radialPushViewController:commentsVC withDuration:0.3 comlititionBlock:^{
//        
//    }];
    //[self.navigationController pushViewController:commentsVC animated:YES];
    
    commentsVC.modalPresentationStyle = UIModalPresentationCustom;
    self.viewControllerTransitionDelegate.viewController = commentsVC;
    
    [self presentPortalTransitionViewController:commentsVC completion:nil];
}



-(void)btnLikePressed :(NSIndexPath*)indexPath
{
    cell = (groupFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
   NSString *postId=modal.postId;
    currentIndexpath=indexPath;
  NSDictionary * DictMarklist=@{@"access_token" :_accessToken, @"post_id": postId };
    
    if([cell.btnLike isSelected])
    {
        [self UnLikePost :DictMarklist];
    }
    
    else if (![cell.btnLike isSelected])
    {
        [self likePost:DictMarklist ];
    }

}

-(void)btnLikePressedImage :(NSIndexPath*)indexPath
{
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:indexPath.row];
    NSString *postId=modal.postId;
    currentIndexpath=indexPath;
    NSDictionary * DictMarklist=@{@"access_token" :_accessToken, @"post_id": postId };
    
    if([_cellImage.btnLike isSelected])
    {
        [self UnLikePostImage :DictMarklist];
    }
    
    else if (![_cellImage.btnLike isSelected])
    {
        [self likePostImage :DictMarklist ];
    }
    
}


-(void)UnLikePost :(NSDictionary*)DictMarklist
{
    [_values replaceObjectAtIndex:currentIndexpath.row withObject:@"NO"];
    [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
    [cell.btnLike setSelected:NO];
    [self UnlikeApi:DictMarklist ];
    
}

-(void)likePost :(NSDictionary*)DictMarklist
{
    [_values replaceObjectAtIndex:currentIndexpath.row withObject:@"YES"];
    [cell.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
    [cell.btnLike setSelected:YES];
    [self likeApi:DictMarklist ];
    
    
}

-(void)UnLikePostImage :(NSDictionary*)DictMarklist
{
    [_values replaceObjectAtIndex:currentIndexpath.row withObject:@"NO"];
    [_cellImage.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
    [_cellImage.btnLike setSelected:NO];
    [self UnlikeApi:DictMarklist ];
    
}

-(void)likePostImage :(NSDictionary*)DictMarklist
{
    [_values replaceObjectAtIndex:currentIndexpath.row withObject:@"YES"];
    [_cellImage.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
    [_cellImage.btnLike setSelected:YES];
    [self likeApi:DictMarklist ];
    
    
}


-(void)UnlikeApi :(NSDictionary*)DictMarklist
{
    [iOSRequest postData:UrlUnlikePost :DictMarklist :^(NSDictionary *response_success)
     {
         [self updateModal:NO ];
     }
                        :^(NSError *response_error)
     {
         
         [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
         NSLog(@"%@",response_error.localizedDescription);
         [self.view endEditing:YES];
     }];

}


-(void)likeApi:(NSDictionary*)DictMarklist
{
    [iOSRequest postData:UrlLikePost :DictMarklist :^(NSDictionary *response_success)
     {
         [self updateModal :YES];
     }
                        :^(NSError *response_error)
     {
         [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
         NSLog(@"%@",response_error);
         [self.view endEditing:YES];
     }];

}



-(void)updateModal :(BOOL)Liked
{
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:currentIndexpath.row];
    NSInteger likeCount=[modal.like_count intValue];
    
    NSInteger Value=[modal.is_liked intValue];
    if (Value==1)
        Value=0;
    else
        Value=1;
    
    if (Liked==YES) {
         likeCount+=1;
    }
   else
   {
        likeCount-=1;
   }
    
    NSString *ValueChanged=[NSString stringWithFormat:@"%li",(long)Value];
    NSString *ValueLikeCount=[NSString stringWithFormat:@"%li",(long)likeCount];
    modal.like_count=ValueLikeCount;
    modal.is_liked=ValueChanged;
    [_finalFeedArray replaceObjectAtIndex:currentIndexpath.row withObject:modal];
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:currentIndexpath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)likeClicked :(BOOL)liked
{
    if (liked==YES) {
        [self updateModal :YES];
    }
    else
        [self updateModal:NO];
    
}

-(void)commentPosted
{
    GroupFeedModal * modal = [_finalFeedArray objectAtIndex:currentIndexpath.row];
    
   
    NSInteger commentCount=[modal.comment_count intValue];
    
    commentCount+=1;
    
   
    NSString *ValuecommentCount=[NSString stringWithFormat:@"%li",(long)commentCount];
   
    modal.comment_count=ValuecommentCount;
    
    [_finalFeedArray replaceObjectAtIndex:currentIndexpath.row withObject:modal];
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:currentIndexpath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
- (IBAction)btnCalendar:(id)sender {
    _calVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CalenderVC"];
   
    _calVC.modalPresentationStyle = UIModalPresentationCustom;
    self.viewControllerTransitionDelegate.viewController = _calVC;
    
    [self presentPortalTransitionViewController:_calVC completion:nil];

}

- (IBAction)btnBack:(id)sender
{
//    [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController radialPopViewControllerWithDuration:0.5 comlititionBlock:^{
    
        }];
}

- (IBAction)btnAddPost:(id)sender
{
    [self performSegueWithIdentifier:@"NewPostVC" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewPostVC"])
    {
        NewPostVC *vc = segue.destinationViewController;
        vc.transitioningDelegate = self;
        vc.delegate=self;
        vc.group_Id=self.Group_Id;
        vc.modalPresentationStyle = UIModalPresentationCustom;

    }
    
    
    
   }
@end
