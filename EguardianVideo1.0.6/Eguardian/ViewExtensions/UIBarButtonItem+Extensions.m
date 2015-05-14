//
//  UIBarButtonItem+Extensions.m
//  MobileCloud
//
//  Created by S.C.S on 13-7-18.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import "UIBarButtonItem+Extensions.h"

@implementation UIBarButtonItem (Extensions)

+ (UIBarButtonItem*)ecarBack:(id)delegate Type:(BackImageType) type
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.showsTouchWhenHighlighted = YES;
    UIImage *backImg = nil;
    if (type == BackImage1) {
        backImg = [UIImage imageNamed:@"back1"];
    }else {
        backImg = [UIImage imageNamed:@"back2"];
    }
    
    [backButton setBackgroundImage:backImg forState:UIControlStateNormal];
//    [backButton setBackgroundImage:backImgs forState:UIControlStateHighlighted];
//    backButton.contentEdgeInsets = (UIEdgeInsets){.left=10.0f,.right=5.0f,.top=3.0f,.bottom=3.0f};
//    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [backButton addTarget:delegate action:@selector(homeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 5, 50, 30);
    UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    return leftItem;
}

+ (UIBarButtonItem*)ecarbackButtonPressed:(id)delegate
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.contentEdgeInsets = (UIEdgeInsets){.left=10.0f,.right=5.0f,.top=3.0f,.bottom=3.0f};
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    backButton.frame = CGRectMake(0, 5, 50, 30);
    UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    return leftItem;
}

+ (UIBarButtonItem*)viewRightItem:(id)delegate Name:(NSString *) title ImageStr:(NSString *) imageStr Rect:(CGRect) frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.showsTouchWhenHighlighted = YES;
    UIImage *img = [UIImage imageNamed:imageStr];
    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
//    [btn setBackgroundImage:imgPressed forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [btn addTarget:delegate action:@selector(rightItemPressed) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    return rightItem;
}

+ (UIBarButtonItem*)viewRightItem:(id)delegate image:(NSString *) imageStr pressed:(NSString *) pressedImageStr
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.showsTouchWhenHighlighted = YES;
    UIImage *img = [UIImage imageNamed:imageStr];
    img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:img.size.height/2];
    UIImage *imgPressed = [UIImage imageNamed:imageStr];
    imgPressed = [imgPressed stretchableImageWithLeftCapWidth:20 topCapHeight:imgPressed.size.height/2];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setBackgroundImage:imgPressed forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = (UIEdgeInsets){.left=10.0f,.right=5.0f,.top=3.0f,.bottom=3.0f};
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [btn addTarget:delegate action:@selector(rightItemPressed) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    return rightItem;
}

//加载 UIActivityIndicatorView
+ (UIBarButtonItem*)viewRightInActivity{
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [activityView sizeToFit];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    [activityView startAnimating];
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithCustomView:activityView] autorelease];
    [activityView release];
     return rightItem;
}

+ (UIBarButtonItem*)viewRightNILView
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.contentEdgeInsets = (UIEdgeInsets){.left=10.0f,.right=5.0f,.top=3.0f,.bottom=3.0f};
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    backButton.frame = CGRectMake(0, 5, 50, 30);
    UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    return leftItem;
}

@end
