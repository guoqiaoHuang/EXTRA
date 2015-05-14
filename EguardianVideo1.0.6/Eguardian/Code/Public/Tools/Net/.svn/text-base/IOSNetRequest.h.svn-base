//
//  IOSNetRequest.h
//  RDOA
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IOSNetRequestDelegate <NSObject>
@optional
- (void) R_didFinsh:(id)tempData dataMessage:(id) msg;
- (void) R_Error:(NSError *)error dataMessage:(id) msg;
@end


@interface IOSNetRequest : NSObject
{
    NSMutableURLRequest             *request;
    id<IOSNetRequestDelegate>       delegate;
    BOOL                            synchronous;    // true 是同步 同步或者异步
}


@property(nonatomic,retain)NSMutableURLRequest  *request;
@property(nonatomic,retain)id delegate;
@property(nonatomic,assign)BOOL synchronous;



-(id) initWithRequest:(NSMutableURLRequest *)arequest delegate:(id)adelegate synchronous:(BOOL)asynchronous;


-(void) action;


-(void) requestError:(NSError *)error response:(NSURLResponse *)aresponse;

-(void) requestFinished:(NSData *)adata response:(NSURLResponse *)aresponse;

@end





















































