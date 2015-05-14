//
//  CheckWorkCell.m
//  Eguardian
//
//  Created by S.C.S on 13-10-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckWorkCell.h"
#import "Global.h"

@implementation CheckWorkCell
@synthesize mDelegate;

- (void)dealloc{
    mDelegate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)delegate
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mDelegate = delegate;
        [self initView];
    }
    return self;
}

- (void)initView{
    float originX = 11;
    float originY = 10;
    //57.5 + 20
    float width = ( 320 - 15 * 2 - 20 * 3 ) / 4.0;
//    float height = width;
    for (int i = 0; i< 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         UIImage *image = [UIImage imageNamed:@"whiteColor.png"];
        btn.frame = CGRectMake(originX + (width + 20) * i, originY, image.size.width, image.size.height);
       
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        UIImage *selectImage = [UIImage imageNamed:@"redColor.png"];
//        拉伸
        selectImage = [selectImage stretchableImageWithLeftCapWidth:selectImage.size.width/2 topCapHeight:selectImage.size.height/2];
        [btn setTitleColor:Black66666 forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
        [btn addTarget:mDelegate action:@selector(pressedButton:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = CheckWorkCellBtnTag + i;
        btn.hidden = YES;
        [self addSubview:btn];
    }
}

- (void)setBtnHidden{
    for (int i = 0; i< 4; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:CheckWorkCellBtnTag + i];
        btn.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
