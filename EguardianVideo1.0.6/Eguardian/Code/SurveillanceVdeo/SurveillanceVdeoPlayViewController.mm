//
//  SurveillanceVdeoPlayViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-8-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SurveillanceVdeoPlayViewController.h"
#import "RtspClientSDK.h"
#import "Global.h"
#import "ConfigManager.h"

#define ActivityIndicatorViewTag 2000
#define ErrorImv 3000
#define ErrorImvHeight 101
#define ErrorLb 3001

@interface SurveillanceVdeoPlayViewController ()
{
    unsigned char *m_pBuffer;
    FILE *fp;
}

@end

@implementation SurveillanceVdeoPlayViewController

@synthesize m_playerPort;
@synthesize m_iRtspClientID;
@synthesize ccameraInfo;
@synthesize sessionID;
@synthesize backTouchBtn;

- (void)dealloc
{
    // Destroy player
	PlayM4_FreePort(m_playerPort);
    m_playerPort = -1;
    
    // Destroy rtsp
	RtspClientFiniLib();
    //    [m_playView release]; m_playView = nil;
    [ccameraInfo release]; ccameraInfo = nil;
    [sessionID release]; sessionID = nil;
    [backTouchBtn release]; backTouchBtn = nil;
    [toolbar release]; toolbar = nil;
    [errorView release]; errorView = nil;
    [super dealloc];
}


//if ([[UIApplication sharedApplication] respondsToSelector:@selector(setStatusBarHidden:withAnimation:)]) {
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
//} else {  // Deprecated in iOS 3.2+.
//    id sharedApp = [UIApplication sharedApplication];  // Get around deprecation warnings.
//    [sharedApp setStatusBarHidden:NO animated:NO];
//}

- (id)initWithCCameraInfo:(CCameraInfo *) info SessionID:(NSString *) aSessionID{
    self = [super init];
    if (self) {
        self.ccameraInfo = info;
        self.sessionID = aSessionID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    m_playerPort = -1;
    
	bool bRet = RtspClientInitLib();
	if (!bRet)
	{
		printf("RtspClient_InitLib fail");
	}
    [self initView];
    [self startPlayButtonClick];
    [self netWork];
    
    //设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
}

- (void)initView{
    [self addNavBack];
    
    //添加哭脸表情
    {
        errorView = [[UIView alloc] init];
        [self.view addSubview:errorView];
        
        UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"opps.png"]];
        [errorView addSubview:imv];
        imv.tag = ErrorImv;
        [imv release];
        
        UILabel *content = [[UILabel alloc] init];
        content.backgroundColor = [UIColor clearColor];
        content.textColor = [UIColor whiteColor];
        [errorView addSubview:content];
        content.tag = ErrorLb;
        [content release];
    }
    
    self.title = @"实时预览";
    m_playView = [[UIControl alloc] init];
//    m_playView.frame = CGRectMake(0 ,0 , 320, 240);
    CGRect rect = CGRectMake(- 20,20 ,self.view.bounds.size.height + 20,self.view.bounds.size.width - 20);
    m_playView.frame = rect;
    m_playView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:m_playView];
    
    self.backTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backTouchBtn.frame = rect;
    backTouchBtn.backgroundColor = [UIColor clearColor];
    [backTouchBtn addTarget:self action:@selector(touchView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTouchBtn];
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake((rect.size.width - 32.0) / 2, (rect.size.height - 32.0 + 20)  / 2);
    [aiv startAnimating];
    aiv.tag = ActivityIndicatorViewTag;
    [self.view addSubview:aiv];
    [aiv release];
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(- 20, 20, self.view.bounds.size.height + 20 ,44)];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back_circle.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 3.5, 50, 37);
    [btn addTarget:self action:@selector(homeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [items addObject:spacer1 ];
    [spacer1 release];
    
    [toolbar setItems:items animated:YES];
    [items release];
    [self.view addSubview:toolbar];
    toolbar.hidden = YES;
    toolbar.barStyle = UIBarStyleBlackTranslucent;

}

- (void)homeButtonPressed{
    //状态栏旋转
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self stopPlayButtonClick];
    [super homeButtonPressed];
}

- (void)removeActivityIndicator{
    // PlayM4_Play 必须主线程中调用
    UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.view viewWithTag:ActivityIndicatorViewTag];
    if (aiv) {
        [aiv removeFromSuperview];
    }
    
}

-(void)popPromptViewWithMsg:(NSString*)message AndFrame: (CGRect)frame {
    [self popPromptViewWithMsg:message AndFrame:frame andDuration:3.5f];
}

