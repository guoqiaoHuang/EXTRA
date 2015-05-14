//
//  CheckWorkViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CheckWorkData.h"
#import "DatePickerView.h"
@interface CheckWorkViewController :  BaseViewController<UITableViewDelegate, UITableViewDataSource,DatePickerViewDelegate>
{
    UITableView             *mainTableView;
    UILabel                 *userMessageLabel;
    UILabel                 *dateLable;
    
    
    
    NSDate                  *date;                  //记录当前选中的时间
    float                   currentH ;
    CheckWorkData           *info;                  
    
    DatePickerView          *dataDatePicker;       
}

@property(nonatomic, retain)UITableView *mainTableView;



@property(nonatomic, retain)UILabel *userMessageLabel;
@property(nonatomic, retain)UILabel *dateLable;

@property(nonatomic, retain)NSDate *date;

@property(nonatomic, retain)CheckWorkData *info;

@property(nonatomic, retain)DatePickerView *dataDatePicker;


@end
