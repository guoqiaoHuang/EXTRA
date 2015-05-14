//
//  Global.m
//  Eguardian
//
//  Created by S.C.S on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Global.h"

@implementation BottonView

- (id) initWithFrame:(CGRect)frame ID:(id) delegate{
    
    if ((self = [super initWithFrame:frame])) {
        
        UIImage *image = [UIImage imageNamed:@"Main_Btn_Blue.png"];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [bt addTarget:delegate action:@selector(bottonViewPressedBtn) forControlEvents:UIControlEventTouchUpInside];
        
        bt.frame = CGRectMake((320 - 180) / 2, 4.5, 180, 41);
        [bt setBackgroundImage:[image stretchableImageWithLeftCapWidth:21 topCapHeight:12] forState:UIControlStateNormal];
        [bt setTitle:@"提交" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:bt];
        delegate = nil;
    }
    return self;
}

- (void)dealloc{
    
    [super dealloc];
}

@end

@implementation NavTriangleTitleView
@synthesize mDelegate;
@synthesize title;
@synthesize mBtn;


- (void)dealloc{
    self.mDelegate = nil;
    [title release];
    [mBtn release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame Delegate:(id) delegate
{
    if (self = [super initWithFrame:frame]) {
        self.mDelegate = delegate;
        [self initView];
    }
    return self;
}

- (void)initView{
    {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0 , self.frame.size.width - 40, self.frame.size.height)];
        [l setTextAlignment:NSTextAlignmentRight];
        [l setFont:[UIFont systemFontOfSize:NavTriangleTitle]];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor whiteColor];
        self.title = l;
        [self addSubview:l];
        [l release];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.frame.size.width - 40 , 0, 40, 40);
        UIImage *image = [UIImage imageNamed:@"andown.png"];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:mDelegate action:@selector(trianglePressedBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
//        self.mBtn.hidden = YES;
        self.mBtn = btn;
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.title.frame = CGRectMake(0 , 0 , self.frame.size.width - 40, self.frame.size.height);
    self.mBtn.frame = CGRectMake(self.frame.size.width - 40 , 0, 40, 40);
}

@end

