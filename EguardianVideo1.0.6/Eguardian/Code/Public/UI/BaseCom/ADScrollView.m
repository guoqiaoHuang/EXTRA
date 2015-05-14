//
//  ADScrollView.m
//  Eguardian
//
//  Created by apple on 13-4-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ADScrollView.h"
#import "AdvertisingManager.h"
#import "FileSystemManager.h"
#import "StringExpand.h"
#import "NetTools.h"
#import "ResourcesListManager.h"
#import "RamCacheManager.h"
#import "WebViewController.h"
#import "Global.h"
#import <QuartzCore/CADisplayLink.h>


@implementation ADScrollView
@synthesize scrollView;
//@synthesize key;
@synthesize adArray;
@synthesize urlArray;
@synthesize imgArray;
@synthesize delegate;


#define imageViewTag 100



- (void)dealloc
{
    NSLog(@"AD内存释放了---");

    [adArray release];
    [imgArray release];
    [urlArray release];
    [scrollView release];
    [super dealloc]; 
}

-(void) stopDisplayLink
{
    NSLog(@"AD内存崩溃了---");

    stopFlag = TRUE;
    if ( displayLink )
    {
        
        [displayLink invalidate];
        displayLink = nil;
    }
    
}


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
         
//         dispatch_async(dispatch_get_main_queue(),
//         ^{
             UIImageView *adImgView = (UIImageView *)[self.scrollView viewWithTag:imageViewTag+index];
             UIImage *adImage = [[UIImage alloc] initWithData:data];
             [adImgView setImage:adImage];
             [adImage release];
//         });
     }];
    [queue release];
}




#pragma mark 打开网页
-(void)openRUL
{
    NSString *address = [urlArray objectAtIndex:currentPage];
    WebViewController *wc = [[WebViewController alloc] initWithURL:address];
    if (delegate)
    {
        [self.delegate.navigationController pushViewController:wc animated:YES];
    }
    
    [wc release];
}



-(void) initSubView
{
    
    urlArray = [[NSMutableArray alloc] init];
    imgArray = [[NSMutableArray alloc] init];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.contentSize = CGSizeMake(self.frame.size.width * self.adArray.count, scrollView.frame.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    
    [self addSubview:scrollView];
    
    
    for (int i=0; i<self.adArray.count; i++)
    {
        NSDictionary *adObj = [self.adArray objectAtIndex:i];
        [urlArray insertObject:[adObj objectForKey:@"url"] atIndex:i];
        [imgArray insertObject:[adObj objectForKey:@"img"] atIndex:i];
        
        
        UIImageView *adImgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0,
                                                                               self.frame.size.width, self.frame.size.height)];
        adImgView.tag = imageViewTag+i;
        adImgView.userInteractionEnabled = YES;
        [scrollView addSubview:adImgView];
        
        UIImage *imgData = [FileSystemManager readImage: [[imgArray objectAtIndex:i] stringMD5]];//读取本地图片
        if (imgData)
        {
            //读取本地
            adImgView.image = imgData;
        }
        else
        {
            adImgView.image = [UIImage imageNamed:@"头部广告条默认.png"];
            //下载
            [self requestImg:[imgArray objectAtIndex:i] index:i];
        }
        
        //单击触发事件
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = adImgView.frame;
        [button addTarget:self action:@selector(openRUL) forControlEvents:UIControlEventTouchDown];
        [scrollView addSubview:button];
        [adImgView release];
        
    }
    
    
//    int animationFrameInterval = 120;
//    displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(autoMovingScrollView)];
//    [displayLink setFrameInterval:animationFrameInterval];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    

//    displayLink = [NSTimer scheduledTimerWithTimeInterval: 0.5
//                                             target: self
//                                           selector: @selector(autoMovingScrollView)
//                                           userInfo: nil
//                                            repeats: YES];
//    [[NSRunLoop mainRunLoop] addTimer:displayLink forMode:NSDefaultRunLoopMode];
    
    
    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
    
}



-(id) initHomePageWithDelegate:(UIViewController *)adelegate rect:(CGRect)rt
{
    self = [super init];
    if (self)
    {        
        self.delegate = adelegate;
        self.frame = rt;
        NSDictionary *dic = [[AdvertisingManager sharedAdvertisingManager].data objectForKey:@"ads"];
        //attendance , comment,  home_page, home_top, homework, notice
        if ([dic objectForKey:@"home_top"])
            self.adArray = [dic objectForKey:@"home_top"];
        else
            self.adArray = nil;
        [self initSubView];
    }
    return self;
}





#pragma mark mark 是获取数据的信息
-(id) initWithName:(NSString *)name delegate:(UIViewController *)adelegate
{
//  name等于 通过name 获取对应广告 attendance(考勤) , comment(评语),  home_page(), home_top(首页顶部), homework(作业), notice(通知)      
    self = [super init];
    if (self)
    {
        self.delegate = adelegate;
        self.frame = CGRectMake(0, 0, ScreenW, adHeight);
        
        NSDictionary *dic = [[AdvertisingManager sharedAdvertisingManager].data objectForKey:@"ads"];
        self.adArray = [dic objectForKey:name];
        
        [self initSubView];
        
    }
    
    return self;
    
}



-(void) autoMovingScrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    int count = floor(self.scrollView.contentSize.width/pageWidth); //最大的页数
    
    if (page + 1 == count)
    {

        
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y) animated:NO];
//        [self.scrollView scrollRectToVisible:CGRectMake(0, self.scrollView.contentOffset.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake((page+1)*pageWidth, self.scrollView.contentOffset.y) animated:YES];
        
//        [self.scrollView scrollRectToVisible:CGRectMake(page*pageWidth, self.scrollView.contentOffset.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    }
    
    
    if (stopFlag)
        return;
    
    
    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
    
}








//
//#pragma makr 滚动scrollview时计算第几页
//- (void) scrollViewDidScroll:(UIScrollView *)ascrollView
//{
//
////    CGFloat pageWidth = ascrollView.frame.size.width;
////    int page = floor((ascrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
////    page = currentPage;
////    NSLog(@"%d",page );
//    
//    
//}
//
//
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
//{
//    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
//}
//
//
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    [self performSelector:@selector(autoMovingScrollView) withObject:nil afterDelay:2];
//}






@end





































































