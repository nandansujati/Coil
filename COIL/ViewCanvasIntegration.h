//
//  ViewCanvasIntegration.h
//  COIL
//
//  Created by Aseem 9 on 08/04/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@protocol btnPressedfromCanvasView
-(void)btnCrossPressed;
@end
@interface ViewCanvasIntegration : UIView
@property(nonatomic,strong)id<btnPressedfromCanvasView>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCanvas;
@property(nonatomic,strong)NSArray *GroupsArray;
- (IBAction)btnCross:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@end
