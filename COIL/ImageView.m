//
//  ImageView.m
//  COIL
//
//  Created by Aseem 13 on 15/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

-(void)getImage:(NSURL*)imageUrl :(BOOL)VideoAvailable
{
    
    NSURL *URLImage=imageUrl;
  //  _btnPlay.hidden=YES;
    [self.imageFile sd_setImageWithURL:URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
    
    if (VideoAvailable==YES) {
        _btnPlay.hidden=NO;
    }
    else
        _btnPlay.hidden=YES;
}

- (IBAction)btnCross:(id)sender {
    [self removeFromSuperview];
}
@end
