//
//  CustomButton.m
//  COIL
//
//  Created by Aseem 9 on 09/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

+ (id)buttonWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame] ;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        [self.layer setCornerRadius:4.0f];
   
    }
    return self;
}
@end
