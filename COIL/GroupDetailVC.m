//
//  GroupDetailVC.m
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.


#import "GroupDetailVC.h"
#define CellIdentifierMemberCell @"groupDetailMemberCell"
#define CellidentifierFilesCell @"FilesCollection"
@interface GroupDetailVC ()<buttonPressedDelegate,menuPressed,SendPeopleIdsDetail>
{
    RNBlurModalView *modalView;
}
//@property DataSourceClass *datasource;
@property(nonatomic,strong)AppDelegate *appDelegate;
@property(nonatomic,strong)GroupSettingMenu *GroupsMenu;
@property(nonatomic,strong)ViewHeaderGroupDetail *HeaderView;

@end

@implementation GroupDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
     _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUI];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUI
{
    imageChanged=NO;
    _MemberArray=[[NSMutableArray alloc]init];
    _arrayImage=[[NSMutableArray alloc]init];
   
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
    notificationTrue=YES;
    [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    [self loadData];
    discoverabilityTag=0;
}

-(void)loadParameters
{
    _DictParameters=@{@"access_token":_Access_Token,@"group_id":_Group_Id};
    
}


-(void)loadUpdateParameters
{
    _DictUpdateParameters=@{@"access_token":_Access_Token,@"group_id":_Group_Id,@"name":_labelGroupName,@"privacy":[NSString stringWithFormat:@"%ld",(long)discoverabilityTag],@"notification":[NSString stringWithFormat:@"%ld",(long)notificationTag]};
    
}
-(void)loadData
{
    GroupDetailsModal *modal=[[GroupDetailsModal alloc]init];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlGroupDetails :_DictParameters :^(NSDictionary *response_success) {
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                
               
                    _GroupsArray = [modal ListmethodCall:response_success];
                    [self viewSetUp];
                
           
            }
            
        }
                :^(NSError *response_error) {
                                
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                [[SharedClass SharedManager]removeLoader];
                            }];
    }
    
}

-(void)viewSetUp
{
    for (GroupDetailsModal *modal in _GroupsArray)
    {
        if (_appDelegate.PushFromGroupDetail==NO) {
            _labelGroupName=modal.name;
            
            if (modal.image.length>0) {
                  _UrlImage = [NSString stringWithFormat:@"%@%@/300/%f",ImagePath,modal.image,self.view.frame.size.width];
            }
          
            [self getActiveMembersCount :modal];
            [self setDiscoverability:modal];
            _notificationFromModal=modal.notification;
            _filesCount=modal.file_count;
            [self setMemberTable:modal];
            [self setFilesData :modal];
        }
        else
        {
           [self setMemberTable:modal];
        }
        
       
    }
    
}


-(void)setFilesData:(GroupDetailsModal*)modal
{
     
    if ([_filesCount integerValue]==0)
    {
        _HeaderView = [[ViewHeaderGroupDetail alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 368)];
        _HeaderView.filesCount.hidden=YES;
        _HeaderView.ConstraintFilesHeight.constant = 0;
    }
    else
    {
        _HeaderView = [[ViewHeaderGroupDetail alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 458)];
        _HeaderView.filesCount.text=[NSString stringWithFormat:@"%@",_filesCount];
        _HeaderView.filesCount.hidden=NO;
        
        _FilesArray =[[NSMutableArray alloc]init];
        [_FilesArray addObjectsFromArray: modal.FilesArray];
        [_HeaderView  setFilesData:_FilesArray];
    }

    _HeaderView.lblGroupName.text=_labelGroupName;
    [self setGroupImage];
    _HeaderView.delegate=self;
    
//    [_HeaderView layoutIfNeeded];
//    _HeaderView.collectionViewFiles.hidden = YES;
    
    if ([_notificationFromModal integerValue]==0) {
        [_HeaderView.btnNotifications setImage:[UIImage imageNamed:@"switch_normal"] forState:UIControlStateNormal];
    }
    else
    {
        [_HeaderView.btnNotifications setImage:[UIImage imageNamed:@"switch_pressed"] forState:UIControlStateNormal];
    }
    _HeaderView.labelActiveMembers.text=_labelActiveMembers;
    [_HeaderView.btnDiscoverability setTitle:_textDiscoverability forState:UIControlStateNormal];
    _HeaderView.memberCount.text=_memberCount;
    
    self.tableView.tableHeaderView = _HeaderView;
    

}



