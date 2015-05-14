//
//  ASIHTTPTool.m
//  MobileCloud
//
//  Created by S.C.S on 13-7-10.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import "ASIHTTPTool.h"
#import "JSONProcess.h"
#import "Global.h"

@implementation ASIHTTPTool
@synthesize queue;

static ASIHTTPTool *asiHttpTool;

+ (ASIHTTPTool *)sharedInstance{
    @synchronized(self) {
        if (nil == asiHttpTool)
            asiHttpTool=[[ASIHTTPTool alloc] init];
        
    }
    return asiHttpTool;
}

- (void)netWorkWithRequest:(ASIHTTPRequest *)request
{
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
     [request startAsynchronous];
}

- (void)netWorkWithDataRequest:(ASIFormDataRequest *)request{
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [request startAsynchronous];
}

//服务器返回数据b
- (void)requestDone:(ASIHTTPRequest *)request
{
//    NSLog(@"%@",request.userInfo);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //JSON分解
        NSDictionary *jsonDic = [JSONProcess JSONProcess:[request responseData]];
        
//        NSLog(@"jsonDic = %@",jsonDic);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if([request.userInfo objectForKey:NotificationKey]) {
                [[NSNotificationCenter defaultCenter] postNotificationName: [request.userInfo objectForKey:NotificationKey] object:request.userInfo userInfo: jsonDic];
            }
           
        });
    });
    //JSON 解析
   }

//服务没返回的状态
- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        [DELEGATE addPromptViewWithTitle:@"网络有问题，请查看网络设置"];
        if([request.userInfo objectForKey:NotificationKey]) {
            [[NSNotificationCenter defaultCenter] postNotificationName: [request.userInfo objectForKey:NotificationKey]  object:request.userInfo userInfo: nil];
        }
    });
    
}

@end
