//
//  SettingsVC.m
//  COIL
//
//  Created by Aseem 13 on 23/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "SettingsVC.h"
#define CellIdentifierSettings @"CellSettings"
@interface SettingsVC()<ButtonPressedFromChnagePasword>
{
    RNBlurModalView *modalView;
}
@property(nonatomic,strong)ChangePasswordView *passwordView;
@property DataSourceClass *datasource;
@end
@implementation SettingsVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setData];
    
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
    _ArraySettings=@[@"Notifications",@"Change Password",@"Terms & Conditions",@"Privacy Policy",@"Logout"];
}

-(void)setData
{
    
    TableViewCellConfigureBlock configureCell = ^(SettingsCell *cell,id item,id imageItems ,NSIndexPath *indexPath)
    {
        if ([item isEqualToString:@"Notifications"]) {
            [cell.btnArrow setImage:[UIImage imageNamed:@"switch_pressed"] forState:UIControlStateNormal];
        }
        cell.btnArrow.selected=YES;
        [cell configureCell:item];
        cell.btnArrow.tag=indexPath.row;
    };
    
    self.datasource = [[DataSourceClass alloc] initWithItems:_ArraySettings
                                                  imageItems:nil
                                              cellIdentifier:CellIdentifierSettings
                                          configureCellBlock:configureCell];
    self.tableView.dataSource = _datasource;
    [self.tableView reloadData];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==1) {
        [self showPasswordView];
    }
    else if (indexPath.row==4) {
       
        NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
        for (UIViewController *aViewController in allViewControllers) {
            if ([aViewController isKindOfClass:[SplashVC class]]) {
                [self.navigationController popToViewController:aViewController animated:NO];
            }
        }
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"AccessToken"];
        
    }
}


-(void)showPasswordView
{
    _passwordView = (ChangePasswordView *)[[[NSBundle mainBundle] loadNibNamed:@"ChangePasswordView" owner:self options:nil] objectAtIndex:0];
    _passwordView.frame = CGRectMake(20, self.view.frame.size.height/2-_passwordView.frame.size.height/2, self.view.frame.size.width-40, _passwordView.frame.size.height);
    _passwordView.layer.cornerRadius = 10.f;
    _passwordView.layer.borderColor = [UIColor clearColor].CGColor;
    _passwordView.layer.borderWidth = 3.f;
    _passwordView.delegate=self;
    //    currentIndexPath=indexPath;
    modalView = [[RNBlurModalView alloc] initWithViewController:self view:_passwordView];
    [modalView show];
}

-(void)btnDonePressed
{
    [modalView hide];
}

-(void)btnCancelPressed
{
    [modalView hide];
}

@end
