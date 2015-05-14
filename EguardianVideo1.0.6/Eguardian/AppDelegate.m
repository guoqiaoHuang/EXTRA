//
//  AppDelegate.m
//  CampusManager
//
//  Created by apple on 13-3-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "THomeViewController.h"
#import "InitProject.h"
#import "NetTools.h"
#import "JSONProcess.h"
#import "LoginManager.h"
#import "ConfigManager.h"
#import "AdvertisingManager.h"
#import "Global.h"
#import "SurveillanceVdeoPlayViewController.h"
#import "NSDateFormatter+help.h"


#define ImageViewTag 2000

@implementation AppDelegate
@synthesize displayPanel;
@synthesize window = _window;
@synthesize loginType ;
@synthesize popLabel;
@synthesize popTipView;

- (void)dealloc
{
    [displayPanel release];
    [_window release];
    [popLabel release];
    [popTipView release];
    [super dealloc];
}

//配制文件数据返回
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [JSONProcess configProcess:tempData];
                       [[AdvertisingManager sharedAdvertisingManager] request];
                       
                       //语音通讯
                       [self voiceCommunication];
                        sleep(2.0);
                       
                       [[self.window viewWithTag:ImageViewTag] removeFromSuperview];
                       UINavigationController *nav = [[UINavigationController alloc] init];
                       self.window.rootViewController = nav;
                       [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] forBarMetrics:UIBarMetricsDefault];
                       
                       
                       {
                           //版本更新判断 [string1 compare: string2]  与NSOrderedAscending进行判断，所以结果为“真”。这相当于说string2大于string1。 
                           NSDictionary *dic = [ [NSBundle mainBundle] infoDictionary];
                           NSString *versionString = [dic objectForKey:@"CFBundleVersion"];
                           if ([versionString compare: [[ConfigManager sharedConfigManager].configData objectForKey:@"versionName"]] == NSOrderedAscending) {
                               UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"有版本更新"
                                                                              message:@""
                                                                             delegate:self
                                                                    cancelButtonTitle:@"取消"
                                                                    otherButtonTitles:@"确认",nil];
                               [alert show];
                               [alert release];
                           }
                           
                           
                       }
                       
                       
                       
                       
                       LoginManager *manager = [LoginManager sharedLoginManager];
                       [nav pushViewController:manager.loginViewController animated:YES];
                       [nav release];
                       
                       //                        THomeViewController *vc = [[THomeViewController alloc] init];
                       //                        UINavigationController *nav = [[UINavigationController alloc] init];
                       //                        self.window.rootViewController = nav;
                       //                        [nav pushViewController:vc animated:YES];
                       //                        [vc release];
                       //                        [nav release];
                       
                       
                       
                       
                       
                   });
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       
                       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉，无法正常获取服务器数据"
                                                                      message:@"请您检查一下网络是否正常"
                                                                     delegate:nil
                                                            cancelButtonTitle:nil
                                                            otherButtonTitles:@"确认",nil];
                       [alert show];
                       [alert release];
                   });
}

//配制请求
-(void) firstRequest
{
    //加载配置文件
    InitProject *it = [[InitProject alloc] init];
    [it loadConfig];
    [it release];
    
    //访问网络
    NSString *dynamic_config_url = [[ConfigManager sharedConfigManager].configData objectForKey:@"dynamic_config_url"];
    NSString *date_created = [[ConfigManager sharedConfigManager].configData objectForKey:@"date_created"];
    NSString *new_url = [NSString stringWithFormat:@"%@?date_created=%@",dynamic_config_url,date_created];
    NSString *api_key_name = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_name"];
    NSString *api_key_value = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *msg = [NSMutableDictionary dictionaryWithObjectsAndKeys:api_key_value,api_key_name, nil];
    
    NetTools *netTools = [[NetTools alloc] initWithURL:new_url httpMsg:msg delegate:self];
    [netTools downloadAndSave:@"config"];
    [netTools release];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    {
        displayPanel = [[DisplayPanel alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
        displayPanel.userInteractionEnabled = YES;
        displayPanel.hidden = YES;
        [self.window addSubview:displayPanel];
    }
    
    UIImageView *tempView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    tempView.tag = ImageViewTag;
    tempView.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    [self.window addSubview:tempView]; [tempView release];
    [self.window makeKeyAndVisible];
    [ConfigManager sharedConfigManager].isLeader = FALSE;
    [self firstRequest];
    
    {
        //通知
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        
        NSDictionary* payload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        //后台通知弹出
        if (payload)
        {
            NSString* alertStr = nil;
            NSDictionary *apsInfo = [payload objectForKey:@"aps"];
            NSObject *alert = [apsInfo objectForKey:@"alert"];
            if ([alert isKindOfClass:[NSString class]])
            {
                alertStr = (NSString*)alert;
            }
            else if ([alert isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* alertDict = (NSDictionary*)alert;
                alertStr = [alertDict objectForKey:@"body"];
            }
            application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
            if ([application applicationState] == UIApplicationStateActive && alertStr != nil)
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:nil
                                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
        }
        
    }
    
    return YES;
    
}

//语音通讯
- (void)voiceCommunication{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //初始化Voip SDK接口，分配资源
        self.modeEngineVoip = [ModelEngineVoip getInstance];
        //删除前几天的数据
        [self deleteVoiceBeforeDate];
    });
    
}

//删除语音通讯前几天的数据
- (void)deleteVoiceBeforeDate{
    NSInteger timeInt = [[[ConfigManager sharedConfigManager].configData objectForKey:@"interactive"] integerValue];
    NSDate *newDate = nil;
    NSString *timeStr = nil;
    if (timeInt > 0) {
        NSDate *date = [NSDate date];
        newDate = [[[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - timeInt * 24*3600)] autorelease];
        NSDateFormatter *formatter = [NSDateFormatter getYyyyMmDdHMS];
        timeStr = [formatter stringFromDate:newDate];
    }
    if (timeStr) {
        //删除amr
        [self.modeEngineVoip.imDBAccess deleteFileWithAmr:timeStr];
        //删除数据库
        [self.modeEngineVoip.imDBAccess deleteBeforeTime:timeStr];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 苹果返回的推送信息
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* deviceTokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    [ConfigManager sharedConfigManager].deviceToken = deviceTokenString;
//    NSLog(@"设备信息 %@", deviceTokenString);
}

//注册push功能失败 后 返回错误信息，执行相应的处理
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"Push Register Error:%@", err.description);
}


