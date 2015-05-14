//
//  SurveillanceVdeoViewController.h
//  Eguardian
//
//  Created by S.C.S on 13-8-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "VMSNetSDK.h"
#import "VMSNetSDKDataType.h"

//视频监控
@interface SurveillanceVdeoViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *titleArray;
    dispatch_queue_t aQueue;
    
}

//controlUnitList,regionList,regionList 组合
@property (nonatomic, retain) NSMutableArray *list;

//登录信息
@property (nonatomic, retain) CMSPInfo *cmspInfo;

//视频IP地址
@property (nonatomic, retain) NSString *vdeoIPAddress;

//视频登录名称
@property (nonatomic, retain) NSString *vdeoUserName;


//视频登录密码
@property (nonatomic, retain) NSString *vdeoPsw;

@end
