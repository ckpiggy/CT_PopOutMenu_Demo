//
//  ViewController.m
//  CT_PopOutMenu_Demo
//
//  Created by ChangChao-Tang on 2015/1/18.
//  Copyright (c) 2015年 ChangChao-Tang. All rights reserved.
//

#import "ViewController.h"
#import "CTPopOutMenu.h"

@interface ViewController ()<CTPopoutMenuDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) CTPopoutMenu * popMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    [circleLayer setPosition:CGPointMake(self.imageView.bounds.size.width/2, self.imageView.bounds.size.height/2)];
    [circleLayer setBounds:self.imageView.bounds];
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.imageView.bounds];
    [circleLayer setPath:path.CGPath];
    self.imageView.layer.mask = circleLayer;
    NSMutableArray * items = [NSMutableArray new];
    for (int i =0; i<6; i++) {
        CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:[NSString stringWithFormat:@"item%d",i] image:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]]];
        [items addObject:item];
    }
    self.popMenu = [[CTPopoutMenu alloc]initWithTitle:@"Test Title I want to test the auto break title" message:@"test message: this is a test message for the popout menu test test test..." items:items];
    self.popMenu.delegate = self;
}

-(void)menu:(CTPopoutMenu *)menu willDismissWithSelectedItemAtIndex:(NSUInteger)index{
    NSLog(@"menu dismiss with index %ld",index);
}

-(void)menuwillDismiss:(CTPopoutMenu *)menu{
    NSLog(@"menu dismiss");
}

- (IBAction)showList:(id)sender {
    self.popMenu.menuStyle = MenuStyleList;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
}
- (IBAction)showDefault:(id)sender {
    self.popMenu.menuStyle = MenuStyleDefault;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
    [self.popMenu.activityIndicator startAnimating];
}
- (IBAction)showOval:(id)sender {
    self.popMenu.menuStyle = MenuStyleOval;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
    [self.popMenu.activityIndicator startAnimating];
}
- (IBAction)showGrid:(id)sender {
    self.popMenu.menuStyle = MenuStyleGrid;
    [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
    
}




@end
