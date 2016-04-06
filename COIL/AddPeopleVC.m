//
//  AddPeopleVC.m
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "AddPeopleVC.h"
#import <MessageUI/MessageUI.h>
#define CellIdentifierAddPeople @"AddPeopleCell"
@interface AddPeopleVC ()<bntClicked,MFMessageComposeViewControllerDelegate>
@property(nonatomic,strong)CNContactStore *store;
@property(nonatomic,strong)ContactModal *Modal;
@property(nonatomic,strong)AddPeopleCell *Addcell;
@end

@implementation AddPeopleVC

- (void)viewDidLoad
{
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
    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    
    _Access_token=[Dictionary valueForKey:@"access_token"];
    _store=[[CNContactStore alloc] init];
    _Modal=[[ContactModal alloc]init];
    _values = [[NSMutableArray alloc]init];
    _ArrayUserEmails=[[NSMutableArray alloc]init];
    _ArrayUserIds=[[NSMutableArray alloc]init];
    _ArrayAllStrings=[[NSMutableArray alloc]init];
    _FinalContactArray=[[NSMutableArray alloc]init];
    
    _txtFieldSearch.delegate=self;
    [self GetContacts];
    //[self CheckSelected];

}

-(void)GetContacts
{
    [_store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES)
        {
            NSArray*AddressBookFetched;
            AddressBookFetched= [[SharedClass SharedManager]AddressBookFetch];
            NSData *JsonContactsArray = [NSJSONSerialization dataWithJSONObject:AddressBookFetched options:NSJSONWritingPrettyPrinted error:nil];
            
            _AddressBook = [[NSString alloc] initWithData:JsonContactsArray encoding:NSUTF8StringEncoding];
             [self loadData];
        }
        
    }];
}


#pragma mark- API Methods
-(void)loadParameters
{
    if (_Access_token!=nil)
    {
        _DictContactsParameters=@{@"access_token":_Access_token,@"contact":_AddressBook};
        
        if (DoneClicked==YES)
        {
            _DictAddPeopleParameters=@{@"access_token":_Access_token,@"name":_GroupName,@"users":_UserIds,@"emails":_UserEmails};
        }
       
    }
   
    
}


-(void)loadData
{
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        [iOSRequest postData:UrlSyncContact :_DictContactsParameters :^(NSDictionary *response_success) {
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
               NSMutableArray *ContactsArray=[[NSMutableArray alloc]init];
                ContactsArray=[response_success valueForKey:@"users"];
                NSArray *arrayContact = [_Modal ListmethodCall:ContactsArray];
                
                
                NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
                NSString *userId=[Dictionary valueForKey:@"user_Id"];
                
                for (ContactModal *modal in arrayContact) {
                    NSLog(@"%@",modal.UserId);
                    if ([userId integerValue]!= [modal.UserId integerValue])
                    {
                        [_FinalContactArray addObject: modal];
                    }
                }
                
               
                
                _NewFinalArray=_FinalContactArray;
                
                for (ContactModal *modal in _FinalContactArray) {
                    [_ArrayAllStrings addObject:modal.fullName];
                }
                [_tableView reloadData];

            }
            
        }
         :^(NSError *response_error) {
                                
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                                //     [self removeLoader];
                            }];
    }

}
#pragma mark- TextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
   NSArray *array= [self SearchResults:newString];
    _FinalContactArray =[[NSMutableArray alloc]init];
    [_FinalContactArray addObjectsFromArray:array];
    [_tableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(NSMutableArray*)SearchResults:(NSString*)SearchString
{
   
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",SearchString];
    NSArray *results = [_ArrayAllStrings filteredArrayUsingPredicate:predicate];
    NSMutableArray *array=[[NSMutableArray alloc]init];

    if (results.count>0) {
        for (NSString *str in results)
        {
            for (ContactModal *data in _NewFinalArray)
            {
                if ([str isEqualToString:data.fullName])
                {
                    [array addObject:data];
                }
            }
            
        }
    }
   else
       [array addObjectsFromArray:_NewFinalArray];
    
    
    
    
    return array;
}

#pragma  mark- TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _FinalContactArray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     _Addcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierAddPeople];
    if (_Addcell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddPeopleCell" owner:self options:nil];
        _Addcell = [nib objectAtIndex:0];
        
    }

        _Modal=[_FinalContactArray objectAtIndex:indexPath.row];
         for (int i = 0; i<[_FinalContactArray count]; i++)
         {
            [_values addObject:@"NO"];
         }
    
    if ([_Modal.Match integerValue]==1)
    {
        _Addcell.btnInvite.hidden=YES;
        _Addcell.btnCheckbox.hidden=NO;
    }
    else
    {
        _Addcell.btnInvite.hidden=NO;
        _Addcell.btnCheckbox.hidden=YES;

    }
         _Addcell.indexPath = indexPath;
         _Addcell.delegate = self;
    
         if([[_values objectAtIndex:indexPath.row]isEqualToString:@"NO"])
         {
           [_Addcell.btnCheckbox setSelected:NO];
         }
         else
         {
           [_Addcell.btnCheckbox setSelected:YES];
         }
    
        [_Addcell configureForCellWithCountry:_Modal];
    
    
    
        return _Addcell;
}
        

