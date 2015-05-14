//
//  SeatsAttendanceController.h
//  Eguardian
//
//  Created by apple on 13-6-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SeatsData.h"
#import "DatePickerView.h"
@interface SeatsAttendanceController : BaseViewController<UITableViewDelegate, UITableViewDataSource,DatePickerViewDelegate>
{
    UITableView             *mainTableView;
    UILabel                 *userMessageLabel;
    UILabel                 *dateLable;
    
    
    
    NSDate                  *date;                  //记录当前选中的时间
    float                   currentH ;
    SeatsData               *info;
    
    DatePickerView          *dataDatePicker;
}

@property(nonatomic, retain)UITableView *mainTableView;



@property(nonatomic, retain)UILabel *userMessageLabel;
@property(nonatomic, retain)UILabel *dateLable;

@property(nonatomic, retain)NSDate *date;

@property(nonatomic, retain)SeatsData *info;

@property(nonatomic, retain)DatePickerView *dataDatePicker;


@end

























































