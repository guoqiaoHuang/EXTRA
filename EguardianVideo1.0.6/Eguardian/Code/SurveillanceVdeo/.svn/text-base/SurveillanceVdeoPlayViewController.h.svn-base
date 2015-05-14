//
//  SurveillanceVdeoPlayViewController.h
//  Eguardian
//
//  Created by S.C.S on 13-8-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOSPlayM4.h"
#import "VMSNetSDK.h"
#import "VMSNetSDKDataType.h"
#import "BaseViewController.h"

//视频播放
@interface SurveillanceVdeoPlayViewController : BaseViewController
{
    UIControl			*m_playView;										// 播放窗口
	
	int						m_iRtspClientID;
	int                     m_playerPort;
    UIToolbar *toolbar;
    UIView *errorView;
}

@property int                               m_playerPort;
@property int								m_iRtspClientID;
@property (nonatomic, retain) CCameraInfo *ccameraInfo;
@property (nonatomic, retain) NSString *sessionID;
@property (nonatomic, retain)  UIButton  *backTouchBtn;


// 单击StartPlay按钮响应
- (void) startPlayButtonClick;

// 单击StopPlay按钮响应
- (void) stopPlayButtonClick;
- (BOOL)startPlayer;
- (void)setVideoWindowOnMainThread;
- (void)stopPlayer;

- (id)initWithCCameraInfo:(CCameraInfo *) info SessionID:(NSString *) sessionID;

@end
