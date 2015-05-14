//
//  DatePickerView.m
//  UIDataDemo
//
//  Created by apple on 13-5-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
@synthesize datePicker;
//@synthesize selectDate;
@synthesize delegate;

- (void)dealloc
{
    [datePicker release];
    [super dealloc];
}




-(void)cancleAction
{
    self.hidden = YES;
}

-(void)okAction
{
    self.hidden = YES;
    [self.delegate selectDateFinish];
}


-(void) initSubViews
{
    
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - datePicker.frame.size.height - 52)/2.0,
//                                                                  self.frame.size.width, 52)];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - datePicker.frame.size.height - 52,
                                                              self.frame.size.width, 52)];
    {
        
        bgView.backgroundColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:154/255.0 alpha:1.0];
        
        UIImage *cancleImg = [UIImage imageNamed:@"视频选择取消按钮.png"];
        UIImage *okImg = [UIImage imageNamed:@"视频选择确定按钮.png"];
        
        
        {
            UIButton *cbt = [UIButton buttonWithType:UIButtonTypeCustom];
            [cbt setImage:cancleImg forState:UIControlStateNormal];
            cbt.frame = CGRectMake(10, (bgView.frame.size.height - cancleImg.size.height)/2.0,
                               cancleImg.size.width, cancleImg.size.height);
            [cbt addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchDown];
            [bgView addSubview:cbt];
        }
        
        {
            UIButton *okBt = [UIButton buttonWithType:UIButtonTypeCustom];
            [okBt setImage:okImg forState:UIControlStateNormal];
            okBt.frame = CGRectMake((self.frame.size.width - okImg.size.width - 10),
                                    (bgView.frame.size.height - okImg.size.height)/2.0,
                               okImg.size.width, okImg.size.height);
            [okBt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchDown];
            [bgView addSubview:okBt];
        }
    }
    
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.frame = CGRectMake(0, bgView.frame.size.height+bgView.frame.origin.y, datePicker.frame.size.width, datePicker.frame.size.height);
    [self addSubview:datePicker];
    [self addSubview:bgView];
    [bgView release];
    
}



- (id)initWithDelegate:(id)adelegate
{
    float w = [UIScreen mainScreen].applicationFrame.size.width;
    float h = [UIScreen mainScreen].applicationFrame.size.height-44;
    
    self = [super initWithFrame:CGRectMake(0, 0, w, h)];
    if (self)
    {
        self.delegate = adelegate;
        datePicker = [[UIDatePicker alloc] init];
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];
        [self initSubViews];
        
        
    }
    return self;
}


@end










































