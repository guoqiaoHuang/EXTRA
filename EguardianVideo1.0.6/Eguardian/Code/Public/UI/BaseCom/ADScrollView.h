//
//  ADScrollView.h
//  Eguardian
//
//  Created by apple on 13-4-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define adHeight 75


@interface ADScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView            *scrollView;        //显示广告部分
    NSArray                 *adArray;           //广告的数据
    int                     currentPage;        //当前页面
    
    NSMutableArray          *urlArray;          //网页地址
    NSMutableArray          *imgArray;          //图片地址
    
    UIViewController        *delegate;
    
    id                      displayLink;
    BOOL                    stopFlag;
}


@property(nonatomic,retain)UIScrollView         *scrollView;
@property(nonatomic,retain)NSArray              *adArray;

@property(nonatomic,retain)NSMutableArray              *urlArray;
@property(nonatomic,retain)NSMutableArray              *imgArray;
@property(nonatomic,assign)UIViewController              *delegate;


-(id) initHomePageWithDelegate:(UIViewController *)adelegate rect:(CGRect)rt;


-(id) initWithName:(NSString *)name delegate:(UIViewController *)adelegate;

-(void) autoMovingScrollView;



-(void) stopDisplayLink;

@end
































































