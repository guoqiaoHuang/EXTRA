//
//  BaseViewController.m
//  RDOA
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Global.h"
#import "UIButtonEx.h"
#import "ADScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPTool.h"

#define ClearColorPartViewTag 90000

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize controllerTag;
@synthesize isFirst;
@synthesize activityView;
@synthesize adScrollView;

@synthesize viewHeight;
@synthesize aSIFormDataRequestArray;
@synthesize requestArray;
@synthesize hud;

- (void)dealloc
{

    if (adScrollView)
        [adScrollView stopDisplayLink];
    if (adScrollView)
    {
        [adScrollView release];
        adScrollView = nil;
    }
    
    if (hud) {
        [hud release];
        hud = nil;
    }
    
    [activityView removeFromSuperview];
    [activityView release];
    
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count];
        for (int i = count - 1; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            [request clearDelegatesAndCancel];
            [aSIFormDataRequestArray removeObjectAtIndex:i];
            request = nil;
            
        }
    }
    self.aSIFormDataRequestArray = nil;
    if ([requestArray count] > 0) {
        int count = [requestArray count];
        for (int i = count - 1; i >= 0; i-- ) {
            ASIHTTPRequest *request = [requestArray objectAtIndex:i];
            [request clearDelegatesAndCancel];
            [requestArray removeObjectAtIndex:i];
            request = nil;
        }
    }
    self.requestArray = nil;
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        self.adScrollView = nil;
        isFirst = TRUE;
        controllerTag = 0;
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self loadData];
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    viewHeight = self.view.bounds.size.height;
    UIImage *tempImageBG = [UIImage imageNamed:@"BgImage.png"];
//    tempImageBG = [tempImageBG stretchableImageWithLeftCapWidth:tempImageBG.size.width/2 topCapHeight:tempImageBG.size.height/2];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    bg.image = tempImageBG;
    bg.userInteractionEnabled = YES;
    self.view = bg;
    [bg release];
    self.activityView.frame = CGRectMake((ScreenW-100)/2, (ScreenH-100)/2, 100, 100);
    [self.view addSubview:self.activityView];
    
}

//添加透明的view
- (void)addClearColorPartView{
    UIView *view = (UIView *)[self.view viewWithTag:ClearColorPartViewTag];
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.viewHeight - 44)];
        view.tag = ClearColorPartViewTag;
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self.view addSubview:view];
        [view release];
    }
    [self.view bringSubviewToFront:view];
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];
}

- (void)removeClearColorPartView{
    UIView *view = (UIView *)[self.view viewWithTag:ClearColorPartViewTag];
    [view removeFromSuperview];
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    aSIFormDataRequestArray = [[NSMutableArray alloc] init];
    requestArray = [[NSMutableArray alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self removeHUDView];
}

#pragma mark 网络下载或者读取本地数据
-(void )loadData
{
}

-(void) goBackHome
{
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    for (; tempCount>2; tempCount--)
    {
        [nav popViewControllerAnimated:NO];
    }
    
}

-(void)showError
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉，无法正常获取服务器数据"
                                                   message:@"请您检查一下网络是否正常"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
}

-(void)showErrorMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
}




//定制返回函数
-(void)backAction
{
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    if (tempCount > 4)
        [nav popViewControllerAnimated:YES];
    else
        [nav popViewControllerAnimated:NO];
}

