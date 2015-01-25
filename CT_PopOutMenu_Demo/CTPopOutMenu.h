//  Created by ChangChao-Tang on 2015/1/18.
//  Copyright (c) 2015年 ChangChao-Tang. All rights reserved.
//



#import <UIKit/UIKit.h>
@class CTPopoutMenu;

typedef enum : NSUInteger {
    MenuStyleDefault,
    MenuStyleList,
    MenuStyleOval,
    MenuStyleGrid,
} PopoutMenuStyle;


@interface CTPopoutMenuItem : NSObject

@property (nonatomic,readonly) NSString * title;
@property (nonatomic,readonly) UIImage * image;
@property (nonatomic) UIColor * tintColor, * backgroundColor;
//default tintColor is whiteColor
//default backgroundColor is clearColor
@property (nonatomic) NSTextAlignment textAligment;
//default textAligment is NSTextAligmentCenter
@property (nonatomic) UIFont * font;
//defaut font is system font with size 14

-(instancetype)initWithTitle:(NSString*)title image:(UIImage*)image;


@end

@protocol CTPopoutMenuDelegate <NSObject>

-(void)menu:(CTPopoutMenu*)menu willDismissWithSelectedItemAtIndex:(NSUInteger)index;
-(void)menuwillDismiss:(CTPopoutMenu *)menu ;

@end

@interface CTPopoutMenu : UIViewController

@property (nonatomic,readonly) NSString * titleText, * messageText;
//the title and message of the menu
@property (nonatomic)UIFont * titleFont, * messageFont;
//the font of title and message
@property (nonatomic)NSTextAlignment textAligment;
//default is NSTextAligmentCenter
@property (nonatomic,readonly) NSArray * items;
//the buttons of the menu
@property (nonatomic,readonly) UIView * menuView;
//the menuView of the PopoutMenu
@property (nonatomic) UIActivityIndicatorView * activityIndicator;
//ActivityIndicatorView of menuView default style is UIActivityIndicatorViewStyleWhite
@property (nonatomic) UIColor * backgroundColor, * highlightColor, *tintColor;
//backgroundColor of menuView, the default color is black with alpha 0.75
//highlightColor of items, the default color is white with alpha 0.5
@property (nonatomic) CGColorRef borderColor;
//borderColor of menuView, default color is white
@property (nonatomic) CGFloat blurLevel, borderRadius, borderWidth;
//blurRadius of backgroundView, default value is 3.5(0~4)
//borderRadius of menuView, default is 5
@property (nonatomic) PopoutMenuStyle menuStyle;
@property (nonatomic) id<CTPopoutMenuDelegate>delegate;

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items;
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message images:(NSArray *)images;
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message itemTitles:(NSArray *)itemTitles;

-(void)showMenuInParentViewController:(UIViewController*)parentVC withCenter:(CGPoint)center;
-(void)dismissMenu;

@end

