//
//  HomeViewController.m
//  RDOA
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LHomeViewController.h"
#import "Global.h"
#import <MessageUI/MessageUI.h>
#import "UIButtonEx.h"
#import "ADScrollView.h"
//#import "VideoViewController.h"
#import "SurveillanceVdeoViewController.h"


#import "AdvertisingManager.h"
#import "FileSystemManager.h"
#import "ResourcesListManager.h"
#import "StringExpand.h"
#import "WebViewController.h"
#import "ConfigManager.h"


@interface LHomeViewController ()

@end

@implementation LHomeViewController
@synthesize baseScrollView;
@synthesize currentHeight;
@synthesize scrollView;
@synthesize pageControl;
@synthesize homePageArray;





//************************************************************************************************************************
//************************************************************************************************************************
//广告 start

#pragma mark aurl图片地址,  index 是 对应scrollview的第几张
-(void) requestImg:(NSString *)aurl index:( int )index
{
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aurl]] autorelease];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ( error )
             return;
         
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         NSString *type = [FileSystemManager fileFormat:[httpResponse allHeaderFields]];
         NSString *dic = [FileSystemManager fileDirectory: [httpResponse allHeaderFields]];
         NSString *path = nil;
         path = Custom_File_Path([aurl stringMD5], type, dic);   //url的要md5字符串
         [FileSystemManager saveFile:data filePath:path];
         [ResourcesListManager writeResourcesPath:path];
         
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            UIImageView *adImgView = (UIImageView *)[self.baseScrollView viewWithTag:imageViewTag+index];
                            UIImage *adImage = [[UIImage alloc] initWithData:data];
                            [adImgView setImage:adImage];
                            [adImage release];
                        });
         
     }];
    [queue release];
}


#pragma mark 打开网页
-(void)openRUL
{
    NSDictionary *adObj = [self.homePageArray objectAtIndex:baseScrollViewIndex-1];
    NSString *address = [adObj objectForKey:@"url"];
    WebViewController *wc = [[WebViewController alloc] initWithURL:address];
    [self.navigationController pushViewController:wc animated:YES];
    [wc release];
}

//广告 end
//************************************************************************************************************************
//************************************************************************************************************************


- (void)dealloc
{
    [baseScrollView release];
    [pageControl release];
    [scrollView release];
    [super dealloc];
}


-(void)loadView
{
    [super loadView];
}


-(id) init
{
    self = [super init];
    if (self)
    {
        imageViewTag =100;
        pageNumber = 0;
        self.controllerTag = 0;
        self.currentHeight = 0;
    }
    return self;
}


-(void) selectControllerWithTag:(int)atag
{
    UINavigationController *nav = rootNav;
    if ( atag == 4 )   //schedule
    {
//        VideoViewController *vc = [[VideoViewController alloc] init];
//        [nav pushViewController:vc animated:YES];
//        [vc release];
        SurveillanceVdeoViewController *vc = [[SurveillanceVdeoViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
}



-(void) footButtonAction:(UIButton *)sender
{
    
    if ( sender.tag == self.controllerTag )
        return;
    [self selectControllerWithTag:sender.tag];
}


#pragma make 切换学号
-(void)cancleAction
{
    [ConfigManager sharedConfigManager].isLeader = FALSE;
//    [[ConfigManager sharedConfigManager].wrapper loginOut];
    
    UINavigationController *nav = rootNav;
    [nav popToRootViewControllerAnimated:YES];
}



#pragma mark 添加头部
-(void)loadHeaderView
{
    UIImageView *tmpBG = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"H_HeadBG.png"] ];
    tmpBG.userInteractionEnabled = YES;
    
    {
        
        UIButton *cancleBT = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *cancleImg = [UIImage imageNamed:@"切换账号.png"];
        [cancleBT setBackgroundImage:cancleImg forState:UIControlStateNormal];
        cancleBT.frame = CGRectMake(0, 0, cancleImg.size.width, cancleImg.size.height);
        [cancleBT addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *cancleBG = [[UIView alloc] initWithFrame:CGRectMake( tmpBG.frame.size.width - cancleImg.size.width - 20,
                                                                    (tmpBG.frame.size.height-cancleImg.size.height)/2.0,
                                                                    cancleImg.size.width, cancleImg.size.height)];
        [cancleBG addSubview:cancleBT];
        [tmpBG addSubview:cancleBG];
        [cancleBG release];
    }
    
    [baseScrollView addSubview:tmpBG];
    currentHeight = tmpBG.frame.size.height;
    [tmpBG release];
}




#pragma mark 加载7个模块的图片
-(void)loadHomeButtons
{
    
    int scrollViewNumber = 1;
    
    scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, currentHeight, self.view.frame.size.width, self.view.frame.size.height - currentHeight-48)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * scrollViewNumber, scrollView.frame.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    self.currentHeight += self.scrollView.frame.size.height;
    
    {
        UIImage *tempImag = [UIImage imageNamed:@"H_Video.png"];
        CGRect tempRect = CGRectMake( (scrollView.frame.size.width - tempImag.size.width)/2.0,
                                     (scrollView.frame.size.height - tempImag.size.height)/2.0, tempImag.size.width, tempImag.size.height);
        
        UIView *tempView = [self initCustom:tempRect imageName:@"H_Video.png" text:@"视频监控" buttonTag:4 ];
        [self.scrollView addSubview:tempView]; [tempView release];
    }
    [self.baseScrollView addSubview:scrollView];
    
    

    
    
}



-(UIView *)initCustom:(CGRect)frame imageName:(NSString *)aimageName text:(NSString *)atext buttonTag:(int)atag
{
    UIView *result = [[UIView alloc] initWithFrame:frame];
    UIImage *btImg = [UIImage imageNamed:aimageName];
    
    
    UIButton *btView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btView setBackgroundImage:btImg forState:UIControlStateNormal];
    btView.frame = CGRectMake(0, 0, btImg.size.width, btImg.size.height);
    btView.tag = atag;
    //首页7大button 添加事件
    [btView addTarget:self action:@selector(footButtonAction:) forControlEvents: UIControlEventTouchUpInside];
    [result addSubview:btView];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, btView.frame.size.height, frame.size.width, 18)];
    lable.text = atext;
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = UITextAlignmentCenter;
    lable.textColor = [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
    [result addSubview:lable]; [lable release];
    
    return result;
}
















