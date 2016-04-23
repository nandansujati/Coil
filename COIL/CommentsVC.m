//
//  CommentsVC.m
//  COIL
//
//  Created by Aseem 9 on 06/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CommentsVC.h"
#define CellIdentifierCommentsCell @"CommentsCell"
@interface CommentsVC ()
@property DataSourceClass *datasource;
@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
-(void)setupUI
{
    self.tableView.dataSource = self.datasource;
    previousRect = CGRectZero;
    _arrayComments=[[NSMutableArray alloc]init];
    [self registerForKeyboardNotifications];
    self.tableView.estimatedRowHeight=50;
    
    _imagePost.layer.cornerRadius=5.0f;
     _imagePost.layer.masksToBounds=YES;
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_token=[Dictionary valueForKey:@"access_token"];
    if (_ProfileModal==nil) {
        [self configurePost:_FeedModal];
    }
    else
        [self configurePostProfile:_ProfileModal];
        
    [self loadData];
}



-(void)loadParameters
{
    _DictParameters=@{@"access_token":_Access_token,@"post_id":_postId};
}


-(void)loadData
{
    CommentsModal *modal=[[CommentsModal alloc]init];
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlgetCommentsOnPost :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                NSMutableArray *Usersarray=[[NSMutableArray alloc]init];
                Usersarray=[response_success valueForKey:@"comments"];
                _arrayComments =[[NSMutableArray alloc]init];
                _arrayComments = [modal ListmethodCall:Usersarray];
                if (_arrayComments.count>0)
                {
                    [self CallDataSource];
                }

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
    
    
    TableViewCellConfigureBlock configureCell = ^(CommentCell *cell,id item,id imageItems,NSIndexPath *indexPath)
    {
        
        [cell configureForCellWithCountry:item];
    };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifierCommentsCell];
    
    
    
    self.datasource = [[DataSourceClass alloc] initWithItems:_arrayComments
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierCommentsCell
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}


- (void)registerForKeyboardNotifications

{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        _constraintBottomView.constant = keyboardSize.height ;
        
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height-216, 0);
//        [self.tableView setContentOffset: CGPointMake(0, keyboardSize.height) animated: NO];
    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    [UIView animateWithDuration:0.3 animations:^{
        _constraintBottomView.constant = 0;
    }];
    
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y)
    {
        if (_constraintBottomViewHeight.constant<90)
        {
            _constraintBottomViewHeight.constant=_constraintBottomViewHeight.constant+20;
            
            [self adjustFrames];
        }
    }
    else if (currentRect.origin.y < previousRect.origin.y && _constraintBottomViewHeight.constant>70)
    {
        _constraintBottomViewHeight.constant=_constraintBottomViewHeight.constant-20;
    }
    previousRect = currentRect;
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if (range.length == 0) {
        if ([text isEqualToString:@"\n"]) {
            textView.text = [NSString stringWithFormat:@"%@\n",textView.text];
            
            return NO;
        }
    }
    //self.txtViewComment.layer.borderWidth = 2;
    return YES;
    
}
-(void)adjustFrames
{
    CGRect textFrame = self.txtViewComment.frame;
    textFrame.size.height = self.txtViewComment.contentSize.height;
    self.txtViewComment.frame = textFrame;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Comment.."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Comment..";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(void)removeKeyboardObservers

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    
}

