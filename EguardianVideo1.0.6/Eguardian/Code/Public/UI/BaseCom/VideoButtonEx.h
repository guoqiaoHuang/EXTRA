//
//  VideoButtonEx.h
//  CampusManager
//
//  Created by apple on 13-4-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoButtonEx : UIView
{
    UIButton                    *bgButton;
    UIImageView                 *defaultView;       //默认的图片
    UIImageView                 *carView;           //小汽车图片
    UILabel                     *name;              //名称
    BOOL                        photoFlag;          // false 表示没有东西  
}



@property(nonatomic,retain)UIButton*    bgButton;
@property(nonatomic,retain)UIImageView* defaultView;
@property(nonatomic,retain)UIImageView* carView;
@property(nonatomic,retain)UILabel*     name;
@property(nonatomic,assign)BOOL         photoFlag;



- (id)initWithFrame:(CGRect)frame flag:(BOOL)aflag;

-(void)layoutView;







@end






























































