//
//  CTPopOutMenu.m
//  CT_PopOutMenu_Demo
//
//  Created by ChangChao-Tang on 2015/1/18.
//  Copyright (c) 2015年 ChangChao-Tang. All rights reserved.
//

#import "CTPopOutMenu.h"

#pragma mark Category

@implementation UIView (ScreenShot)

-(UIImage*)screenShot{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage * screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * imageData = UIImageJPEGRepresentation(screenImage, 0.6);
    screenImage = [UIImage imageWithData:imageData];
    return screenImage;
}

-(UIImage*)screenShotOnScrolViewWithContentOffset:(CGPoint)offset{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -offset.x, -offset.y);
    [self.layer renderInContext:context];
    UIImage * screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * imageData = UIImageJPEGRepresentation(screenImage, 0.6);
    screenImage = [UIImage imageWithData:imageData];
    return screenImage;
}

@end

@implementation UIImage (Blur_and_Color_Filter)

-(UIImage*)blurWithRadius:(CGFloat)radius{
    CIImage * inputImage = self.CIImage;
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
    }
    return self;
}

@end

#pragma mark CTPopoutMenu

@interface CTPopoutMenu ()
@property (nonatomic)UIView * blurView;
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
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.highlightColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        self.borderColor = [UIColor whiteColor].CGColor;
        self.borderRadius = 5;
        self.blurRadius = 3.5;
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

#pragma mark -Animation

-(void)showMenuInParentViewController:(UIViewController *)parentVC withCenter:(CGPoint)center{
    
}

#pragma mark -ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}




@end
