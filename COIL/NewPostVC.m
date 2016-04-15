//
//  NewPostVC.m
//  COIL
//
//  Created by Aseem 9 on 31/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NewPostVC.h"
#import <AVFoundation/AVFoundation.h>
#define CellIdentifierPostImagesCell @"PostImagesCell"
#define CellIdentifierPostVideosCell @"PostVideoCell"
@interface NewPostVC ()<floatMenuDelegate>
{
    CGRect floatFrame;
}
@property MyGroupsDataSource *datasource;
@property (strong, nonatomic) VCFloatingActionButton *addButton;

@end

@implementation NewPostVC

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
        _datasource = [[MyGroupsDataSource alloc] init];
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeKeyboardObservers];
}

-(void)setupUI
{
    _arrayData=[[NSMutableArray alloc]init];
    _constraintImageHeight.constant=0;
    _constraintVideoHieght.constant=0;
    _collectionView.dataSource = _datasource;
    _collectionVideos.dataSource=_datasource;
    _ArrayImages=[[NSMutableArray alloc]init];
    _ArrayVideos=[[NSMutableArray alloc]init];

    NSDictionary *Dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"AccessToken"];
    _accessToken=[Dictionary valueForKey:@"access_token"];
    [self addAttachmentButton];
    [self registerForKeyboardNotifications];
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TappedBackground:)];
    gesture.cancelsTouchesInView=YES;
    [self.view addGestureRecognizer:gesture];
    
}


-(void)TappedBackground:(UITapGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
}
-(void)addAttachmentButton
{
    floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width -66 - 20, [UIScreen mainScreen].bounds.size.height - 66 - 10, 66, 66);
    
    _addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"ic_attachment_floating"] andPressedImage:[UIImage imageNamed:@"ic_attachment_floating"] withScrollview:nil];
    
    
    _addButton.imageArray = @[@"ic_image_ellipse",@"ic_video_ellipse",@"ic_file_ellipse"];
    _addButton.labelArray = @[@"Image",@"Video",@"File"];
    _addButton.hideWhileScrolling = YES;
    _addButton.delegate = self;
    
    [self.view addSubview:_addButton];

}

-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    NSLog(@"Floating action tapped index %tu",row);
    if (row==0)
    {
        [self ImageClicked];
    }
    else if (row==1)
    {
        [self VideoClicked];
        
    }
}


-(void)ImageClicked
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
     NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if (chosenImage!=nil) {
        //self.image.image=chosenImage;
        [_ArrayImages addObject:chosenImage];
         NSData *data = UIImageJPEGRepresentation(chosenImage, 0.5);
        [_arrayData addObject:data];
        _dataMedia=data;
        [self CallDataSource];
        
}
    else if (mediaType!=nil)
    {
        if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
            _VideoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
            _VideoData = [NSData dataWithContentsOfURL:_VideoUrl];
            NSString *moviePath = [_VideoUrl path];
            UIImage *image=[self loadImage];
            [_ArrayVideos addObject:image];
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            [_arrayData addObject:data];
            _dataMedia=_VideoData;
            [self CallDataSourceVideo];
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
                UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
            }
        }
    }
   
    [picker dismissViewControllerAnimated:YES completion:NULL];
   

    
    
}

- (UIImage*)loadImage {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:_VideoUrl options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    
    return [[UIImage alloc] initWithCGImage:imgRef];
    
}

-(void)VideoClicked
{
    NSString *actionSheetTitle = @"UPLOAD VIDEOS";
    NSString *destructiveTitle = @"CANCEL";
    NSString*btn1=@"Upload Video";
    NSString *btn2=@"Make Video";
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:actionSheetTitle
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction* Done = [UIAlertAction actionWithTitle:btn1
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                           {
                               UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                               imagePicker.delegate = self;
                               imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
                               
                               [self presentViewController:imagePicker animated:YES completion:NULL];
                               
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           } ];
    
    UIAlertAction* Camera = [UIAlertAction
                             actionWithTitle:btn2
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                 {
                                     UIImagePickerController *videoRecorder = [[UIImagePickerController alloc] init];
                                     videoRecorder.sourceType = UIImagePickerControllerSourceTypeCamera;
                                     videoRecorder.delegate = self;
                                     
                                     NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
                                     NSArray *videoMediaTypesOnly = [mediaTypes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(SELF contains %@)", @"movie"]];
                                     
                                     if ([videoMediaTypesOnly count] == 0)		//Is movie output possible?
                                     {
//
                                         [[SharedClass SharedManager]AlertErrors:@"Sorry but your device does not support video recording" :nil :@"OK" ];
                                         
                                     }
                                     else
                                     {
                                         //Select front facing camera if possible
                                         if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
                                             videoRecorder.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                                         
                                         videoRecorder.mediaTypes = videoMediaTypesOnly;
                                         videoRecorder.videoQuality = UIImagePickerControllerQualityTypeMedium;
                                         videoRecorder.videoMaximumDuration = 180;			//Specify in seconds (600 is default)
                                         
                                         [self presentViewController:videoRecorder animated:YES completion:NULL];
                                     }
                                     
                                 }
                                 else
                                 {
                                     //No camera is availble
                                 }                             }];
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
- (void)registerForKeyboardNotifications

{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
       [_addButton removeFromSuperview];
        floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 66 - 20, [UIScreen mainScreen].bounds.size.height - 66 - keyboardSize.height, 66, 66);
          [self addButton:floatFrame];

    
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    [_addButton removeFromSuperview];
    floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 66 - 20, [UIScreen mainScreen].bounds.size.height - 66 - 10, 66, 66);
   
    [self addButton:floatFrame];
    
    
    
}