#pragma mark- TableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

#pragma mark- Delegate Methods
-(void)BtnCheckboxClicked:(NSIndexPath *)indexpath
{
    _Addcell = (AddPeopleCell*)[self.tableView cellForRowAtIndexPath:indexpath];
    _Modal = [_FinalContactArray objectAtIndex:indexpath.row];
    if([_Addcell.btnCheckbox isSelected])
    {
        [_values replaceObjectAtIndex:indexpath.row withObject:@"NO"];
        [_Addcell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_inactive"] forState:UIControlStateSelected];
        [_Addcell.btnCheckbox setSelected:NO];
        [_ArrayUserEmails removeObject:[_Modal.Email firstObject]];
        [_ArrayUserIds removeObject:_Modal.UserId];
        
    }
    
    else if (![_Addcell.btnCheckbox isSelected])
    {
        [_values replaceObjectAtIndex:indexpath.row withObject:@"YES"];
        [_Addcell.btnCheckbox setImage:[UIImage imageNamed:@"ic_checkbox_active"] forState:UIControlStateSelected];
        [_Addcell.btnCheckbox setSelected:YES];
        [_ArrayUserEmails addObject:[_Modal.Email firstObject]];
        [_ArrayUserIds addObject:_Modal.UserId];
        
       
    }
    
   
   // [self CheckSelected];
}



-(void)BtnInvite:(NSIndexPath *)indexpath
{
    _Addcell = (AddPeopleCell*)[self.tableView cellForRowAtIndexPath:indexpath];
    _Modal = [_FinalContactArray objectAtIndex:indexpath.row];
    
    
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self;
        
        NSMutableArray *recipients = [[NSMutableArray alloc] init];
        [recipients addObject:[_Modal.Phone objectAtIndex:0]];
        messageController.recipients = recipients;
        
        messageController.body = @"Inviting you to Join COIL"; // Set initial text to example message
        
        dispatch_async(dispatch_get_main_queue(), ^{ // Present VC when possible
            [self presentViewController:messageController animated:YES completion:NULL];
        });
    }
    
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}


- (IBAction)btnBack:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender
{
    if (_ArrayUserIds.count>0)
    {
        if (_appDelegate.PushFromGroupDetail==NO) {
            DoneClicked=YES;
            [self CreateGroupApiCall];
        }
      else
      {
          [_delegate sendUserIdsArrayToGroupDetail:_ArrayUserIds];
          [self.navigationController popViewControllerAnimated:YES];
      }

        
    }
    
}

-(void)CreateGroupApiCall
{
    [[SharedClass SharedManager]Loader:self.view];
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        _UserEmails=[_ArrayUserEmails componentsJoinedByString:@","];
        _UserIds=[_ArrayUserIds componentsJoinedByString:@","];
        
        [self loadParameters];
        [iOSRequest postMutliPartData:UrlCreateGroup : @"image":_DictAddPeopleParameters :_ImageData :^(NSDictionary *response_success){
            [[SharedClass SharedManager]removeLoader];
            NSInteger value=[[response_success valueForKey:@"success"]integerValue];
            if (value==1)
            {
                [[SharedClass SharedManager]AlertErrors:@"Success !!" :@"Group Created" :@"OK"];
                NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
                for (UIViewController *aViewController in allViewControllers) {
                    if ([aViewController isKindOfClass:[UITabBarController class]]) {
                        [self.navigationController popToViewController:aViewController animated:NO];
                    }
                }
            }
            else
            {
                [[SharedClass SharedManager]AlertErrors:@"Error !!" :[response_success valueForKey:@"msg"] :@"OK"];
            }
            
        }
            :^(NSError *response_error) {
                                
            [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
            [[SharedClass SharedManager]removeLoader];
            }];
    }
    

}
@end
