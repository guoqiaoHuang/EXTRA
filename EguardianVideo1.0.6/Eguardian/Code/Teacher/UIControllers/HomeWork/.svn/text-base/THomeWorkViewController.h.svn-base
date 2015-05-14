//
//  HomeWorkViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "THomeWorkData.h"
#import "DatePickerView.h"

//作 业
@interface THomeWorkViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,DatePickerViewDelegate>
{
    UITableView             *mainTableView;
    UILabel                 *userMessageLabel;
    UILabel                 *dateLable;
    
    
    NSDate                  *date;                  //记录当前选中的时间
    float                   currentH ;
    
    THomeWorkData            *info;
    
    DatePickerView          *dataDatePicker;
    
}

@property(nonatomic, retain)UITableView *mainTableView;
@property(nonatomic, retain)UILabel *userMessageLabel;
@property(nonatomic, retain)UILabel *dateLable;
@property(nonatomic, retain)NSDate *date;
@property(nonatomic, retain)THomeWorkData *info;
@property(nonatomic, retain)DatePickerView *dataDatePicker;
@property(nonatomic, assign) BOOL isPopToRoot;

-(void) refreshMainTableView;

@end
