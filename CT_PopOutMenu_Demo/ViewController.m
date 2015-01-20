//
//  ViewController.m
//  CT_PopOutMenu_Demo
//
//  Created by ChangChao-Tang on 2015/1/18.
//  Copyright (c) 2015年 ChangChao-Tang. All rights reserved.
//

#import "ViewController.h"
#import "CTPopOutMenu.h"

@interface ViewController ()
@property (nonatomic) CTPopoutMenu * popMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]];
    self.popMenu = [[CTPopoutMenu alloc]initWithTitle:nil message:nil images:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
}

@end
