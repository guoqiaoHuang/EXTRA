//
//  GradeClassViewController.h
//  Eguardian
//
//  Created by apple on 13-5-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol GradeClassDelegate <NSObject>
@optional
- (void) gradeClassData:(NSDictionary *)tempData;
@end



@interface GradeClassViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *mainTableView;
    
    float                   currentH ;
    NSArray                 *info;
    
    NSDictionary            *data;          //原始数据

    id                      delegate;       //委托
    
    BOOL                    retrunFlag;           //flag == ture 获取完标识就 ture 表示紧紧只获取班级和年级ID
    
    //判断是选择（用于语音通讯）
    BOOL                    isOneSelect;
    
}

@property(nonatomic, retain)UITableView *mainTableView;
@property(nonatomic, retain)NSArray *info;
@property(nonatomic, retain)NSDictionary *data;
@property(nonatomic, retain)id delegate;

-(void) loadTableView;



-(id) initWithDelegate:(id)adelegate;


-(id) initWithDelegate:(id)adelegate flag:(BOOL)retrunFlag;

-(id) initWithDelegate:(id)adelegate Select:(BOOL)aIsOneSelect;


@end