//前台通知处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)payload
{
    
    NSString* alertStr = nil;
    NSDictionary *apsInfo = [payload objectForKey:@"aps"];
    NSObject *alert = [apsInfo objectForKey:@"alert"];
    if ([alert isKindOfClass:[NSString class]])
    {
        alertStr = (NSString*)alert;
    }
    else if ([alert isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* alertDict = (NSDictionary*)alert;
        alertStr = [alertDict objectForKey:@"body"];
    }
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    if ([application applicationState] == UIApplicationStateActive && alertStr != nil)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:nil
                                                  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}

//收到本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([[notification.userInfo objectForKey:@"type"] isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:notification.alertBody
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确认",nil];
        [alert show];
        [alert release];
    }
    
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( 1 == buttonIndex)
    {
        NSString *updateURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"update_url"];
        NSString *urlString =  [updateURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
}

//获取登录的姓名
- (NSString *) getLoginName {
    NSArray *userArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.loginType];
    NSString *name = nil;
    if ([userArray count] > 0) {
        NSDictionary *userdic =  [userArray objectAtIndex:0];
        name = [userdic objectForKey:User_UserNumber];
    }

    return name;
}

#pragma mark ios6.0 横竖屏切换
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    //判断当前的页面是不是视频播放
    NSArray *array = self.window.rootViewController.childViewControllers;
    UIViewController *currentController = nil;
    if (array) {
        NSInteger count = [array count];
        if (count > 0) {
            currentController = [array objectAtIndex:count - 1];
        }
    }
    if ([currentController isKindOfClass:[SurveillanceVdeoPlayViewController class]]) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark 语音通讯
-(void)printLog:(NSString*)log
{
    NSLog(@"%@",log); //用于xcode日志输出
}

#pragma mark 提示框
-(void)popPromptViewWithMsg:(NSString*)message AndFrame: (CGRect)frame andDuration:(NSTimeInterval)duration
{
    if (popTipView == nil) {
        [self addPopTipView];
    }
    UIFont* font = [UIFont systemFontOfSize:14.0f];
    CGSize size = [message sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, 200.0f) lineBreakMode:NSLineBreakByCharWrapping];
    [self.window bringSubviewToFront:popTipView];
    popTipView.frame = CGRectMake((300-size.width)*0.5 ,frame.origin.y , size.width+20 ,size.height+30);
    popLabel.backgroundColor = [UIColor clearColor];
    popLabel.textColor = [UIColor whiteColor];
    popLabel.textAlignment = NSTextAlignmentCenter;
    popLabel.lineBreakMode = NSLineBreakByCharWrapping;
    popLabel.font = font;
    popLabel.numberOfLines = 0;
    popLabel.text = message;
    popLabel.frame = CGRectMake(10, 15, size.width, size.height);
    
    popLabel.alpha = 1.0f;
    popTipView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: duration];
    
    popTipView.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)addPopTipView{
    popTipView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sms_tip_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
    popTipView .alpha = 0.0f;
    popLabel = [[UILabel alloc] init];
    popLabel.alpha = 0.0f;
    [popTipView addSubview:popLabel];
    [popLabel release];
    [self.window addSubview:popTipView];
    [popTipView release];
}

@end