//林明智加
- (void)addNavBack {
    //定制返回按钮
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(homeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
}

- (void)homeButtonPressed{
    [self.navigationController popViewControllerAnimated:NO];
}

//添加HUD
- (void)addHUDWithMode:(FrameModel) aModel{
    [self removeHUDView];
    if (!hud) {
        hud = [[MyHUD alloc] initWithFrame:self.view.bounds Model:aModel];
        [self.view addSubview:hud];
        [hud setFitView:@"数据加载中..."];
        [self animationShow];
    }
}


- (void)removeHUDView {
    if (hud) {
        [hud removeFromSuperview];
        [hud release];
        hud = nil;
    }
}



//动态删除HUD控件
- (void)animationRemoveHUD{
    if (hud ) {
        hud.transform = CGAffineTransformMakeScale(1,1);
        hud.alpha = 1;
        
        [UIView animateWithDuration:0.6f animations:^{
            
            hud.transform = CGAffineTransformMakeScale(0.01,0.01);
            hud.alpha = 0;
        } completion:^(BOOL finished){
            [self removeHUDView];
        }];
    }
}


//底部的显示
- (void)animationShow{
    hud.alpha = 0;
    hud.transform = CGAffineTransformMakeScale(0,0);
    [UIView beginAnimations:@"contentViewAnimation" context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    hud.alpha = 1;
    [UIView setAnimationDelegate:self];
    hud.transform = CGAffineTransformMakeScale(1,1);
    [UIView commitAnimations];
}

//get
- (void)requestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo Model:(FrameModel) aMode{
    if ([requestArray count] > 0) {
        int count = [requestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIHTTPRequest *request = [requestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [requestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    NSURL *url = [NSURL URLWithString:strURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    if (aUserInfo) {
         request.userInfo = aUserInfo;
    }
   
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithRequest:request];
    [requestArray addObject:request];
    
}

//post
- (void)formDataRequestWithURL:(NSString *)strURL
                      UserInfo:(NSDictionary *) aUserInfo
                  PostValueDic:(NSDictionary*) aPostDic
                     HeaderDic:(NSDictionary *) heardDic
                         Model:(FrameModel) aMode{
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [aSIFormDataRequestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    ASIFormDataRequest *request = nil;
    NSURL *url = [NSURL URLWithString:strURL];
    request = [ASIFormDataRequest requestWithURL:url];
    
    request.userInfo = aUserInfo;
    
    //post
    NSArray *keys = [aPostDic allKeys];
    for (NSString *key in keys) {
        [request setPostValue:[aPostDic objectForKey:key] forKey:key];
    }
    
    //addhead
    keys = [heardDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[heardDic objectForKey:key]];
    }
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithDataRequest:request];
    [aSIFormDataRequestArray addObject:request];
}

- (void)formDataRequestWithURL:(NSString *)strURL
                      UserInfo:(NSDictionary *) aUserInfo PostValueDic:(NSDictionary*) aPostDic HeaderDic:(NSDictionary *) heardDic{
    
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [aSIFormDataRequestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    ASIFormDataRequest *request = nil;
    NSURL *url = [NSURL URLWithString:strURL];
    request = [ASIFormDataRequest requestWithURL:url];
    
    //post
    NSArray *keys = [aPostDic allKeys];
    for (NSString *key in keys) {
        [request setPostValue:[aPostDic objectForKey:key] forKey:key];
    }
    request.userInfo = aUserInfo;
    
    //addhead
    keys = [heardDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[heardDic objectForKey:key]];
    }
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithDataRequest:request];
    [aSIFormDataRequestArray addObject:request];
}

- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo DataArray:(NSArray *)array Header:(NSDictionary *)headDic{
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [aSIFormDataRequestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    ASIFormDataRequest *request = nil;
    NSURL *url = [NSURL URLWithString:strURL];
    request = [ASIFormDataRequest requestWithURL:url];
    
    NSArray *keys = [headDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[headDic objectForKey:key]];
    }
    
    for (NSDictionary *dic in array) {
        [request addPostValue:[dic objectForKey:@"data"]  forKey:@"data[]"];
        [request setPostValue:[dic objectForKey:@"key"] forKey:@"key"];
    }
    
    request.userInfo = aUserInfo;
    
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithDataRequest:request];
    [aSIFormDataRequestArray addObject:request];
}

- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo DataArray:(NSArray *)array Header:(NSDictionary *)headDic Key:(NSString *)key Type:(NSString *)typeStr{
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [aSIFormDataRequestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    ASIFormDataRequest *request = nil;
    NSURL *url = [NSURL URLWithString:strURL];
    request = [ASIFormDataRequest requestWithURL:url];
    
    NSArray *keys = [headDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[headDic objectForKey:key]];
    }
    
    for (NSDictionary *dic in array) {
        [request addPostValue:dic  forKey:@"data[]"];
    }
    [request addPostValue:key forKey:@"key"];
    [request addPostValue:typeStr forKey:@"type"];
    
    request.userInfo = aUserInfo;
    
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithDataRequest:request];
    [aSIFormDataRequestArray addObject:request];
}

//请求网络post
- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo PostArray:(NSArray *)postArray PostDic:(NSDictionary *)postDic Header:(NSDictionary *)headDic {
    if ([aSIFormDataRequestArray count] > 0) {
        int count = [aSIFormDataRequestArray count] - 1;
        for (int i = count; i >= 0; i-- ) {
            ASIFormDataRequest *request = [aSIFormDataRequestArray objectAtIndex:i];
            if ([request.userInfo isEqual:aUserInfo]) {
                [request clearDelegatesAndCancel];
                [aSIFormDataRequestArray removeObjectAtIndex:i];
                request = nil;
            }
        }
    }
    
    //重新请求
    ASIFormDataRequest *request = nil;
    NSURL *url = [NSURL URLWithString:strURL];
    request = [ASIFormDataRequest requestWithURL:url];
    
    NSArray *keys = [headDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[headDic objectForKey:key]];
    }
    
    for (NSDictionary *dic in postArray) {
        [request addPostValue:dic  forKey:@"data[]"];
    }
    
    keys = [postDic allKeys];
    for (NSString *key in keys) {
        [request setPostValue:[postDic objectForKey:key] forKey:key];
    }

    request.userInfo = aUserInfo;
    
    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithDataRequest:request];
    [aSIFormDataRequestArray addObject:request];

}


@end
