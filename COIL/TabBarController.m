//
//  TabBarController.m
//  COIL
//
//  Created by Aseem 9 on 01/03/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
  //  [selectedViewController viewWillAppear:YES];
   
}
@end
