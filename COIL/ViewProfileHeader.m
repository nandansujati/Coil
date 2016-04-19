//
//  ViewProfileHeader.m
//  COIL
//
//  Created by Aseem 13 on 18/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewProfileHeader.h"

@implementation ViewProfileHeader

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ViewProfileHeader" owner:self options:nil] lastObject];
        [self setFrame:frame];
        
    }
    return self;
}

- (void)awakeFromNib {
    
   
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_ImageBackground.bounds.size.height);
    
    // Add colors to layer
    UIColor *centerColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:0.3];
  //  UIColor *endColor = [UIColor grayColor];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       
                       nil];
    
    [self.ImageBackground.layer insertSublayer:gradient atIndex:0];
    
}

- (IBAction)btnBack:(id)sender {
    [_delegate btnBackPressed];
}
@end
