//
//  NetTools.m
//  RDOA
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetTools.h"
#import "IOSNetRequest.h"
#import "FileSystemManager.h"
#import "ResourcesListManager.h"
#import "Global.h"
#import "StringExpand.h"
#import "NSString+Extensions.h"

@implementation NetTools
@synthesize url;
@synthesize synchronous;
@synthesize saveFlag;
@synthesize delegate;
@synthesize message;
@synthesize fileName;
@synthesize postBody;
- (void)dealloc
{
    [fileName release];
    [message release];
    [url release];
    [delegate release];
    if (postBody != nil) {
        [postBody release]; postBody = nil;
    }
    
    [super dealloc];
}

-(id) initWithURL:(NSString *)tempURL
{
    if (self = [super init])
    {
        self.url = tempURL;
        self.synchronous = FALSE;
        self.saveFlag = FALSE;
        self.message = nil;
    }
    return self;
}

-(id) initWithURL:(NSString *)tempURL delegate:(id)adelegate
{
    if (self = [super init])
    {
        self.url = tempURL;
        self.synchronous = FALSE;
        self.saveFlag = FALSE;
        self.delegate = adelegate;
        self.message = nil;
    }
    return self;
}


-(id) initWithURL:(NSString *)tempURL synchronous:(BOOL) sy
{
    if (self = [super init])
    {
        self.url = tempURL;
        self.synchronous = sy;
        self.message = nil;
    }
    return self;
}



#pragma mark 下载
-(id) initWithURL:(NSString *)tempURL httpMsg:(NSMutableDictionary *)tempMsg delegate:(id)adelegate
{
    if (self = [super init])
    {
        self.delegate = adelegate;
        self.url = tempURL;
        self.message = tempMsg;
    }
    return self;
}

#pragma mark request post
-(id) initWithURL:(NSString *)tempURL httpMsg:(NSMutableDictionary *)tempMsg PostBody:(NSMutableData *)aPostBody delegate:(id)adelegate
{
    if (self = [super init])
    {
        self.delegate = adelegate;
        self.url = tempURL;
        self.message = tempMsg;
        self.postBody = aPostBody;
    }
    return self;
}

-(void) download
{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]] autorelease];    
    if (self.message != nil)
    {
        for (NSString *key in self.message )
            [request addValue: [self.message objectForKey:key] forHTTPHeaderField:key];
    }
    if(postBody != nil){
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postBody];
    }

    IOSNetRequest *iosR = [[IOSNetRequest alloc] initWithRequest:request delegate:self synchronous:FALSE];
    [iosR action];
    [iosR release];
    
}



-(void) downloadAndSave
{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]] autorelease];
    if (self.message != nil)
    {
        for (NSString *key in self.message )
            [request addValue: [self.message objectForKey:key] forHTTPHeaderField:key];
    }
    IOSNetRequest *iosR = [[IOSNetRequest alloc] initWithRequest:request delegate:self synchronous:FALSE];
    [iosR action];
    self.saveFlag = TRUE;
    [iosR release];
}

-(void) downloadAndSave:(NSString *)afileName
{
    self.fileName = afileName;
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]] autorelease];
    if (self.message != nil)
    {
        for (NSString *key in self.message )
            [request addValue: [self.message objectForKey:key] forHTTPHeaderField:key];
    }
    
    NSDictionary *dic = [ [NSBundle mainBundle] infoDictionary];
    //软件的版本
    NSString *versionString = [dic objectForKey:@"CFBundleVersion"];
    
    //手机系统版本
    NSString *sysVersion = [NSString getSysVersion];
    
    //手机型号
    NSString *device = [NSString getDevice];
    
    NSString *userAgentStr = [NSString stringWithFormat:@"(eguardian/%@/ios%@/%@)",versionString,sysVersion,device];
    
    [request addValue:userAgentStr forHTTPHeaderField:@"User-Agent"];
    
    IOSNetRequest *iosR = [[IOSNetRequest alloc] initWithRequest:request delegate:self synchronous:FALSE];
    [iosR action];
    self.saveFlag = TRUE;
    [iosR release];
}

//**********************************************************************************************************************
//**********************************************************************************************************************
//委托


- (void) R_Error:(NSError *)error dataMessage:(id) msg
{
    
    
    NSData *data = [FileSystemManager readFile:[self.url stringMD5]];
    if (data)
        [self.delegate N_didFinsh:data dataMessage:nil];
    else
        [self.delegate N_Error:error dataMessage:nil];
}


- (void) R_didFinsh:(id)tempData dataMessage:(id) msg
{
    [self.delegate N_didFinsh:tempData dataMessage:self.url];
    if (saveFlag)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)msg;
        NSString *type = [FileSystemManager fileFormat:[httpResponse allHeaderFields]];
        NSString *dic = [FileSystemManager fileDirectory: [httpResponse allHeaderFields]];
        NSString *path = nil;
        if (nil != fileName)
            path = Custom_File_Path(self.fileName, type, dic);
        else
            path = Custom_File_Path([self.url stringMD5], type, dic);   //url的要md5字符串
            
        [FileSystemManager saveFile:tempData filePath:path];
        [ResourcesListManager writeResourcesPath:path];
    }
    
}

@end























































