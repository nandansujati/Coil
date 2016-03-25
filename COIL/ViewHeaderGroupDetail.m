//
//  ViewHeaderGroupDetail.m
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewHeaderGroupDetail.h"

@implementation ViewHeaderGroupDetail




-(void)awakeFromNib
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_imageGroup.frame.size.height);
    
    // Add colors to layer
    UIColor *centerColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:0.25];
    UIColor *endColor = [UIColor grayColor];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[centerColor CGColor],
                       (id)[endColor CGColor],
                       nil];
    
    [self.imageGroup.layer insertSublayer:gradient atIndex:0];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_imageGroup addGestureRecognizer:gesture];
   // gesture.delegate = self;
    self.imageGroup.userInteractionEnabled=YES;
    self.imageGroup.clipsToBounds = YES;
    
}


-(void)handleTap:(UITapGestureRecognizer*)gesure
{
    [_delegate imagePressed];
}
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ViewHeaderGroupDetail" owner:self options:nil] lastObject];
        [self setFrame:frame];
    }
    return self;
}

- (IBAction)btnBack:(id)sender;
{
    [_delegate btnBackPressed];
}

- (IBAction)btnEdit:(id)sender
{
    [_delegate btnEditPressed];
    
}

- (IBAction)btnDiscoverabilty:(id)sender {
    [_delegate btnDiscoverablitypPressed];
}
- (IBAction)btnNotifications:(id)sender {
    [_delegate btnNotificationsPressed];
}
@end
