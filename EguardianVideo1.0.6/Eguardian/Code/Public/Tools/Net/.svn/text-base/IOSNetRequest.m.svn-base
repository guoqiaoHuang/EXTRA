//
//  IOSNetRequest.m
//  RDOA
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "IOSNetRequest.h"
#import "FileSystemManager.h"

@implementation IOSNetRequest
@synthesize request;
@synthesize synchronous;
@synthesize delegate;


- (void)dealloc
{
    [request release];
    [delegate release];
    [super dealloc];
}


-(id) initWithRequest:(NSMutableURLRequest *)arequest delegate:(id)adelegate synchronous:(BOOL)asynchronous
{
    if (self = [super init])
    {
        self.request = arequest;
        self.delegate = adelegate;
        self.synchronous = asynchronous;
    }
    return self;
}


-(void) action
{
    if (synchronous)
    {
        
    }
    else
    {
        //异步
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:self.request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             if ( error != nil)
             {
                 [self requestError:error response:response];
             }
             else
             {
                 if (response != nil)
                 {
                     [self requestFinished:data response:response];
                 }
             }
         }];
        [queue release];
    }
    
    
}



-(void) requestError:(NSError *)error response:(NSURLResponse *)aresponse
{
    [self.delegate R_Error:error dataMessage:aresponse];
}



-(void) requestFinished:(NSData *)adata response:(NSURLResponse *)aresponse
{
    [self.delegate R_didFinsh:adata dataMessage:aresponse];
}


@end

















































