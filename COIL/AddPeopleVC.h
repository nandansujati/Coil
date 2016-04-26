//
//  AddPeopleVC.h
//  COIL
//
//  Created by Aseem 9 on 12/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol SendPeopleIdsDetail
-(void)sendUserIdsArrayToGroupDetail:(NSArray *)UserIdsArray;
@end
@interface AddPeopleVC : UIViewController<UITextFieldDelegate>
{
    BOOL DoneClicked;
}
@property(nonatomic,strong)id<SendPeopleIdsDetail>delegate;
@property(nonatomic,strong)NSString* GroupName;
@property(nonatomic,strong)NSData *ImageData;
@property(nonatomic,strong)NSString *CourseIds;
@property(nonatomic,strong)NSString *PrivacyString;

@property(nonatomic,strong)NSDictionary *DictContactsParameters;
@property(nonatomic,strong)NSDictionary *DictAddPeopleParameters;
@property(nonatomic,strong)NSString *Access_token;
@property(nonatomic,strong)NSString *AddressBook;
@property(nonatomic,strong)NSMutableArray *values;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *FinalContactArray;
@property(nonatomic,strong)NSMutableArray *ArrayUserEmails;
@property(nonatomic,strong)NSMutableArray *ArrayUserIds;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSearch;
@property(nonatomic,strong)AppDelegate *appDelegate;
@property(nonatomic,strong)NSArray *NewFinalArray;
@property(nonatomic,strong)NSString *UserEmails;
@property(nonatomic,strong)NSString *UserIds;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property(nonatomic,strong)NSMutableArray *ArrayAllStrings;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnDone:(id)sender;
@end
