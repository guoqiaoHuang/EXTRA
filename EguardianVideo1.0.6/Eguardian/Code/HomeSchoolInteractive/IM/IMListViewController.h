/*
 *  Copyright (c) 2013 The CCP project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a Beijing Speedtong Information Technology Co.,Ltd license
 *  that can be found in the LICENSE file in the root of the web site.
 *
 *                    http://www.cloopen.com
 *
 *  An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "UIBaseViewController.h"
#import "MWPhotoBrowser.h"

//typedef enum  {
//    //登录子账号
//	Login = 0,
//    //用于联系其它子账号
//	NOLogin = 1
//} Model;

@interface IMListViewController : UIBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy)     NSString *serverip;
@property (nonatomic, copy)     NSString *serverport;
@property (nonatomic, assign)  BOOL isLogin;

//联系人的信息
@property (nonatomic, retain) NSDictionary *connectInfo;


@end
