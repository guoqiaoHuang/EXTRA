//
//  HomeViewController.h
//  RDOA
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class NoticeScrollView;
@interface THomeViewController : BaseViewController<UIScrollViewDelegate>
{
    float                           currentHeight;      //计算累积的当前高度
    UIScrollView                    *scrollView;        //背景滚动
    UIScrollView                    *baseScrollView;    //背景滚动
    
    UIPageControl                   *pageControl;
    int                             currentNumber;      //记录当前页数
    
    
    
    NSArray                         *homePageArray;     //首页广告数据
    int                             pageNumber;         //baseScrollView 连同广告一共多少页
    int                             imageViewTag;       //下载后赋值
    int                             baseScrollViewIndex;       //当前广告页面, 计算点击的时候用的
    
    NoticeScrollView                *noticeScrollView;
    
}


@property(nonatomic, assign)float  currentHeight;

@property(nonatomic, retain)UIScrollView  *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;

@property(nonatomic,retain)UIScrollView *baseScrollView;


@property(nonatomic,retain)NSArray *homePageArray;

@property(nonatomic,retain)NoticeScrollView *noticeScrollView;

//定时器，本地推送考勤异常
@property (nonatomic, retain) NSTimer *timer;

@end