-(void)configurePost:(GroupFeedModal *)modal
{
    if (modal.MemberImage)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.MemberImage]];
        [self.imagePost sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imagePost.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    _postId=modal.postId;
    
    
    NSString *labelText = modal.title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    
    _lblPost.attributedText=attributedString;
    _lblUserName.text=modal.MemberName;
    _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments . %@ likes",modal.comment_count,modal.like_count];
    
    _lblTimeAdded.text=[[SharedClass SharedManager] GetTimePeriodLeft:modal];
    
    
    NSInteger IsFavourite=[modal.is_liked intValue];
    
    if (IsFavourite ==1)
    {
        
        [self.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
        [self.btnLike setSelected:YES];
    }
    else
    {
        
        [self.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
        [self.btnLike setSelected:NO];
    }

}



-(void)configurePostProfile:(UserProfileModal *)modal
{
    if (modal.PostImage)
    {
        NSURL *URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/40/40",ImagePath,modal.PostImage]];
        [self.imagePost sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_user"]];
    }
    else
        self.imagePost.image=[UIImage imageNamed:@"img_placeholder_user"];
    
    _postId=modal.PostId;
    
    
    NSString *labelText = modal.PostTitle;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    
    _lblPost.attributedText=attributedString;
    _lblUserName.text=modal.PostName;
    _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments . %@ likes",modal.PostCommentCount,modal.PostLikeCount];
    
    _lblTimeAdded.text=[[SharedClass SharedManager] GetTimePeriodLeftFromUser:modal];
    
    
    NSInteger IsFavourite=[modal.PostIsLiked intValue];
    
    if (IsFavourite ==1)
    {
        
        [self.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
        [self.btnLike setSelected:YES];
    }
    else
    {
        
        [self.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
        [self.btnLike setSelected:NO];
    }

}

-(void)SendCommentApi
{
    NSDictionary *DictComment=@{@"access_token":_Access_token,@"post_id":_postId,@"comment":_txtViewComment.text};
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
            [self loadParameters];
            [iOSRequest postData:UrlCommentOnPost :DictComment :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
             NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                [_delegate commentPosted];
                [self updateModal];
                [self loadData];
            }
            
        }
                            :^(NSError *response_error) {
                                
                                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                [[SharedClass SharedManager]removeLoader];
                            }];
    }

}

- (IBAction)btnLikePressed:(id)sender
{
    NSString *postId;
    if (_ProfileModal==nil) {
         postId=_FeedModal.postId;
    }
   else
       postId=_ProfileModal.PostId;
    
    NSDictionary * DictMarklist=@{@"access_token" :_Access_token, @"post_id": postId };
    
    if([self.btnLike isSelected])
    {
        [self UnLikePost :DictMarklist];
    }
    
    else if (![self.btnLike isSelected])
    {
        [self likePost:DictMarklist ];
    }

}


-(void)UnLikePost :(NSDictionary*)DictMarklist
{
   
    [self.btnLike setImage:[UIImage imageNamed:@"ic_like_inactive"] forState:UIControlStateSelected];
    [self.btnLike setSelected:NO];
    [self UnlikeApi:DictMarklist ];
    
}

-(void)likePost :(NSDictionary*)DictMarklist
{
   
    [self.btnLike setImage:[UIImage imageNamed:@"ic_like_active"] forState:UIControlStateSelected];
    [self.btnLike setSelected:YES];
    [self likeApi:DictMarklist ];
    
    
}
-(void)UnlikeApi :(NSDictionary*)DictMarklist
{
    [iOSRequest postData:UrlUnlikePost :DictMarklist :^(NSDictionary *response_success)
     {
           [_delegate likeClicked :NO];
         [self updateModal];
       

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
         [_delegate likeClicked:YES];
         [self updateModal];
         

     }
            :^(NSError *response_error)
     {
         [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
         NSLog(@"%@",response_error);
         [self.view endEditing:YES];
     }];
    
}


-(void)updateModal
{
    if (_ProfileModal==nil)
    {
         _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments • %@ likes",_FeedModal.comment_count,_FeedModal.like_count];
    }
    else
        _lblComment_Likes.text=[NSString stringWithFormat:@"%@ comments • %@ likes",_ProfileModal.PostCommentCount,_ProfileModal.PostLikeCount];

}







- (IBAction)btnCommentPressed:(id)sender
{
    [_txtViewComment becomeFirstResponder];
}

- (IBAction)btnSend:(id)sender {
    
    if (!([_txtViewComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) && !([_txtViewComment.text isEqualToString:@"Comment.."]))
    {
        [self SendCommentApi];
        self.txtViewComment.text=@"";
        [self.txtViewComment resignFirstResponder];
        _constraintBottomView.constant = 0 ;
        _constraintBottomViewHeight.constant=70;
    }
   
   
    

}
- (IBAction)btnBack:(id)sender
{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController radialPopViewControllerWithDuration:0.5 comlititionBlock:^{
//        
//    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
