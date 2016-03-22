//
//  GroupDetailVC.m
//  COIL
//
//  Created by Aseem 9 on 17/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "GroupDetailVC.h"
#define CellIdentifierMemberCell @"groupDetailMemberCell"
@interface GroupDetailVC ()
//@property DataSourceClass *datasource;
@property(nonatomic,strong)ViewHeaderGroupDetail *HeaderView;
@end

@implementation GroupDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    
//    if (self)
//    {
//        self.datasource = [[DataSourceClass alloc] init];
//    }
//    return self;
//}

-(void)setupUI
{
   // _collectionView.dataSource = _datasource;
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
   
    [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    [self loadData];
}

-(void)loadParameters
{
    _DictParameters=@{@"access_token":_Access_Token,@"group_id":_Group_Id};
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
             //   [self CallDataSource];
                //[_collectionView reloadData];
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
    for (GroupDetailsModal *modal in _GroupsArray) {
        _labelGroupName=modal.name;
        
       // [self setGroupImage:modal];
        _UrlImage = [NSString stringWithFormat:@"%@%@/300/%f",ImagePath,modal.image,self.view.frame.size.width];
        [self getActiveMembersCount :modal];
        [self setDiscoverability:modal];
        
//
        _filesCount=modal.file_count;
        [self setMemberTable:modal];
        [self setFilesData ];
    }
    
}


-(void)setFilesData
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
    }
    
    _HeaderView.lblGroupName.text=_labelGroupName;
    [self setGroupImage];
    _HeaderView.delegate=self;
    
//    [_HeaderView layoutIfNeeded];
//    _HeaderView.collectionViewFiles.hidden = YES;
    
    _HeaderView.labelActiveMembers.text=_labelActiveMembers;
    [_HeaderView.btnDiscoverability setTitle:_textDiscoverability forState:UIControlStateNormal];
    _HeaderView.memberCount.text=_memberCount;
    
    self.tableView.tableHeaderView = _HeaderView;
    
}



-(void)setData
{

    self.tableView.dataSource = self;
  
    
    if (!(_MemberArray.count==0) )
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

-(void)setMemberTable :(GroupDetailsModal*)modal
{
    _memberCount=[NSString stringWithFormat:@"%ld",(long)[modal.member_count integerValue]];
    _MemberArray=modal.MembersArray;
    [self  setData];
    
    
}

-(void)setDiscoverability :(GroupDetailsModal*)modal
{
//    if ([modal.Privacy isEqualToString:@"0"]) {
//        [_HeaderView.btnDiscoverability setTitle:@"Open" forState:UIControlStateNormal];
//    }
//   else if ([modal.Privacy isEqualToString:@"1"]) {
//        [_HeaderView.btnDiscoverability setTitle:@"Close" forState:UIControlStateNormal];
//    }
//   else if ([modal.Privacy isEqualToString:@"2"]) {
//        [_HeaderView.btnDiscoverability setTitle:@"Secret" forState:UIControlStateNormal];
//    }
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
        
    }
    else
    {
        
        [_HeaderView.imageGroup setImage:[UIImage imageNamed:@"img_placeholder_group"]];
        
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

- (void)btnBackPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
