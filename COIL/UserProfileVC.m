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
@interface UserProfileVC ()
@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation UserProfileVC

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
    [self setupUI];
}
-(void)setupUI
{
    _ProfileArray=[[NSMutableArray alloc]init];
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _Access_Token=[Dictionary valueForKey:@"access_token"];
    _User_Id=[Dictionary valueForKey:@"user_Id"];
    [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    [self loadData];
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
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                
                
                _ProfileArray = [modal ListmethodCall:response_success];
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
    for (UserProfileModal *modal in _ProfileArray)
    {
       
//            _labelGroupName=modal.name;
//            
//            if (modal.image.length>0) {
//                _UrlImage = [NSString stringWithFormat:@"%@%@/300/%f",ImagePath,modal.image,self.view.frame.size.width];
//            }
//            
//            [self getActiveMembersCount :modal];
//            [self setDiscoverability:modal];
//            _notificationFromModal=modal.notification;
//            _filesCount=modal.file_count;
//            [self setMemberTable:modal];
//            [self setFilesData :modal];
        
        
        
    }
    
}


@end
