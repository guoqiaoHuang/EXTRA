//
//  InitProject.m
//  RDOA
//
//  Created by apple on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "InitProject.h"
#import "ResourcesListManager.h"
#import "JSONProcess.h"
#import "FileSystemManager.h"
#import "ConfigManager.h"

@implementation InitProject

//配制文件
-(void) loadConfig
{
    //存储配制文件
    [self initializeResourcesList];
    
    NSData *tempData = [FileSystemManager readFile:@"config"];
    if (tempData) 
    {
        [JSONProcess configProcess:tempData];
    }
    else
    {
        [ConfigManager sharedConfigManager].configData  = [NSDictionary dictionaryWithObjectsAndKeys:@"http://app.shouhubao365.com/eguardian/api",@"dynamic_config_url",
                             @"1365691211",@"date_created",
                             @"X-API-KEY",@"api_key_name",
                             @"f21e4a01aa862337fdbd3dbaeefc2c1d",@"api_key_value",nil];
    }
}





#pragma mark 将资源列表读入到内存中
-(void) initializeResourcesList
{
    [ResourcesListManager readResourcesListToRAM];
}

//delegate


- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{

    [JSONProcess configProcess:tempData];

}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
//    NSLog(@"%@", error);
}



@end































