-(void)popPromptViewWithMsg:(NSString*)message AndFrame: (CGRect)frame andDuration:(NSTimeInterval)duration
{
    float fontSize = 14.0f;
    UIFont* font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [message sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, 200.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    [self.view bringSubviewToFront:errorView];
    float width = 0;
    if (size.width+20 > ErrorImvHeight) {
        width = size.width;
    }else {
        width = ErrorImvHeight;
    }
    errorView.frame = CGRectMake((frame.size.width- size.width - 20)*0.5 ,frame.origin.y , width ,ErrorImvHeight + size.height+30);
    UIImageView *imv = (UIImageView *)[errorView viewWithTag:ErrorImv];
    if (imv) {
        imv.frame = CGRectMake(width / 2 - ErrorImvHeight / 2, 0, ErrorImvHeight, ErrorImvHeight);
    }
    
    UILabel *content = (UILabel *)[errorView viewWithTag:ErrorLb];
    
    if (content) {
        content.frame = CGRectMake(width / 2 - size.width / 2, ErrorImvHeight + 5, size.width, size.height);
    }
    content.font = [UIFont systemFontOfSize:fontSize];
    content.text = message;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: duration];
    
    errorView.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)touchView {
    if (toolbar.hidden == YES) {
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        toolbar.hidden = NO;
    }else {
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        toolbar.hidden = YES;
    }
//    NSLog(@"111");
}

//视频积分添加
- (void)netWork {
    NSString *tempURL = [ConfigManager getVdeoTeacherIntegral];
    [self requestWithURL:tempURL UserInfo:nil Model:PartViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    //设置应用程序的状态栏到指定的方向
     [self.navigationController setNavigationBarHidden:YES animated:NO];
//     [self  popPromptViewWithMsg:@"抱歉！视频无法播放，请检查网络，如有疑问请咨询相关客服。" AndFrame:CGRectMake(0, 80, self.view.bounds.size.width, 30)];
}

- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

// Start realPlay
- (void)startPlayButtonClick
{
	//Start player
	[self startPlayer];
	
	// Start rtsp
	m_iRtspClientID = RtspClientCreateEngine(RTPTCP_TRANSMODE, &RealPlay_RTSPDataCallback, &RealPlay_RTSPMsgCallback, self);
	if (m_iRtspClientID < 0)
	{
		NSLog(@"RtspClient_CreateEngineer fail");
	}
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //获取设备信息
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        CDeviceInfo *cdeviceInfo = [[CDeviceInfo alloc] init];
        NSString *vdeoIPAddress = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_addr"];
        
        BOOL b = [vmsNetSDK getDeviceInfo:vdeoIPAddress toSessionID:self.sessionID toDeviceID:ccameraInfo.deviceID toDeviceInfo:cdeviceInfo];
        CRealPlayURL *crealPlayURL = [[CRealPlayURL alloc] init];
        if (b == YES) {
            // 获取监控点播放地址
            b = [vmsNetSDK getRealPlayURL:vdeoIPAddress toSessionID:self.sessionID toCameraID:ccameraInfo.cameraID toRealPlayURL:crealPlayURL toStreamType:0];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (crealPlayURL) {
                if (!crealPlayURL.url1) {
                    [self  popPromptViewWithMsg:@"抱歉！视频无法播放，请检查网络，如有疑问请咨询相关客服。" AndFrame:CGRectMake(0, 80, self.view.bounds.size.width, 30)];
                    [self removeActivityIndicator];
                    return ;
                }
            }
            // 首先要拿到播放监控点对应的URL
            const char *rtspUrl = [crealPlayURL.url1 UTF8String];
            
            // 再要能拿到登录监控点的设备用户名和密码
            const char *deviceName = [cdeviceInfo.userName UTF8String];
            const char *devicePassword = [cdeviceInfo.password UTF8String];
            
            if (!RtspClientStartRtspProc(m_iRtspClientID,
                                         rtspUrl,
                                         deviceName,
                                         devicePassword))
            {
                [self  popPromptViewWithMsg:@"抱歉！视频无法播放，请检查网络，如有疑问请咨询相关客服。" AndFrame:CGRectMake(0, 80, self.view.bounds.size.width + 20, 30)];
                [self removeActivityIndicator];
//                NSLog(@"RtspClient_OpenURL fail.Err:[%d]", RtspClientGetLastError());
            }
            [crealPlayURL release];
            [cdeviceInfo release];
        });
    });
}

// Stop realPlay
- (void) stopPlayButtonClick
{
    // Stop player
    [self stopPlayer];
    
    // Stop rtsp
	RtspClientStopRtspProc(m_iRtspClientID);
    RtspClientReleaseEngine(m_iRtspClientID);
}

/** @fn	startPlayer
 *  @brief  开启播放库
 *  @param
 *  @return YES - success;NO - failed
 */
- (BOOL)startPlayer
{
	if (1 != PlayM4_GetPort(&m_playerPort))
	{
//		NSLog(@"PlayM4_GetPort is failed");
        NSLog(@"error is %d", PlayM4_GetLastError(m_playerPort));
        return NO;
	}
    
    if (m_playerPort < 0)
    {
//        NSLog(@"PlayM4_GetPort is failed, m_playerPort is invalide");
        return NO;
    }
    
	return YES;
}