-(void)setMemberData
{

    self.tableView.dataSource = self;
  
    
    if (!(_MemberArray.count==0) )
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
    return _MemberArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   GroupDetailMembersCell *cell = (GroupDetailMembersCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMemberCell];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GroupDetailMembersCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
 
    GroupDetailsModal *modal=[_MemberArray objectAtIndex:indexPath.row];
    [cell configureForCellWithCountry:modal];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_appDelegate.window setUserInteractionEnabled:NO];
    
    GroupDetailsModal *modal=[_MemberArray objectAtIndex:indexPath.row];
   
    BOOL useCustomView = YES;
    
    if (useCustomView)
    {
        _GroupsMenu = (GroupSettingMenu *)[[[NSBundle mainBundle] loadNibNamed:@"GroupSettingMenu" owner:self options:nil] objectAtIndex:0];
        NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:@"AccessToken"];
        NSString *userId=[dict valueForKey:@"user_Id"];
        if ([userId integerValue]==[modal.MemberId integerValue]) {
             _GroupsMenu.frame = CGRectMake(20, self.view.frame.size.height/2-50/2, self.view.frame.size.width-40, 50);
        }else
        _GroupsMenu.frame = CGRectMake(20, self.view.frame.size.height/2-_GroupsMenu.frame.size.height/2, self.view.frame.size.width-40, _GroupsMenu.frame.size.height);
        
        _GroupsMenu.layer.cornerRadius = 3.f;
        _GroupsMenu.layer.borderColor = [UIColor clearColor].CGColor;
        _GroupsMenu.layer.borderWidth = 3.f;
        [_GroupsMenu getName:modal.MemberName andId:modal.MemberId];
        _GroupsMenu.delegate=self;
        currentIndexPath=indexPath;
        modalView = [[RNBlurModalView alloc] initWithViewController:self view:_GroupsMenu];
    }
    [modalView show];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [modalView hide];
}


-(void)makeGroupAdminPressed
{
    GroupDetailsModal *modal=[_MemberArray objectAtIndex:currentIndexPath.row];
   NSLog(@"%@", modal.MemberId);
    NSDictionary *dictParam=@{@"access_token":_Access_Token,@"group_id":_Group_Id,@"other_id":modal.MemberId};
    
    [iOSRequest postData:UrlMakeAdmin :dictParam :^(NSDictionary *response_success) {
        [modalView hide];
        
        NSInteger Value=[modal.MemberAdmin_Access intValue];
     
         if (Value==0)
            Value=1;
        
        NSString *ValueChanged=[NSString stringWithFormat:@"%li",(long)Value];
        modal.MemberAdmin_Access=ValueChanged;
        
        [_MemberArray replaceObjectAtIndex:currentIndexPath.row withObject:modal];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:currentIndexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

    } :^(NSError *response_error) {
        [modalView hide];
    }];
}

