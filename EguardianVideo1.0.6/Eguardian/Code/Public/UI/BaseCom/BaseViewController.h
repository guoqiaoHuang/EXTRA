//
//  BaseViewController.h
//  RDOA
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Global.h"
#import "MyHUD.h"

@class ADScrollView;
@interface BaseViewController : UIViewController
{
    int                              controllerTag;     //控制器自身的tag 与 button的对应
    BOOL                             isFirst;
    UIActivityIndicatorView          *activityView;
    ADScrollView                     *adScrollView;
    
}

@property(nonatomic, assign)int                     controllerTag;
@property(nonatomic, assign)BOOL                    isFirst;
@property(nonatomic,retain)UIActivityIndicatorView  *activityView;
@property(nonatomic,retain)ADScrollView             *adScrollView;

//提示数据加载中等待
@property (nonatomic, retain) MyHUD *hud;

-(void )loadData;

-(void) goBackHome;

-(void) showError;

-(void)backAction;

-(void)showErrorMessage:(NSString *)message;


//林明智加的
@property (nonatomic, assign) NSInteger viewHeight;
@property (nonatomic, retain) NSMutableArray *aSIFormDataRequestArray;
@property (nonatomic, retain) NSMutableArray *requestArray;

- (void)addNavBack;

- (void)homeButtonPressed;

//添加HUD
- (void)addHUDWithMode:(FrameModel) aModel;

//隐藏以及删除控件
- (void)animationRemoveHUD;

//添加透明的view
- (void)addClearColorPartView;

- (void)removeClearColorPartView;

- (void)requestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo Model:(FrameModel) aMode;

- (void)formDataRequestWithURL:(NSString *)strURL
                      UserInfo:(NSDictionary *) aUserInfo
                  PostValueDic:(NSDictionary*) aPostDic
                     HeaderDic:(NSDictionary *) heardDic
                         Model:(FrameModel) aMode;


//网络请求 需要整理
- (void)formDataRequestWithURL:(NSString *)strURL
                      UserInfo:(NSDictionary *) aUserInfo PostValueDic:(NSDictionary*) aPostDic HeaderDic:(NSDictionary *) heardDic;

- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo DataArray:(NSArray *)array Header:(NSDictionary *)headDic;

- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo DataArray:(NSArray *)array Header:(NSDictionary *)headDic Key:(NSString *)key Type:(NSString *)typeStr;


//班主任考勤提交
- (void)formDataRequestWithURL:(NSString *)strURL UserInfo:(NSDictionary *) aUserInfo PostArray:(NSArray *)postArray PostDic:(NSDictionary *)postDic Header:(NSDictionary *)headDic;

@end

