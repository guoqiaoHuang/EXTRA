//
//  DatePickerView.h
//  UIDataDemo
//
//  Created by apple on 13-5-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>
@optional
- (void) selectDateFinish;
@end
@interface DatePickerView : UIView
{
    UIDatePicker        *datePicker;
    id                  delegate;
}


@property(nonatomic,retain)UIDatePicker *datePicker;
@property(nonatomic,assign)id           delegate;


- (id)initWithDelegate:(id)adelegate;

@end









































