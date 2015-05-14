//
//  ResourcesListManager.m
//  RDOA
//
//  Created by apple on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ResourcesListManager.h"
#import "FileSystemManager.h"
#import "StringExpand.h"
#import "RamCacheManager.h"

@implementation ResourcesListManager




#pragma mark 初始化 资源存储列表
+(void) readResourcesListToRAM
{
    
    NSString *resourcesListPath = [FileSystemManager fileName:@"ResourcesList" fileFormat:@"txt" directory:@"ResourcesList"];
    NSError *err ;
    NSString *allStr = [NSString stringWithContentsOfFile:resourcesListPath encoding:NSUTF8StringEncoding error: &err];
    
    NSArray *all = [allStr componentsSeparatedByString:@"\n"];
    
    
    for ( NSString *key in all)
    {
        if ( [key isEqualToString:@"\r"] || [key isEqualToString:@"\t"] || [key isEqualToString:@"\f"] || [key isEqualToString:@"\v"] )
        {}
        else
        {
            NSString *str = [key delEmpty];
            if (![@"" isEqualToString:str] || str != nil )
            {
                NSString *dataKey = [[[str stringByDeletingPathExtension] componentsSeparatedByString:@"/"] lastObject];
                if (![@"" isEqualToString:dataKey] || dataKey != nil) 
                    [[RamCacheManager sharedRamCacheManager].resourcesList setObject:str forKey:dataKey];
            }
        }
    }
    
    
}



#pragma mark 将资源的信息写入资源表中  path 是在本地中存储的完整路径
+(void) writeResourcesPath:(NSString *)path;
{
    
    @synchronized(self)
    {
        NSString *resourcesListPath = [FileSystemManager fileName:@"ResourcesList" fileFormat:@"txt" directory:@"ResourcesList"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existsFlag=[fileManager fileExistsAtPath:resourcesListPath];
        if (!existsFlag)
        {
            //创建文件
            [[@"" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:resourcesListPath atomically:YES];
        }
        
        
        //获取存储文件的名称
        NSString *dataKey = [[[path stringByDeletingPathExtension] componentsSeparatedByString:@"/"] lastObject];
        
        if ( [[RamCacheManager sharedRamCacheManager].resourcesList objectForKey:path] )
                return;
        
        NSString *newPath = [NSString stringWithFormat:@"%@\n",path,nil];
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:resourcesListPath];
        [fh seekToEndOfFile];
        [fh writeData:[newPath dataUsingEncoding:NSUTF8StringEncoding]];
        [fh closeFile];
        
        if ( ![@"" isEqualToString:newPath])
                [[RamCacheManager sharedRamCacheManager].resourcesList setObject:newPath forKey:dataKey];
        
        
    }
    
    
}






@end



























































