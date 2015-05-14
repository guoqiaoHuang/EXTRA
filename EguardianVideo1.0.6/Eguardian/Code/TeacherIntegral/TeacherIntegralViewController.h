//
//  TeacherIntegralViewController.h
//  Eguardian
//
//  Created by S.C.S on 13-8-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//老师的积分
@interface TeacherIntegralViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

//从后台返回的t积分数据
@property (nonatomic, retain) NSDictionary *integralDic;

@property (nonatomic, retain) UIButton * leftBtn;

@property (nonatomic, retain) UIButton * rightBtn;

@end
