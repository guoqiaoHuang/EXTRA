/*
 *  Copyright (c) 2013 The CCP project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a Beijing Speedtong Information Technology Co.,Ltd license
 *  that can be found in the LICENSE file in the root of the web site.
 *
 *                    http://www.cloopen.com
 *
 *  An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

@implementation UINavigationBar (Customized)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"top_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end


#import "CommonTools.h"
#import "SHButton.h"
#import "Global.h"

@implementation CommonTools

+ (UIButton*) navigationItemBtnInitWithTitle:(NSString*)title target:(id)target action:(SEL)actMethod {
    UIButton* itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont* font = [UIFont boldSystemFontOfSize:14];
    CGSize titlesize = [title sizeWithFont:font];
    itemBtn.frame = CGRectMake(0, 0, titlesize.width+20, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
//    UIEdgeInsets titleInset = itemBtn.titleEdgeInsets;
//    titleInset.left = 10.0f;
//    itemBtn.titleEdgeInsets = titleInset;
    itemBtn.titleLabel.font = font;
    [itemBtn setBackgroundImage:[[UIImage imageNamed: @"button01_off.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[[UIImage imageNamed: @"button01_on.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateHighlighted];
    [itemBtn addTarget:target action:actMethod forControlEvents:UIControlEventTouchUpInside];
    return itemBtn;
}

+ (UIButton*) navigationItemNewBtnInitWithTitle:(NSString*)title target:(id)target action:(SEL)actMethod {
    UIButton* itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont* font = [UIFont boldSystemFontOfSize:14];
    CGSize titlesize = [title sizeWithFont:font];
    itemBtn.frame = CGRectMake(0, 0, titlesize.width+36-titlesize.height, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
    itemBtn.titleLabel.font = font;
    [itemBtn setBackgroundImage:[[UIImage imageNamed: @"view_image_bg_icon.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[[UIImage imageNamed: @"view_image_bg_icon_on.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateHighlighted];
    [itemBtn addTarget:target action:actMethod forControlEvents:UIControlEventTouchUpInside];
    return itemBtn;
}

+ (SHButton *) navigationItemNewBtnInitWithTitle:(NSString*)title target:(id)target action:(SEL)actMethod Width:(float) width{
    UIImage *img = [UIImage imageNamed:@"choose_normal.png"];
    SHButton *bt = [[SHButton alloc] initWithFrame:CGRectMake(0,0 , width, img.size.height)];
    [bt.contentLb setFont:[UIFont systemFontOfSize:14.0]];
    bt.contentLb.textColor = Black66666;
    bt.contentLb.text = title;
    img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:img.size.height/2];
    UIImage *selectImg = [UIImage imageNamed:@"choose_normal.png"];
    selectImg = [selectImg stretchableImageWithLeftCapWidth:selectImg.size.width/2 topCapHeight:selectImg.size.height/2];
    [bt setBackgroundImage:img forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [bt setBackgroundImage:selectImg forState:UIControlStateSelected];
    [bt addTarget:target action:actMethod forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

@end
