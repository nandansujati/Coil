//
//  ImageView.m
//  COIL
//
//  Created by Aseem 13 on 15/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ImageView.h"

@interface ImageView()
@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)AVPlayerLayer *avPlayerLayer;
@end

@implementation ImageView

-(void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.avPlayer.currentItem];
    
}

-(void)playerItemDidReachEnd:(NSNotification*)noti
{
    [_avPlayerLayer removeFromSuperlayer];
}

-(void)getImage:(NSURL*)imageUrl :(BOOL)VideoAvailable :(NSString*)videoUrl
{
    _videoUrl=videoUrl;
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
    [_avPlayer pause];
    [_avPlayerLayer removeFromSuperlayer];
}

- (IBAction)btnPlay:(id)sender {
    if (_videoUrl!=nil) {
        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoPath,_videoUrl]];
        
        
        AVAsset *asset = [AVAsset assetWithURL:fileURL];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
        self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        
        _avPlayerLayer.frame = _imageFile.frame;
        [self.layer addSublayer:_avPlayerLayer];
        _avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.avPlayer play];

    }
}
@end
