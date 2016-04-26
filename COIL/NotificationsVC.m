//
//  NotificationsVC.m
//  COIL
//
//  Created by Aseem 13 on 25/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NotificationsVC.h"

@interface NotificationsVC ()
@property DataSource2Cells *datasource;
@end

@implementation NotificationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.datasource = [[DataSource2Cells alloc] init];
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
     [self setupUI];
}
-(void)setupUI
{
       self.tableView.estimatedRowHeight=200;
    [[SharedClass SharedManager]LoaderWhiteOverlay:self.view];
    _NotificationsArray=[[NSMutableArray alloc]init];
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _AccessToken=[Dictionary valueForKey:@"access_token"];
    [self loadData];
}

-(void)loadData
{
    NotificationsModal *modal=[[NotificationsModal alloc]init];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        //[self loadParameters];
        [iOSRequest getData:UrlGetNotifications :@{@"access_token":_AccessToken,@"page":@"0"} :^(NSArray *response_success) {
            [[SharedClass SharedManager]removeLoader];
            
            if ([[response_success valueForKey:@"success"]integerValue]==1) {
                _NotificationsArray = [modal ListmethodCall:[response_success valueForKey:@"notification"] ];
                [self callDataSource];

            }
            
            
            
        }  :^(NSError *response_error) {
            
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
            [[SharedClass SharedManager]removeLoader];
        }];
    }

}



-(void)callDataSource
{
    
    TableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell,id item,id imageItems ,NSIndexPath *indexPath)
    {
        if ([cell isKindOfClass:[NotificationCell1 class]])
        {
          NotificationCell1 *cell1=(NotificationCell1*)cell;
            [cell1 configureCell:item];
        }
        else
        {
             NotificationCell2 *cell2=(NotificationCell2*)cell;
            [cell2 configureCell:item];
        }
    };
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NotificationCell1 class]) bundle:nil] forCellReuseIdentifier:CellIdentifierNotificationCell1];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NotificationCell2 class]) bundle:nil] forCellReuseIdentifier:CellIdentifierNotificationCell2];
    
    self.datasource = [[DataSource2Cells alloc] initWithItems:_NotificationsArray
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierNotificationCell1
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension ;
    
}

@end
