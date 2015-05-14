//
//  UIBarButtonItem+Extensions.h
//  MobileCloud
//
//  Created by S.C.S on 13-7-18.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
	BackImage1 = 11,   
    BackImage2  = 12   
    
} BackImageType;   //返回图片选择

@interface UIBarButtonItem (Extensions)

+ (UIBarButtonItem*)ecarBack:(id)delegate Type:(BackImageType) type;

+ (UIBarButtonItem*)ecarbackButtonPressed:(id)delegate;

+ (UIBarButtonItem*)viewRightItem:(id)delegate Name:(NSString *) title ImageStr:(NSString *) imageStr Rect:(CGRect) frame;

+ (UIBarButtonItem*)viewRightItem:(id)delegate image:(NSString *) imageStr pressed:(NSString *) pressedImageStr;

//加载 UIActivityIndicatorView
+ (UIBarButtonItem*)viewRightInActivity;

+ (UIBarButtonItem*)viewRightNILView;

@end
