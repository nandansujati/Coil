//
//  NewGroupVC.m
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NewGroupVC.h"

@interface NewGroupVC ()<btnPressedfromCanvasView>
{
    BOOL notificationTrue;
    RNBlurModalView *modalView;
}
@property(nonatomic,strong)AddPeopleVC *AddPeople;
@property(nonatomic,strong)ViewCanvasIntegration *ViewCanvas;
@end

@implementation NewGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Call from ViewDidLoad
-(void)setupUI
{
    _image.layer.cornerRadius=3.0f;
    
    
    UIImage * backgroundImg = [UIImage imageNamed:@"Patch"];
    
    backgroundImg = [backgroundImg resizableImageWithCapInsets:UIEdgeInsetsMake(2,2, 2, 2)];
    
    [_ImageStretched setImage:backgroundImg];
    
    
   
    [ _txtGroupName setValue:[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:119.0/255.0 alpha:1.0f]
                 forKeyPath:@"_placeholderLabel.textColor"];
    
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleTap:)];
    pgr.delegate = self;
    self.image.userInteractionEnabled=YES;
    self.image.clipsToBounds = YES;
    [self.image addGestureRecognizer:pgr];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self btnCrossPressed];
}


#pragma mark- ImagePicker Methods
- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSString *actionSheetTitle = @"UPLOAD IMAGES";
    NSString *destructiveTitle = @"CANCEL";
    NSString*btn1=@"Get Images";
    NSString*btn2=@"Upload Picture";
    NSString *btn3=@"Take Photo";
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:actionSheetTitle
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* Images = [UIAlertAction actionWithTitle:btn1
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             } ];
    
    
    
    UIAlertAction* Upload = [UIAlertAction actionWithTitle:btn2
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
                             actionWithTitle:btn3
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
    
    [alert addAction:Images];
    [alert addAction:Upload];
    [alert addAction:Camera];
    [alert addAction:Cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image.image=chosenImage;
    _ImageStretched.hidden=YES;
    _ImageBubble.hidden=YES;
    _labelOnImage.hidden=YES;
    self.imagePlus.hidden=YES;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark- Function Calls
-(NSInteger)TextFieldValidations
{
    ValueValidation=0;
    if (ValueValidation==0)
    {
        
        if ([_txtGroupName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
        {
            [[SharedClass SharedManager]AlertErrors:@"Error" :@"Please enter your Group's Name" :@"Ok"];
            
            ValueValidation=1;
            
        }
        
        
    }
    return ValueValidation;
}

#pragma mark- Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueAddPeople"])
    {
        _AddPeople = [segue destinationViewController];
        if (Imagedata)
        {
            _AddPeople.ImageData=Imagedata;
        }
        _AddPeople.GroupName=_txtGroupName.text;
    }
}



#pragma mark- ActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Open"]) {
       
        _lblDiscoverablity.text=@"Open";
        _lblDisOptions.text=@"Visible to all coil app users";
      
    }
    
    
    if  ([buttonTitle isEqualToString:@"Close"]) {
        
        _lblDiscoverablity.text=@"Close";
        _lblDisOptions.text=@"Visible to group Members only";
       
    }
    if  ([buttonTitle isEqualToString:@"Secret"]) {
      
        _lblDiscoverablity.text=@"Secret";
        _lblDisOptions.text=@"Invisible for every user";
        
    }
    
//    if ([buttonTitle isEqualToString:@"CANCEL"])
//    {
//        NSLog(@"Done");
//    }
    
}


#pragma mark- Button Actions

- (IBAction)btnDiscoverabilityDD:(id)sender
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

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)btnNext:(id)sender
{
    Imagedata = UIImageJPEGRepresentation(self.image.image, 0.5);
    
    NSInteger Value=[self TextFieldValidations];
    if (Value==0)
    {
        [self performSegueWithIdentifier:@"SegueAddPeople" sender:self];
        
        }

}

- (IBAction)btnCanvasIntegration:(id)sender {
    if (notificationTrue==YES) {
        notificationTrue=NO;
      
        [self.btnCanvasInt setImage:[UIImage imageNamed:@"switch_normal"] forState:UIControlStateNormal];
    }
    else if (notificationTrue==NO) {
        notificationTrue=YES;
        
        [self.btnCanvasInt setImage:[UIImage imageNamed:@"switch_pressed"] forState:UIControlStateNormal];
        [self showView];
    }
}

-(void)showView
{
    _ViewCanvas = (ViewCanvasIntegration *)[[[NSBundle mainBundle] loadNibNamed:@"ViewCanvasIntegration" owner:self options:nil] objectAtIndex:0];
    _ViewCanvas.frame = CGRectMake(20, self.view.frame.size.height/2-_ViewCanvas.frame.size.height/2, self.view.frame.size.width-40, _ViewCanvas.frame.size.height);
    _ViewCanvas.layer.cornerRadius = 10.f;
    _ViewCanvas.layer.borderColor = [UIColor clearColor].CGColor;
    _ViewCanvas.layer.borderWidth = 3.f;
    _ViewCanvas.delegate=self;
//    currentIndexPath=indexPath;
    modalView = [[RNBlurModalView alloc] initWithViewController:self view:_ViewCanvas];
    [modalView show];
}


-(void)btnCrossPressed
{
    [modalView hide];
    notificationTrue=NO;
    
    [self.btnCanvasInt setImage:[UIImage imageNamed:@"switch_normal"] forState:UIControlStateNormal];
}



@end
