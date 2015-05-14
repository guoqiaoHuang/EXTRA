//
//  ADScrollView.m
//  Eguardian
//
//  Created by apple on 13-4-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NoticeScrollView.h"
#import "AdvertisingManager.h"
#import "FileSystemManager.h"
#import "StringExpand.h"
#import "NetTools.h"
#import "ResourcesListManager.h"
#import "RamCacheManager.h"
#import "WebViewController.h"
#import "Global.h"


@implementation NoticeScrollView

@synthesize scrollView;
@synthesize adArray;
@synthesize urlArray;
@synthesize delegate;


#define imageViewTag 100



- (void)dealloc
{
 NSLog(@"NC内存释放了************");
//    [displayLink invalidate];
//    displayLink = nil;
    [urlArray release];
    [scrollView release];
    [super dealloc];
}


-(void) stopDisplayLink
{
    NSLog(@"NC崩溃了************");
    stopFlag = TRUE;
//    [displayLink invalidate];
//    displayLink = nil;
}



#pragma mark 打开网页
-(void)openRUL
{
    NSString *address = [urlArray objectAtIndex:currentPage];
    WebViewController *wc = [[WebViewController alloc] initWithURL:address];
    [self.delegate.navigationController pushViewController:wc animated:YES];
    [wc release];
}



-(void) initSubView
{
    
    
    
    urlArray = [[NSMutableArray alloc] init];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, self.frame.size.height * self.adArray.count);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = NO;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    
    [self addSubview:scrollView];
    
    
    for (int i=0; i<self.adArray.count; i++)
    {
        NSDictionary *adObj = [self.adArray objectAtIndex:i];
        [urlArray insertObject:[adObj objectForKey:@"url"] atIndex:i];

        UIImageView *adImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*self.frame.size.height,
                                                                            self.frame.size.width, self.frame.size.height)];
        adImgView.tag = imageViewTag+i;
        adImgView.userInteractionEnabled = YES;
        [scrollView addSubview:adImgView];
        

        
        //单击触发事件
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = adImgView.frame;
        [button addTarget:self action:@selector(openRUL) forControlEvents:UIControlEventTouchDown];
        [scrollView addSubview:button];
        
        
        
        {
            //文字描述
            UILabel *lablel = [[UILabel alloc] initWithFrame:adImgView.frame];
            lablel.text = [adObj objectForKey:@"title"] ;
            lablel.font = [UIFont fontWithName:@"Arial" size:14];
            lablel.textColor = [UIColor colorWithRed:145.0/255.0 green:136.0/255.0 blue:129.0/255.0 alpha:1.0];
            lablel.textAlignment = UITextAlignmentCenter;
            lablel.backgroundColor = [UIColor clearColor];
            [scrollView addSubview:lablel];
            [lablel release];
        }
        
        
        [adImgView release];
        
    }
    
    
//    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoMovingScrollView)];
//    [displayLink setFrameInterval:120]; //2秒中刷一次
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
//    int animationFrameInterval = 120;
//    displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(autoMovingScrollView)];
//    [displayLink setFrameInterval:animationFrameInterval];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    

    
    
    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
    
}



-(id) initHomePageWithDelegate:(UIViewController *)adelegate rect:(CGRect)rt
{
    self = [super init];
    if (self)
    {
        self.delegate = adelegate;
        self.frame = rt;
        
        self.adArray = [[AdvertisingManager sharedAdvertisingManager].data objectForKey:@"notice"];
        [self initSubView];
    }
    return self;
}









-(void) autoMovingScrollView
{
    CGFloat pageHeight = self.scrollView.frame.size.height;
    int page = floor((self.scrollView.contentOffset.y - pageHeight/2)/pageHeight) + 1;
    int count = floor(self.scrollView.contentSize.height/pageHeight); //最大的页数
    
    if (page + 1 == count)
    {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0) animated:NO];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, (page+1)*pageHeight ) animated:YES];
    }
    
    
    if (stopFlag)
        return;
    
    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
}













@end





































































