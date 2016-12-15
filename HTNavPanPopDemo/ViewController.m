//
//  ViewController.m
//  HTNavPanPopDemo
//
//  Created by taotao on 11/12/2016.
//  Copyright © 2016 taotao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init] ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"swithRootViewControllerNotification" object:nil];
}

@end