/*  @fn     setVideoWindowOnMainThread
 *  @brief  在主线程中调用播放库的MP_SetVideoWindow
 *  @param  (UIView *)view  播放视图
 *  @return none
 */
- (void)setVideoWindowOnMainThread
{
    // PlayM4_Play 必须主线程中调用
    [self removeActivityIndicator];
    
    @try {
        if (1 != PlayM4_Play(m_playerPort, m_playView))
        {
//            NSLog(@"PlayM4_Play is fail");
            NSLog(@"error is %d", PlayM4_GetLastError(m_playerPort));
            return;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
//    [self.view bringSubviewToFront:backTouchBtn];
}

/** @fn	stopPlayer
 *  @brief  停止播放器
 *  @param
 *  @return
 */
- (void)stopPlayer
{
    PlayM4_Stop(m_playerPort);
    
    int ret = PlayM4_FreePort(m_playerPort);
	if (1 != ret)
    {
//        NSLog(@"PlayM4_FreePort is failed,Err:0x%x", ret);
        NSLog(@"error is %d", PlayM4_GetLastError(m_playerPort));
    }
    m_playerPort = -1;
}

#pragma mark - 媒体数据回调
int RealPlay_RTSPDataCallback(int ihandle, int dataType, char* data, int len, unsigned int timestamp, int packetNo, void* useId);
int RealPlay_RTSPDataCallback(int ihandle, int dataType, char* data, int len, unsigned int timestamp, int packetNo, void* useId)
{
    //    NSLog(@"ihandle:%d, DataLen:%d", ihandle, len);
    if (useId == nil)
    {
        return -1;
    }
    SurveillanceVdeoPlayViewController *contrl = (SurveillanceVdeoPlayViewController *)useId;
    
	// 若为文件头
	if (dataType == DATATYPE_HEADER)
	{
        PlayM4_Stop(contrl.m_playerPort);
        
        PlayM4_SetStreamOpenMode(contrl.m_playerPort, STREAME_REALTIME);
        
		// Input head
		if (1 != PlayM4_OpenStream(contrl.m_playerPort, (unsigned char *)data, (unsigned char)len, 1024*1024*2))
		{
//			NSLog(@"MP_OpenStream is fail");
            return -1;
		}
        
        [contrl performSelectorOnMainThread:@selector(setVideoWindowOnMainThread) withObject:nil waitUntilDone:YES];
	}
	else
	{
		// 填充数据
		if (1 != PlayM4_InputData(contrl.m_playerPort, (unsigned char *)data, (unsigned int)len))
		{
//            NSLog(@"MP_InputData is failed");
		}
	}
	return 0;
}

// 消息回调
int RealPlay_RTSPMsgCallback(int ihandle, int opt, void* param1, void* param2, void* useId);
int RealPlay_RTSPMsgCallback(int ihandle, int opt, void* param1, void* param2, void* useId)
{
//	NSLog(@"RTSPMsgCallback.Msg:%d", opt);
    
    if (useId == nil)
    {
        return -1;
    }
    switch (opt)
    {
        case RTSPCLIENT_MSG_BUFFER_OVERFLOW:
            
            break;
        case RTSPCLIENT_MSG_CONNECTION_EXCEPTION:
            // 该异常说明与服务器连路异常，一般需要停止当前预览重新取流
            
            break;
        default:
            break;
    }
    return 1;
}


//#pragma mark ios6.0设置屏幕方向 方法shouldAutorotate,方法supportedInterfaceOrientations组合
- (BOOL)shouldAutorotate{
    return NO;
}

//- (NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait ;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait ;
//}
//
//#pragma mark ios5.0
//- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//
//#ifdef __IPHONE_3_0
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
//#else
//    - (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
//        UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
//#endif
//        if (interfaceOrientation == UIInterfaceOrientationPortrait
//            || interfaceOrientation == UIInterfaceOrientationPortrait)
//        {
//            m_playView.frame = CGRectMake(0 ,0 , 320, 240);
//            UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.view viewWithTag:ActivityIndicatorViewTag];
//            if (aiv) {
//                aiv.center = CGPointMake(320 / 2, 240 / 2);
//            }
//            self.navigationController.navigationBarHidden = NO;
//        }
//        else
//        {
//            self.navigationController.navigationBarHidden = YES;
//            CGRect rect = self.view.window.frame;
//            m_playView.frame = CGRectMake(0, 0, rect.size.height, rect.size.width);
//            UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.view viewWithTag:ActivityIndicatorViewTag];
//            if (aiv) {
//                aiv.center = CGPointMake(rect.size.height / 2, rect.size.width / 2);
//            }
//        }
// }

@end
