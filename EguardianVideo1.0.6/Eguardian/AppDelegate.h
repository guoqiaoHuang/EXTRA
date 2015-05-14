//
//  AppDelegate.h
//  CampusManager
//
//  Created by apple on 13-3-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayPanel.h"
#import "ModelEngineVoip.h"

#define kKeyboardBtnpng             @"call_interface_icon_01.png"
#define kKeyboardBtnOnpng           @"call_interface_icon_01_on.png"
#define kHandsfreeBtnpng            @"call_interface_icon_02.png"
#define kHandsfreeBtnOnpng          @"call_interface_icon_02_on.png"
#define kMuteBtnpng                 @"call_interface_icon_03.png"
#define kMuteBtnOnpng               @"call_interface_icon_03_on.png"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    DisplayPanel                     *displayPanel;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DisplayPanel *displayPanel;
@property (retain, nonatomic) ModelEngineVoip *modeEngineVoip;

//登录类型 老师，学生，领导 User_LoginedUsers_Parents,User_LoginedUsers_Teachers,User_LoginedUsers_Leaders
@property (nonatomic, retain) NSString *loginType;

@property (nonatomic, retain) UILabel             *popLabel;
@property (nonatomic, retain) UIImageView         *popTipView;

#pragma mark 语音通讯
-(void)printLog:(NSString*)log;

//获取登录的姓名
- (NSString *) getLoginName;

// 提示框
-(void)popPromptViewWithMsg:(NSString*)message AndFrame: (CGRect)frame andDuration:(NSTimeInterval)duration;

@end
