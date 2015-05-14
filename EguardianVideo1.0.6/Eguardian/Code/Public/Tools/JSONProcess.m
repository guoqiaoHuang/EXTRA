//
//  JSONProcess.m
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//NSLog(@"%@", [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

#import "JSONProcess.h"
#import "ConfigManager.h"

@implementation JSONProcess

//解析配制文件
+ (void) configProcess:(NSData *)tempData
{
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingAllowFragments error: &error];
    if (!error && jsonObject )
    {
        [ConfigManager sharedConfigManager].configData = jsonObject;
    }
    
    

    

}




+ (void) checkWorkProcess:(NSData *)tempData
{

    
        
}











+ (NSDictionary *) JSONProcess:(NSData *)tempData
{
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingAllowFragments error: &error];
    
    if (!error && jsonObject )
    {
        return jsonObject;
    }
    
    return nil;
    
}




























@end















































