//
//  UserProfileVC.m
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "UserProfileVC.h"
#define CellIdentifierGroupCell @"GroupFeedCell"
#define CellIdentifierGroupImageCell @"GroupFeedImageCell"
@interface UserProfileVC ()<BtnFeedCellPressed,BtnFeedImageCellPressed,CommentPostedDelegate,ButtonPressedFromProfileHeader>
{
    NSIndexPath *currentIndexpath;
}
@property(nonatomic,strong)ImageView *imageView;

@property(nonatomic,strong)AppDelegate *appDelegate;
@property(nonatomic,strong)groupFeedCell *cell;
@property(nonatomic,strong)groupFeedImageCell *cellImage;
@property(nonatomic,strong)ViewProfileHeader *HeaderView;
@property (nonatomic, strong) CYViewControllerTransitioningDelegate *viewControllerTransitionDelegate;


@end

@implementation UserProfileVC
@synthesize cell;
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.view setUserInteractionEnabled:NO];
    [self setupUI];
}
-(void)viewWillDisappear :(BOOL)animated
{
//    [[SharedClass SharedManager]removeLoader];
//    [self.view setUserInteractionEnabled:YES];
}

-(void)setupUI
{
    
    _FeedsArray=[[NSMutableArray alloc]init];
    self.viewControllerTransitionDelegate = [CYViewControllerTransitioningDelegate new];
 
    _DictHeaderDetails=[[NSMutableDictionary alloc]init];
    _ProfileArray=[[NSMutableArray alloc]init];
    _values = [[NSMutableArray alloc]init];
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
    if (_OtherUserProfile==NO) {
        _User_Id=[Dictionary valueForKey:@"user_Id"];
    }
   
    
    [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    [self loadData];
    self.tableView.estimatedRowHeight=200;
}


-(void)loadParameters
{
    _DictParameters=@{@"access_token":_Access_Token,@"other_id":_User_Id};
    
}
-(void)loadData
{
    UserProfileModal *modal=[[UserProfileModal alloc]init];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlGetUserProfile :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            [self.view setUserInteractionEnabled:YES];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                
                
                _ProfileArray = [modal ListmethodCall:response_success];
                [self viewSetUp];
                
                
            }
            else
                [[SharedClass SharedManager]removeLoader];
            
        }
                            :^(NSError *response_error) {
                                
                                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                [[SharedClass SharedManager]removeLoader];
                                [self.view setUserInteractionEnabled:YES];
                            }];
    }
    
}
-(void)viewSetUp
{
    for (UserProfileModal *modal in _ProfileArray)
    {
            [self getActiveMembersCount :modal];
            [self getDescription:modal];

            [self setMemberTable:modal];

        
        
        
    }
    
}


-(void)getActiveMembersCount:(UserProfileModal*)modal
{
   // NSArray *MemberArray=modal.MembersArray;
    
    NSInteger ActiveMemberCount=[modal.mutual_group_count integerValue];
    NSString *MutualGroups;

    if (ActiveMemberCount ==1) {
        MutualGroups=[NSString stringWithFormat:@"%ld Groups",(long)ActiveMemberCount];
    }
    else
        MutualGroups=[NSString stringWithFormat:@"%ld Groups",(long)ActiveMemberCount];
    
    
    [_DictHeaderDetails setValue:MutualGroups forKey:@"MutualGroups"];
}


-(void)getDescription:(UserProfileModal*)modal
{
    NSString *userName=modal.userName;
    NSString *urlImage;
    NSString *userBiography=modal.userBiography;
    if (modal.userImage.length>0) {
        urlImage = [NSString stringWithFormat:@"%@%@/300/%f",ImagePath,modal.userImage,self.view.frame.size.width];
    }
    
     [_DictHeaderDetails setValue:userName forKey:@"userName"];
    [_DictHeaderDetails setValue:urlImage forKey:@"userImage"];
    [_DictHeaderDetails setValue:userBiography forKey:@"userBiography"];
    [self setHeaderView];
}

-(void)setHeaderView
{
    _HeaderView = [[ViewProfileHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 374)];
    _HeaderView.delegate=self;
    _HeaderView.lblUserName.text=[[_DictHeaderDetails valueForKey:@"userName"]capitalizedString];
    NSArray *arrayUserName=[[[_DictHeaderDetails valueForKey:@"userName"]capitalizedString] componentsSeparatedByString:@" "];
    NSString *FirstName=[arrayUserName objectAtIndex:0];
    if (_OtherUserProfile==NO)
    {
        _HeaderView.lblHeaderName.text=@"My Profile";
        _HeaderView.btnBack.hidden=YES;
    }
    else
    {
        _HeaderView.lblHeaderName.text=FirstName;
        _HeaderView.btnBack.hidden=NO;
    }
    
    
    _HeaderView.lblMutualGroups.text=[_DictHeaderDetails valueForKey:@"MutualGroups"];
    _HeaderView.lblBiography.text=[_DictHeaderDetails valueForKey:@"userBiography"];
     [self setUserImage];
    self.tableView.tableHeaderView = _HeaderView;
}

