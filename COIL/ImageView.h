//
//  ImageView.h
//  COIL
//
//  Created by Aseem 13 on 15/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface ImageView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

-(void)getImage:(NSURL*)imageUrl :(BOOL)VideoAvailable;
@property (weak, nonatomic) IBOutlet UIImageView *imageFile;
- (IBAction)btnCross:(id)sender;
@end
