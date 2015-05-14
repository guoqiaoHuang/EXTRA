//
//  StringExpand.m
//  RDOA
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "StringExpand.h"
#import "Global.h"

@implementation NSString (ReplaceUnicode)


-(NSString *) stringMD5;
{
	NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char outputData[CC_MD5_DIGEST_LENGTH];
	CC_MD5([inputData bytes], [inputData length], outputData);
	
	NSMutableString* hashStr = [NSMutableString string];
	int i = 0;
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
	{
		[hashStr appendFormat:@"%02x", outputData[i]];
	}
	
	return hashStr;
}

#pragma mark 创建默认的文件路径
-(NSString *) convertFilePath
{
    NSString *path1 = Default_File_Path;
    NSString *path2 = [NSString stringWithFormat:@"/Default/%@",self];
    NSString *result = [path1 stringByAppendingPathComponent:path2];	//存放图片目录
    
    return result;
}


#pragma mark 创建默认的文件路径
-(NSString *) convertPathWithFolder:(NSString *)aFolder;
{
    NSString *path1 = Default_File_Path;
    NSString *path2 = [NSString stringWithFormat:@"/%@/%@",aFolder,self];
    NSString *result = [path1 stringByAppendingPathComponent:path2];	//存放图片目录
    
    return result;
}



#pragma mark 创建文件夹
-(NSString *) getFolder
{
    NSString *path1 = Default_File_Path;
    NSString *path2 = [NSString stringWithFormat:@"/%@",self];
    NSString *result = [path1 stringByAppendingPathComponent:path2];	//存放图片目录
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existsFlag=[fileManager fileExistsAtPath:result];
    if (!existsFlag)
	{
		//创建目录
        [fileManager createDirectoryAtPath:result withIntermediateDirectories:FALSE attributes:nil error:nil];
	}
    return result;
}


-(NSString *)delEmpty
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *rs = [self stringByTrimmingCharactersInSet:whitespace];
    return rs;
}



-(NSDate *)dateWithString
{
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateformat dateFromString:self];
    [dateformat release];
    return date;
}


#pragma mark 将 date 转换成 nsstring 类型date
+(NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *result = [dateformat stringFromDate:date];
    [dateformat release];
    return result;
}


#pragma mark 包含字符串名称
-(BOOL )containString:(NSString *)key
{
    
    NSRange foundObj=  [self rangeOfString:key options:NSCaseInsensitiveSearch];
		
		if(foundObj.length>0)
			return YES;
	return NO;
}

@end















