-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    if (!self.isFirst)
    {
        return;
    }
    
    self.isFirst = FALSE;
    
    
    {
        pageNumber = 1;
        pageNumber += self.homePageArray.count;
        baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        baseScrollView.contentSize = CGSizeMake(self.view.frame.size.width*pageNumber , scrollView.frame.size.height);
        baseScrollView.delegate = self;
        baseScrollView.pagingEnabled = YES;
        
        for (int i=0; i<self.homePageArray.count; i++)
        {
            UIImageView *adImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*(i+1), 0, self.view.frame.size.width, self.view.frame.size.height)];
            adImgView.tag = imageViewTag+i;
            adImgView.userInteractionEnabled = YES;
            [self.baseScrollView addSubview:adImgView];
            
            NSDictionary *tempAdObj = [self.homePageArray objectAtIndex:i];
            UIImage *imgData = [FileSystemManager readImage: [[tempAdObj objectForKey:@"img"] stringMD5] ];//读取本地图片
            if (imgData)
            {
                //读取本地
                adImgView.image = imgData;
            }
            else
            {
                //下载
                [self requestImg:[tempAdObj objectForKey:@"img"] index:i];
            }
            
            //单击触发事件
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = adImgView.frame;
            [button addTarget:self action:@selector(openRUL) forControlEvents:UIControlEventTouchDown];
            [self.baseScrollView addSubview:button];
            [adImgView release];
            
        }
        [self.view addSubview:baseScrollView];
    }
    
    
    [self loadHeaderView];
    [self loadHomeButtons];
}





-(void)action:(UIButton *)sender
{
    [self selectControllerWithTag:sender.tag];
}




#pragma makr 滚动scrollview时计算第几页
- (void) scrollViewDidScroll:(UIScrollView *)ascrollView
{
    if (baseScrollView == ascrollView)
    {
        CGFloat pageWidth = ascrollView.frame.size.width;
        int page = floor((ascrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
        baseScrollViewIndex = page;
        page += currentNumber ;
        
        pageControl.currentPage = page;
        NSArray *subView = pageControl.subviews;
        
        for (int i = 0; i < [subView count]; i++)
        {
            UIImageView *dot = [subView objectAtIndex:i];
            dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"滑动亮点.png"] : [UIImage imageNamed:@"滑动灰点.png"]);
        }
        
        
        
    }
    else if( scrollView == ascrollView )
    {
        CGFloat pageWidth = ascrollView.frame.size.width;
        int page = floor((ascrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
        pageControl.currentPage = page;
        NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
        
        for (int i = 0; i < [subView count]; i++) {
            UIImageView *dot = [subView objectAtIndex:i];
            dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"滑动亮点.png"] : [UIImage imageNamed:@"滑动灰点.png"]);
        }
        currentNumber = page;
        
    }
}







@end























