-(void)ViewUserProfile
{
    GroupDetailsModal *modal=[_MemberArray objectAtIndex:currentIndexPath.row];
    NSLog(@"%@", modal.MemberId);
    UserProfileVC *userVC=[self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    userVC.User_Id=modal.MemberId;
    userVC.OtherUserProfile=YES;
    [modalView hide];
    [self.navigationController pushViewController:userVC animated:YES];
}

-(void)removeMember
{
    GroupDetailsModal *modal=[_MemberArray objectAtIndex:currentIndexPath.row];
    NSLog(@"%@", modal.MemberId);
    NSDictionary *dictParam=@{@"access_token":_Access_Token,@"group_id":_Group_Id,@"other_id":modal.MemberId};
    
    [iOSRequest postData:UrlRemoveMember :dictParam :^(NSDictionary *response_success) {
        [modalView hide];
        

        [_MemberArray removeObjectAtIndex:currentIndexPath.row];
        
        [_tableView reloadData];
        NSInteger count=[_memberCount integerValue];
        count=count-1;
        _memberCount=[NSString stringWithFormat:@"%ld",(long)count];
        _HeaderView.memberCount.text=_memberCount;
        
        
    } :^(NSError *response_error) {
        [modalView hide];
    }];

}



-(void)setMemberTable :(GroupDetailsModal*)modal
{
    _memberCount=[NSString stringWithFormat:@"%ld",(long)[modal.member_count integerValue]];
    _MemberArray =[[NSMutableArray alloc]init];
    [_MemberArray addObjectsFromArray: modal.MembersArray];
    [self  setMemberData];
    
}

-(void)setDiscoverability :(GroupDetailsModal*)modal
{
    if ([modal.Privacy isEqualToString:@"0"]) {
        _textDiscoverability=@"Open";
      
    }
    else if ([modal.Privacy isEqualToString:@"1"]) {
        _textDiscoverability=@"Close";
     
    }
    else if ([modal.Privacy isEqualToString:@"2"]) {
        _textDiscoverability=@"Secret";
      
    }
}

-(void)setGroupImage
{
    if (_UrlImage.length>0)
    {
        NSURL *Url=[NSURL URLWithString:_UrlImage];
        
        [_HeaderView.imageGroup sd_setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        NSData *fileData = [NSData dataWithContentsOfURL:Url];
        UIImage *image=[UIImage imageWithData:fileData];
        [_arrayImage addObject:image];
        
    }
    else
    {
        
        [_HeaderView.imageGroup setImage:[UIImage imageNamed:@"img_placeholder_group"]];
        [_arrayImage addObject:[UIImage imageNamed:@"img_placeholder_group"]];
    }
    
    
}


-(void)getActiveMembersCount:(GroupDetailsModal*)modal
{
    NSArray *MemberArray=modal.MembersArray;
    
    NSInteger ActiveMemberCount=0;
    for (GroupDetailsModal *modal2 in MemberArray) {
        if ([modal2.MemberStatus isEqualToString:@"1"]) {
            ActiveMemberCount +=1;
        }
    }
    
    if (ActiveMemberCount ==1) {
        _labelActiveMembers=[NSString stringWithFormat:@"%ld Active Member",(long)ActiveMemberCount];
    }
    else
    _labelActiveMembers=[NSString stringWithFormat:@"%ld Active Members",(long)ActiveMemberCount];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

-(void)btnEditPressed
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Enter New Group Name "
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         
         textField.text = _labelGroupName;
         textField.keyboardType=UIKeyboardTypeEmailAddress;
     }];
    
    
    
    
    UIAlertAction* Done = [UIAlertAction actionWithTitle:@"Done"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                           {
                               
                               [alert dismissViewControllerAnimated:YES completion:nil];
                               if ([alert.textFields.firstObject.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
                               {
//                                   [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"Please enter your group Name..!!" :@"OK"];
                               }
                               else
                               {
                                
                                   
                                   _HeaderView.lblGroupName.text=alert.textFields.firstObject.text;
                                   _labelGroupName=alert.textFields.firstObject.text;
                                   }
                               
                                   
                               
                               
                           }];
    UIAlertAction* Cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [self.view endEditing:YES];
                             }];
    
    [alert addAction:Done];
    [alert addAction:Cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)imagePressed
{

        NSString *actionSheetTitle = @"UPLOAD IMAGES";
        NSString *destructiveTitle = @"CANCEL";
        NSString*btn1=@"Upload Picture";
        NSString *btn2=@"Take Photo";
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:actionSheetTitle
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        
        UIAlertAction* Done = [UIAlertAction actionWithTitle:btn1
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                   picker.delegate = self;
                                   picker.allowsEditing = YES;
                                   picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                   
                                   [self presentViewController:picker animated:YES completion:NULL];
                                   
                                   
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               } ];
        
        UIAlertAction* Camera = [UIAlertAction
                                 actionWithTitle:btn2
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                     if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                         
                                         [[SharedClass SharedManager]AlertErrors:@"Error !!" :@"Device has no Camera" :@"OK"];
                                     }
                                     else
                                     {
                                         picker.delegate = self;
                                         picker.allowsEditing = YES;
                                         picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                         
                                         [self presentViewController:picker animated:YES completion:NULL];
                                     }
                                 }];
        UIAlertAction* Cancel = [UIAlertAction actionWithTitle:destructiveTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 } ];
        
        [alert addAction:Done];
        [alert addAction:Camera];
        [alert addAction:Cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
}
    
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        _HeaderView.imageGroup.image=chosenImage;
        [_arrayImage removeAllObjects];
        [_arrayImage addObject:chosenImage];
        imageChanged=YES;
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
    }



