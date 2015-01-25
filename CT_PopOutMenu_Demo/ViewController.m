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
    NSMutableArray * items = [NSMutableArray new];
    for (int i =0; i<6; i++) {
        CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:[NSString stringWithFormat:@"item%d",i] image:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]]];
        [items addObject:item];
    }
    self.popMenu = [[CTPopoutMenu alloc]initWithTitle:@"Test Title I want to test the auto break title" message:@"test message: this is a test message for the popout menu test test test..." items:items];
    
}

- (IBAction)showList:(id)sender {
    self.popMenu.menuStyle = MenuStyleList;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
}
- (IBAction)showDefault:(id)sender {
    self.popMenu.menuStyle = MenuStyleDefault;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
}
- (IBAction)showOval:(id)sender {
    self.popMenu.menuStyle = MenuStyleOval;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch*touch in touches) {
        CGPoint loc = [touch locationInView:self.view];
        [self.popMenu showMenuInParentViewController:self withCenter:loc];
    }
}


@end