-(void)addButton:(CGRect)frame
{
    if (FloatingButtonRemoved==NO) {
        _addButton = [[VCFloatingActionButton alloc]initWithFrame:frame normalImage:[UIImage imageNamed:@"ic_attachment_floating"] andPressedImage:[UIImage imageNamed:@"ic_attachment_floating"] withScrollview:nil];
        _addButton.imageArray = @[@"ic_image_ellipse",@"ic_video_ellipse",@"ic_file_ellipse"];
        _addButton.labelArray = @[@"Image",@"Video",@"File"];
        _addButton.hideWhileScrolling = YES;
        _addButton.delegate = self;
        [self.view addSubview:_addButton];
    }
    
}
-(void)removeKeyboardObservers

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    
}
-(void)loadParameters
{
    _dictParameters= @{@"access_token":_accessToken,@"group_id":_group_Id,@"post_type":@"1", @"title":_txtView.text};
}


-(void)loadData
{
    
    NSInteger valueNetwork=[[SharedClass SharedManager]NetworkCheck];
    if (valueNetwork==0)
    {
        [self loadParameters];
        
        if (_VideoData==nil)
        {
            [iOSRequest postMutliPartData:UrlCreatePost :@"image" :_dictParameters :_dataMedia :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                    [_delegate ReloadFeeds];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            } :^(NSError *response_error)
             {
                 [[SharedClass SharedManager]removeLoader];
                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                 [self.view endEditing:YES];
             }];
        }
        else
        {
            [iOSRequest postMutliPartVideoData:UrlCreatePost :@"video" :_dictParameters :_dataMedia :^(NSDictionary *response_success) {
                [[SharedClass SharedManager]removeLoader];
                NSInteger value=[[response_success valueForKey:@"success"]integerValue];
                if (value==1)
                {
                    [_delegate ReloadFeeds];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            } :^(NSError *response_error)
             {
                 [[SharedClass SharedManager]removeLoader];
                 [[SharedClass SharedManager]AlertErrors:@"Error !!" :response_error.localizedDescription :@"OK"];
                 [self.view endEditing:YES];
             }];
        }
        
    }
    else
    {
        [[SharedClass SharedManager]removeLoader];
    }

}


-(void)CallDataSource
{
    
    if (_ArrayImages.count>0) {
        _constraintImageHeight.constant=120;
        CollectionViewCellConfigureBlock configureCell = ^(PostImagesCell *cell,id item)
        {
            cell.layer.cornerRadius=5.0f;
            [cell configureForCellWithCountry:item ];
        };
        
        
        self.datasource = [[MyGroupsDataSource alloc] initWithItems:_ArrayImages
                                                     cellIdentifier:CellIdentifierPostImagesCell
                                                 configureCellBlock:configureCell configureDelegateBlock:nil];
        self.collectionView.dataSource = _datasource;
        // self.collectionView.delegate= _datasource;
        [self.collectionView reloadData];
       
        [_addButton removeFromSuperview];
         FloatingButtonRemoved=YES;

    }
    else
    {
         _constraintImageHeight.constant=0;
    }
    
    
}

-(void)CallDataSourceVideo
{
    if (_ArrayVideos.count>0) {
         _constraintVideoHieght.constant=120;
        CollectionViewCellConfigureBlock configureCell = ^(PostVideoCell *cell,id item)
        {
            cell.layer.cornerRadius=5.0f;
            [cell configureForCellWithCountry:item ];
        };
        
        
        self.datasource = [[MyGroupsDataSource alloc] initWithItems:_ArrayVideos
                                                     cellIdentifier:CellIdentifierPostVideosCell
                                                 configureCellBlock:configureCell configureDelegateBlock:nil];
        self.collectionVideos.dataSource = _datasource;
        // self.collectionView.delegate= _datasource;
        [self.collectionVideos reloadData];
       [_addButton removeFromSuperview];
         FloatingButtonRemoved=YES;
        
    }
    else
    {
     _constraintVideoHieght.constant=0;
    }
    
    
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
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y)
    {
        if (_constraintTextViewHeight.constant<150)
        {
            _constraintTextViewHeight.constant=_constraintTextViewHeight.constant+20;
            
            [self adjustFrames];
        }
    }
    else if (currentRect.origin.y < previousRect.origin.y && _constraintTextViewHeight.constant>73)
    {
        _constraintTextViewHeight.constant=_constraintTextViewHeight.constant-20;
    }
    previousRect = currentRect;
    
    
    
}

-(void)adjustFrames
{
    CGRect textFrame = self.txtView.frame;
    textFrame.size.height = self.txtView.contentSize.height;
    self.txtView.frame = textFrame;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Type here"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        textView.text = @"Type here";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}



- (IBAction)btnBack:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPost:(id)sender
{
    [self.view endEditing:YES];
   
    if (!([_txtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) && ![_txtView.text isEqualToString:@"Type here"])
    {
      [[SharedClass SharedManager]Loader:self.view];
      [self loadData];  
    }
    
}
@end
