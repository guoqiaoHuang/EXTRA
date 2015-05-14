//
//  UIButtonEx.h
//  RDOA
//
//  Created by apple on 13-3-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonEx : UIView
{
    UIButton                    *bgButton;
    UIImageView                 *bgLight;
    UIImageView                 *phoneView;        //默认显示图片
    UIImage                     *defualtImg;       //默认的图片
    UIImage                     *selectImg;        //选中的图片   即高亮的图片
    UILabel                     *label;
}

@property(nonatomic,retain)UIButton     *bgButton;
@property(nonatomic,retain)UIImageView  *phoneView;
@property(nonatomic,retain)UIImage      *defualtImg;
@property(nonatomic,retain)UIImage      *selectImg;
@property(nonatomic,retain)UIImageView  *bgLight;
@property(nonatomic,retain)UILabel      *label;



- (id)initWithFrame:(CGRect)aframe text:(NSString *)atext defualtImgName:(NSString *)dname  selectImgName:(NSString *)sname;



-(void) highLight:(BOOL)afalg;


@end
