//
//  DummyImagesCell.m
//  COIL
//
//  Created by Aseem 13 on 19/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "DummyImagesCell.h"

@implementation DummyImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)configureForCellWithCountry:(NSString *)image
{
    if (![image isEqualToString:@""])
    {
        NSURL *_URLImage=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/150/150",ImagePath,image]];
        [self.image sd_setImageWithURL:_URLImage placeholderImage:[UIImage imageNamed:@"img_placeholder_group"]];
        
        
    }
}
@end
