//
//  CTPopOutMenu.m
//  CT_PopOutMenu_Demo
//
//  Created by ChangChao-Tang on 2015/1/18.
//  Copyright (c) 2015年 ChangChao-Tang. All rights reserved.
//

#define TRANSITION_DURATION  0.3
#define SCREENSHOT_QUALITY  0.6

#import "CTPopOutMenu.h"

#pragma mark Category

@implementation UIView (ScreenShot)

-(UIImage*)screenShot{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage * screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * imageData = UIImageJPEGRepresentation(screenImage, SCREENSHOT_QUALITY);
    screenImage = [UIImage imageWithData:imageData];
    NSLog(@"%@",NSStringFromCGSize(screenImage.size));
    return screenImage;
}

-(UIImage*)screenShotOnScrolViewWithContentOffset:(CGPoint)offset{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -offset.x, -offset.y);
    [self.layer renderInContext:context];
    UIImage * screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * imageData = UIImageJPEGRepresentation(screenImage, SCREENSHOT_QUALITY);
    screenImage = [UIImage imageWithData:imageData];
    return screenImage;
}

@end

@implementation UIImage (Blur_and_Color_Filter)

-(UIImage*)blurWithRadius:(CGFloat)radius{
    CIImage * inputImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:inputImage forKey:@"inputImage"];
    [blurFilter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage * outputImage = [blurFilter outputImage];
    UIImage * blurImage = [UIImage imageWithCIImage:outputImage];
    
    return blurImage;
}

@end

#pragma mark CTPopoutMenuItem

@implementation CTPopoutMenuItem

-(instancetype)init{
    NSAssert(NO, @"Can't create with init");
    return nil;
}

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image{
    if (self = [super init]) {
        _title = title;
        _image = image;
        self.tintColor = [UIColor whiteColor];
    }
    return self;
}

@end

#pragma mark CTPopoutMenuItemView

@interface CTPopoutMenuItemView : UIView
@property (nonatomic)NSString * title;
@property (nonatomic)UILabel * titleLabel;
@property (nonatomic)UIImage * image;
@property (nonatomic)UIImageView * iconIamageView;
@end

@implementation CTPopoutMenuItemView

-(instancetype)initWithTitle:(NSString*)title image:(UIImage *)image{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconIamageView = [[UIImageView alloc]init];
        self.iconIamageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.iconIamageView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
        self.image = image;
    }
    return self;
}

-(void)layoutSubviews{
    
}

@end

#pragma mark CTPopoutMenu

@interface CTPopoutMenu ()
@property (nonatomic)UIImageView * blurView;
@property (nonatomic)NSMutableArray * itemViews;

@end

@implementation CTPopoutMenu

#pragma mark -LifeCycle

-(instancetype)init{
    NSAssert(NO, @"Can't create with init");
    return nil;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items{
    if (self = [super init]) {
        _items = items;
        _titleText = title;
        _messageText = message;
        _menuView = [UIView new];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.highlightColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        self.borderColor = [UIColor whiteColor].CGColor;
        self.borderRadius = 5;
        self.blurLevel = 3;
        self.menuStyle = MenuStyleDefault;
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message images:(NSArray *)images{
    NSMutableArray * items = [NSMutableArray new];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:nil image:(UIImage*)obj];
        [items addObject:item];
    }];
    return [self initWithTitle:title message:message items:items];
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message itemTitles:(NSArray *)itemTitles{
    NSMutableArray * items = [NSMutableArray new];
    [itemTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:(NSString*)obj image:nil];
        [items addObject:item];
    }];
    return [self initWithTitle:title message:message items:items];
}

#pragma mark -Private

-(void)ct_addToParentVC:(UIViewController*)parentVC withAnimation:(BOOL)animate{
    [parentVC addChildViewController:self];
    [parentVC.view addSubview:self.view];
    [self createScreenshotwithComleteAction:nil];
}

-(void)ct_removeFromParentVCwithAnimation:(BOOL)animate{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    [self.blurView removeFromSuperview];
}

#pragma mark -Animation

-(void)showMenuInParentViewController:(UIViewController *)parentVC withCenter:(CGPoint)center{
    [self ct_addToParentVC:parentVC withAnimation:YES];
    self.menuView.center = center;
    self.view.frame = parentVC.view.bounds;
    self.blurView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.blurView];
}

-(void)createScreenshotwithComleteAction:(dispatch_block_t)completeAction{
    if (self.blurLevel >0.0) {
        UIImage * screenshot = nil;
        if ([self.parentViewController.view isKindOfClass:[UIScrollView class]]) {
            screenshot = [self.parentViewController.view screenShotOnScrolViewWithContentOffset:[(UIScrollView*)self.parentViewController.view contentOffset]];
        }else{
            screenshot = [self.parentViewController.view screenShot];
        }
        if (completeAction != nil) {
            completeAction();
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * blurImage = [screenshot blurWithRadius:self.blurLevel];
            dispatch_async(dispatch_get_main_queue(), ^{
                CATransition * transition = [CATransition animation];
                transition.duration = TRANSITION_DURATION;
                transition.type = kCATransitionFade;
                self.blurView.image = blurImage;
                [self.blurView.layer addAnimation:transition forKey:nil];
                [self.view setNeedsLayout];
            });
        });
    }
    
}

#pragma mark -Layout

-(void)layoutMenuView{
    self.menuView.backgroundColor = _backgroundColor;
    
}



#pragma mark -ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

-(void)dealloc{
    
}

#pragma mark -Touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self ct_removeFromParentVCwithAnimation:YES];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


@end
