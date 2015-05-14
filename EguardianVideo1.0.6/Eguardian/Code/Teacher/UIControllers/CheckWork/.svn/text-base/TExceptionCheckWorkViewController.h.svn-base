//
//  TExceptionCheckWorkViewController.h
//  Eguardian
//
//  Created by S.C.S on 13-10-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNPopupView.h"
#import "BaseViewController.h"

@class NavTriangleTitleView;

//异常考勤
@interface TExceptionCheckWorkViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>{
    SNPopupView                     *popup;
    
    float popupHeight;
    
    BOOL triangle180;
    
    BOOL isAllSelect;
}

@property(nonatomic, retain)UITableView *mainTableView;

//从班级（GradeClassViewController）里面复制这个属性
@property(nonatomic, retain) NSArray *classList;

@property(nonatomic, retain) NavTriangleTitleView *titleView;

@property(nonatomic, retain) UITableView *popupTableView;

@property(nonatomic, retain) NSMutableArray *studentList;

//@property (nonatomic, retain) UIButton * leftBtn;
//
//@property (nonatomic, retain) UIButton * rightBtn;

@end
