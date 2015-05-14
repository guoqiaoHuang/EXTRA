//
//  ContactPeopleViewController.h
//  Eguardian
//
//  Created by S.C.S on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNPopupView.h"
#import "UIBaseViewController.h"

@class NavTriangleTitleView;

//通讯录
@interface ContactPeopleViewController : UIBaseViewController<UITableViewDelegate, UITableViewDataSource>{
    SNPopupView                     *popup;
    
    float popupHeight;
    
    BOOL triangle180;
    
    BOOL isAllSelect;
    
    NSInteger cellBtnCount;
    
    //全班（0、不是全班、1为全班）
    BOOL isWholeClass;
}

@property(nonatomic, retain)UITableView *mainTableView;

//从班级（GradeClassViewController）里面复制这个属性
@property(nonatomic, retain) NSArray *classList;

@property(nonatomic, retain) NavTriangleTitleView *titleView;

@property(nonatomic, retain) UITableView *popupTableView;

@property(nonatomic, retain) NSMutableArray *studentList;

@property(nonatomic, retain) NSString *groupId;

@property(nonatomic, retain) NSString *groupIDName;

//记录添回群成员的数据
@property (nonatomic, retain) NSArray *accountsArray;

@property (assign, nonatomic) UIViewController     *backView;

//联系人的信息(单聊)
@property (nonatomic, retain) NSDictionary *connectInfo;


@end
