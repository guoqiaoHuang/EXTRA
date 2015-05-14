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

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ModelEngineVoip.h"
#import "AppDefine.h"
#import "CommonTools.h"
#import "BaseViewController.h"

#define theAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface UIBaseViewController : BaseViewController<ModelEngineUIDelegate,UIImagePickerControllerDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>
{
    UILabel             *popLabel;
    UIImageView         *popTipView;
}

@property (retain, nonatomic)ModelEngineVoip                *modelEngineVoip;

@property (retain, nonatomic)NSString                       *voipCallID;

//系统界面,来电需要用到
@property (retain, nonatomic)UIImagePickerController        *imagePicker;
@property (retain, nonatomic)MFMessageComposeViewController *messageCompose;

@property (nonatomic, retain)UIActionSheet                  *viewActionSheet;


- (void)gotoIncomingCallView:(NSTimer*)theTimer;//进行中的view操作

-(void)popPromptViewWithMsg:(NSString*)message AndFrame: (CGRect)frame;

- (void)displayProgressingView;

- (void)dismissProgressingView;

- (void)popToPreView;

@end