-(void)btnBackPressed
{
    if (_OtherUserProfile==YES) {
           [self.navigationController popViewControllerAnimated:YES];
    }
 
}
-(void)setUserImage
{
    NSString *_UrlImage=[_DictHeaderDetails valueForKey:@"userImage"];
    UIImage *image;
    if (_UrlImage.length>0)
    {
        
        NSURL *Url=[NSURL URLWithString:_UrlImage];
        NSData *fileData = [NSData dataWithContentsOfURL:Url];
        image=[UIImage imageWithData:fileData];
        [_HeaderView.UserImage sd_setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
       
        
    }
    else
    {
        
        [_HeaderView.UserImage setImage:[UIImage imageNamed:@"img_placeholder_group"]];
        image=[UIImage imageNamed:@"img_placeholder_group"];
        
    }
    _HeaderView.UserImage.layer.cornerRadius=15.0;
    _HeaderView.UserImage.layer.borderWidth=2.0;
    _HeaderView.UserImage.layer.borderColor=[UIColor whiteColor].CGColor;
    _HeaderView.UserImage.layer.masksToBounds=YES;
    UIImage *images=[self imageWithView:image];
    [_HeaderView.ImageBackground setImage:images];
    
    
    
    
}

- (UIImage *) imageWithView:(UIImage *)imageOrig
{
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    CIImage *inputImage = [CIImage imageWithCGImage:[imageOrig CGImage]];
    [gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@10 forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
    UIImage *image       = [UIImage imageWithCGImage:cgimg];
   // CGImageRelease(cgimg);
    return image;
}

-(void)setMemberTable:(UserProfileModal*)modal
{
    [_FeedsArray addObjectsFromArray: modal.userPosts];
    [self  setMemberData];
}


-(void)setMemberData
{
    self.tableView.dataSource = self;
    
    
    if (!(_FeedsArray.count==0) )
    {
        _tableView.hidden=NO;
        [self.tableView reloadData];
    }
//    else
//        _tableView.hidden=YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _FeedsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (groupFeedCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifierGroupCell];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"groupFeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    _cellImage = (groupFeedImageCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifierGroupImageCell];
    
    if (_cellImage == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"groupFeedImageCell" owner:self options:nil];
        _cellImage = [nib objectAtIndex:0];
        
    }
    
    UserProfileModal *modal=[_FeedsArray objectAtIndex:indexPath.row];
    for (int i = 0; i<[_FeedsArray count]; i++)
    {
        [_values addObject:@"NO"];
    }
    
    if ([modal.PostMedia isEqualToString:@""]) {
        [self configureFeedCell:cell:modal :indexPath];
        
        return cell;
        
    }
    else
    {
        [self configureFeedImageCell :_cellImage: modal :indexPath];
        return _cellImage;
        
    }
}



-(void)configureFeedCell:(groupFeedCell*)FeedCell :(UserProfileModal*)modal :(NSIndexPath*)indexPath
{
    [FeedCell configureForCellWithUser:modal];
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
    
    
    
    NSInteger IsFavourite=[modal.PostIsLiked intValue];
    
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

-(void)configureFeedImageCell:(groupFeedImageCell*)FeedCell :(UserProfileModal*)modal :(NSIndexPath*)indexPath
{
    [_cellImage configureForCellWithUserModal:modal];
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
    
    
    
    NSInteger IsFavourite=[modal.PostIsLiked intValue];
    
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

-(void)btnPlayVideoPressed:(NSIndexPath *)indexPath
{
    
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
  
    NSString *fileURL = [NSString stringWithFormat:@"%@",modal.PostMedia];
    NSURL  *ImageFromFile=[NSURL URLWithString:[NSString stringWithFormat:@"%@",modal.PostThumb]];
    
    [self imageTapped:ImageFromFile :YES :fileURL];
    
    
}

-(void)ImagePressed:(NSIndexPath *)indexPath
{
    _cellImage = (groupFeedImageCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
    NSURL  *ImageFromFile=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/400/400",ImagePath,modal.PostMedia]];
   [self imageTapped:ImageFromFile :NO:nil];
}

-(void)imageTapped:(NSURL*)ImageFromFile :(BOOL)isVideoAvailable :(NSString *)VideoUrl
{
    
    _imageView = (ImageView *)[[[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self options:nil] objectAtIndex:0];
    _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
   [_imageView getImage:ImageFromFile :isVideoAvailable :VideoUrl];
    [self.tabBarController.view addSubview:_imageView];
    
}

-(void)btnCommentClicked:(NSIndexPath *)indexPath
{
    cell = (groupFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
    
    currentIndexpath=indexPath;
    CommentsVC *commentsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsVC"];
    commentsVC.ProfileModal=modal;
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
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
    
    currentIndexpath=indexPath;
    CommentsVC *commentsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsVC"];
    commentsVC.ProfileModal=modal;
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
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
    NSString *postId=modal.PostId;
    currentIndexpath=indexPath;
    NSDictionary * DictMarklist=@{@"access_token" :_Access_Token, @"post_id": postId };
    
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
    UserProfileModal * modal = [_FeedsArray objectAtIndex:indexPath.row];
    NSString *postId=modal.PostId;
    currentIndexpath=indexPath;
    NSDictionary * DictMarklist=@{@"access_token" :_Access_Token, @"post_id": postId };
    
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
    UserProfileModal * modal = [_FeedsArray objectAtIndex:currentIndexpath.row];
    NSInteger likeCount=[modal.PostLikeCount intValue];
    
    NSInteger Value=[modal.PostIsLiked intValue];
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
    modal.PostLikeCount=ValueLikeCount;
    modal.PostIsLiked=ValueChanged;
    [_FeedsArray replaceObjectAtIndex:currentIndexpath.row withObject:modal];
    
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
    UserProfileModal * modal = [_FeedsArray objectAtIndex:currentIndexpath.row];
    
    
    NSInteger commentCount=[modal.PostCommentCount intValue];
    
    commentCount+=1;
    
    
    NSString *ValuecommentCount=[NSString stringWithFormat:@"%li",(long)commentCount];
    
    modal.PostCommentCount=ValuecommentCount;
    
    [_FeedsArray replaceObjectAtIndex:currentIndexpath.row withObject:modal];
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:currentIndexpath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}
@end
