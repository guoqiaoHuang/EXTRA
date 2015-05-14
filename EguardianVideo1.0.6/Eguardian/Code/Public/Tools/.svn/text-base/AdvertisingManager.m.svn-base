//
//  AdvertisingManager.m
//  Eguardian
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AdvertisingManager.h"
#import "SynthesizeSingleton.h"
#import "ConfigManager.h"
#import "NetTools.h"
#import "JSONProcess.h"

#import "FileSystemManager.h"
#import "StringExpand.h"
#import "ResourcesListManager.h"
#import "RamCacheManager.h"


@implementation AdvertisingManager
@synthesize data;


SYNTHESIZE_SINGLETON_FOR_CLASS(AdvertisingManager);

- (void)dealloc
{
    [data release];
    [super dealloc];
}

-(void)request
{
    NSString *tempURL = [ConfigManager getAdvertising];
    NSString *api_key_name = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_name"];
    NSString *api_key_value = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *msg = [NSMutableDictionary dictionaryWithObjectsAndKeys:api_key_value,api_key_name, nil];
    
    NetTools *netTools = [[NetTools alloc] initWithURL:tempURL httpMsg:msg delegate:self];
    [netTools download];
    [netTools release];

}

-(void) requestImg:(NSString *)aurl 
{
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aurl]] autorelease];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *webData, NSError *error)
     {
         if ( error )
             return;
         
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         NSString *type = [FileSystemManager fileFormat:[httpResponse allHeaderFields]];
         NSString *dic = [FileSystemManager fileDirectory: [httpResponse allHeaderFields]];
         NSString *path = nil;
         path = Custom_File_Path([aurl stringMD5], type, dic);   //url的要md5字符串
         [FileSystemManager saveFile:webData filePath:path];
         [ResourcesListManager writeResourcesPath:path];
         
    }];
    [queue release];
}


//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    NSDictionary *json = [JSONProcess JSONProcess:tempData];
    self.data = json;
    
    
    //预加载
//    BOOL proload = [[json objectForKey:@"preload"] boolValue];
//    if ( proload )
//    {
//        NSArray *preloadData = [self.data objectForKey:@"preloadData"];
//        for (NSString *imgURL in preloadData)
//        {
//            [self requestImg:imgURL];
//        }
//    }
    

    
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    NSLog(@"广告出错");
}



































@end
























































