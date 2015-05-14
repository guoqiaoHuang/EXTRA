//
//  ASIHTTPTool.h
//  MobileCloud
//
//  Created by S.C.S on 13-7-10.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//服务器的一个单例
@interface ASIHTTPTool : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, retain) ASINetworkQueue *queue;

//单例
+ (ASIHTTPTool *)sharedInstance;

- (void)netWorkWithRequest:(ASIHTTPRequest *)request;

- (void)netWorkWithDataRequest:(ASIFormDataRequest *)request;

@end
