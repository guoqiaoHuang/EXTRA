//
//  MyHUD.h
//  NewYearText2
//
//  Created by 林明智 on 13-7-28.
//  Copyright (c) 2013年 林明智. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LABELFONTSIZE 16.0f
#define LABELDETAILSFONTSIZE 12.0f
#define PADDING 6.0f

typedef enum {
    
	FillViewModel = 11,   //huh填满整个View
    PartViewModel  = 12   //只一部分
    
} FrameModel;   //类型

@interface MyHUD : UIView{
    
}

@property (nonatomic, retain) UIView *indicator;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *detailsLabel;
@property (nonatomic, retain) NSString *labelText;
@property (nonatomic, assign)float width;
@property (nonatomic, assign)float height;
@property (nonatomic, assign)float xOffset;
@property (nonatomic, assign)float yOffset;
@property (nonatomic, assign)float margin;
@property (nonatomic, retain) UIFont* labelFont;
@property (nonatomic, retain)NSString *detailsLabelText;
@property (nonatomic, retain)UIFont *detailsLabelFont;
@property (nonatomic, assign)float opacity;

@property (nonatomic, retain) UIView *hud;
@property (nonatomic, assign) FrameModel  frameModel;

- (id)initWithFrame:(CGRect)frame Model:(FrameModel) aModel;

- (void)setFitView:(NSString *) alabelText ;

@end
