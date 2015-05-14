//
//  FileSystemManager.m
//  RDOA
//
//  Created by apple on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FileSystemManager.h"
#import "SynthesizeSingleton.h"
#import "StringExpand.h"
#import "RamCacheManager.h"

@implementation FileSystemManager

    
SYNTHESIZE_SINGLETON_FOR_CLASS(FileSystemManager);





#pragma mark 目录下文件的所有名称(目录＋文件名称)
+ (NSArray*) allFilesAtPath:(NSString*) dirString
{
    NSMutableArray* array = [NSMutableArray array];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:dirString error:nil];
    for (NSString* fileName in tempArray)
    {
        BOOL flag = YES;
        NSString* fullPath = [dirString stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag])
        {
            if (!flag)
            {
                [array addObject:fullPath];
            }
        }
    }
    return array;
}


#pragma mark 获取文件目录
+(NSString *)  filePathName:(NSString *)pathName  index:(int) number
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:number];		//获取到Documents路径
	NSFileManager *fileManage = [NSFileManager defaultManager];
    //创建目录名称
	NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:pathName];	//存放图片目录
	//判断要存储图片的目录名称是否存在
	BOOL existsFlag=[fileManage fileExistsAtPath:myDirectory];
	if (!existsFlag)
	{
        [fileManage createDirectoryAtPath:myDirectory withIntermediateDirectories:FALSE attributes:nil error:nil];
	}
    
    return myDirectory;
}


#pragma mark 获取文件格式
+(NSString *)fileFormat:(NSDictionary *) types
{
    NSString *format = [[types objectForKey:@"Content-Type"] uppercaseString];
    return [[format componentsSeparatedByString:@"/"] objectAtIndex:1];
}


#pragma mark 文件所在目录
+(NSString *)fileDirectory:(NSDictionary *) types
{
    NSString *format = [[types objectForKey:@"Content-Type"] uppercaseString];
    NSString *result = nil;
    if ( [@"IMAGE/JPEG" isEqualToString:format] )
    {
        result = @"Photo";
    }
    else
    {
        result = @"Default";
    }
    return result;
}




#pragma mark name文件名称， format 文件格式  dic 文件存储的上一级目录
+(NSString *) fileName:(NSString *)afileName fileFormat:(NSString *)afileFormat directory:(NSString *) dic
{
    NSString *path = [dic getFolder];
    NSString *result = [NSString stringWithFormat:@"%@/%@.%@",path,afileName,afileFormat];
    return result;
}


#pragma mark 创建文件， 主要生成 xml txt等 并存储内容
+(void) fileStoreWithName:(NSString *)aname fileFormat:(NSString *) aformat directory:(NSString *) adirectory content:(NSData *)acontent
{
    NSString *path = [self fileName:aname fileFormat:aformat directory:adirectory];
    [acontent  writeToFile:path atomically:YES];
}






+(BOOL) saveFile:(id)file
{
    BOOL flag = FALSE;
    return flag;
}

+(BOOL) saveFile:(id)file filePath:(NSString *)afilePath
{
    BOOL flag = FALSE;
    [file writeToFile:afilePath atomically:YES];
    return flag;
}



+(id) readFile:(NSString *)name
{
    id data = nil;
    NSString *path = [[RamCacheManager sharedRamCacheManager].resourcesList objectForKey:name];
    if (path || [@"" isEqualToString:path])
    {
        
        data = [NSData dataWithContentsOfFile:path];
    }
    return data;
}





+(BOOL) readFile:(NSString *)name path:(NSString *)apath
{
    BOOL flag = FALSE;
    return flag;
}


+(BOOL) deleteWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existsFlag=[fileManager fileExistsAtPath:path];
    if (existsFlag)
    {
        [fileManager removeItemAtPath:path error:nil];
    }
    return YES;
}




#pragma mark 序列化对象
+(void) serializedObject:(id)obj filePath:(NSString *)path
{
    NSData	*objData = [NSKeyedArchiver archivedDataWithRootObject:obj];//将对象序列化后,保存到NSData中
    [objData writeToFile:path atomically:YES];//持久化保存成物理文件
}






+(UIImage *) readImage:(NSString *)name
{
    UIImage *data = nil;
    
    
    NSString *path = [[RamCacheManager sharedRamCacheManager].resourcesList objectForKey:name];
    if (path || [@"" isEqualToString:path])
    {
        data = [[[UIImage imageWithContentsOfFile:path] retain] autorelease];
    }
    return data;
}





@end
















































