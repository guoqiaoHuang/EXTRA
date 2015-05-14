//
//  NoticeScrollView.h
//  Eguardian
//
//  Created by apple on 13-5-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView            *scrollView;        //显示广告部分
    
    NSArray                 *adArray;           //广告的数据
    int                     currentPage;        //当前页面
    
    NSMutableArray          *urlArray;     //网页地址
    
    UIViewController        *delegate;
    
    CADisplayLink           *displayLink;
    BOOL                    stopFlag;
}


@property(nonatomic,retain)UIScrollView         *scrollView;
@property(nonatomic,retain)NSArray              *adArray;

@property(nonatomic,retain)NSMutableArray              *urlArray;
@property(nonatomic,assign)UIViewController              *delegate;

-(id) initHomePageWithDelegate:(UIViewController *)adelegate rect:(CGRect)rt;




-(void) autoMovingScrollView;


-(void) stopDisplayLink;



@end

























