-(void)btnNotificationsPressed
{
    if (notificationTrue==YES) {
        notificationTrue=NO;
        notificationTag=0;
        [_HeaderView.btnNotifications setImage:[UIImage imageNamed:@"switch_normal"] forState:UIControlStateNormal];
    }
    else if (notificationTrue==NO) {
        notificationTrue=YES;
        notificationTag=1;
        [_HeaderView.btnNotifications setImage:[UIImage imageNamed:@"switch_pressed"] forState:UIControlStateNormal];
    }
}

-(void)btnDiscoverablitypPressed
{
    NSString *actionSheetTitle = @"Select Group Discoverability"; //Action Sheet Title
    NSString *destructiveTitle = @"CANCEL"; //Action Sheet Button Titles
    NSString*btn1=@"Open";
    NSString *btn2=@"Close";
    NSString *btn3=@"Secret";
  
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:actionSheetTitle
                                      delegate:self
                                      cancelButtonTitle:destructiveTitle
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:btn1, btn2,btn3, nil];
        
        [actionSheet showInView:self.view];
    

}

#pragma mark- ActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Open"]) {
        [_HeaderView.btnDiscoverability setTitle:@"Open" forState:UIControlStateNormal];
        _textDiscoverability=@"Open";
        discoverabilityTag=0;
    }
    
    
    if  ([buttonTitle isEqualToString:@"Close"]) {
        [_HeaderView.btnDiscoverability setTitle:@"Close" forState:UIControlStateNormal];
        _textDiscoverability=@"Close";
        discoverabilityTag=1;
    }
    if  ([buttonTitle isEqualToString:@"Secret"]) {
        [_HeaderView.btnDiscoverability setTitle:@"Secret" forState:UIControlStateNormal];
        _textDiscoverability=@"Secret";
        discoverabilityTag=2;
    }
    
    if ([buttonTitle isEqualToString:@"CANCEL"])
    {
        NSLog(@"Done");
    }
    
}


-(void)btnAddPeoplePressed
{
    _appDelegate.PushFromGroupDetail=YES;
    AddPeopleVC *peopleVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPeopleVC"];
    peopleVC.delegate=self;
    [self.navigationController pushViewController:peopleVC animated:YES];
}


-(void)sendUserIdsArrayToGroupDetail:(NSArray *)UserIdsArray
{
    NSString *UsersIds=[UserIdsArray componentsJoinedByString:@","];
    NSDictionary *dictParam=@{@"access_token":_Access_Token,@"group_id":_Group_Id,@"users":UsersIds};
    
    [iOSRequest postData:UrlAddNewMembers :dictParam :^(NSDictionary *response_success) {
        
        [self loadData];
        
    } :^(NSError *response_error) {
       
    }];

}

- (void)btnBackPressed
{
    
    for (GroupDetailsModal *modal in _GroupsArray) {
       
        if (_labelGroupName!=modal.name) {
            NSLog(@"group name chnaged");
            [_delegate groupNmaeChanged:_labelGroupName];
        }
        
        if (discoverabilityTag!=[modal.Privacy integerValue] ) {
            NSLog(@"privacy chnaged");
        }
        
        
        [self updateGroupApi];

    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)updateGroupApi
{
   // UIImage *image=[_arrayImage objectAtIndex:0];
    NSData *imageData = UIImagePNGRepresentation(_HeaderView.imageGroup.image);
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadUpdateParameters];
        
        if (imageChanged==YES) {
            [iOSRequest postMutliPartData:UrlUpdateGroup :@"image":_DictUpdateParameters :imageData :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                    
                }
                
            } :^(NSError *response_error) {
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                [[SharedClass SharedManager]removeLoader];
            }];
        }
        else
        {
            [iOSRequest postData:UrlUpdateGroup :_DictUpdateParameters :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                    
                }
            } :^(NSError *response_error) {
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                [[SharedClass SharedManager]removeLoader];

            }];
                    }
      
       
    }

}
@end
