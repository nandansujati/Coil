//
//  ViewHeaderGroupDetail.m
//  COIL
//
//  Created by Aseem 9 on 22/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "ViewHeaderGroupDetail.h"

@implementation ViewHeaderGroupDetail


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

@end
