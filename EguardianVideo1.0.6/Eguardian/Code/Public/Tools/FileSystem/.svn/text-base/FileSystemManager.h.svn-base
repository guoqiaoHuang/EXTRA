//
//  FileSystemManager.h
//  RDOA
//
//  Created by apple on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Global.h"


typedef enum
{
	appDocuments = 0,
	appLibrary ,
}FileDirectory;


@interface FileSystemManager : NSObject
{
    
}




+(NSString *)fileFormat:(NSDictionary *) types;
+(NSString *)fileDirectory:(NSDictionary *) types;



+ (NSArray*) allFilesAtPath:(NSString*) dirString;

+(NSString *)  filePathName:(NSString *)pathName  index:(int) number;        //创建文件目录

+(NSString *) fileName:(NSString *)name fileFormat:(NSString *)format directory:(NSString *) dic;       //创建文件路径

+(void) fileStoreWithName:(NSString *)aname fileFormat:(NSString *) aformat directory:(NSString *) adirectory content:(NSData *)acontent;       //创建文件




+(BOOL) saveFile:(id)file;

+(BOOL) saveFile:(id)file filePath:(NSString *)afilePath;

+(id) readFile:(NSString *)name;

+(BOOL) readFile:(NSString *)name path:(NSString *)apath;


+(void) serializedObject:(id)obj filePath:(NSString *)path;



+(BOOL) deleteWithPath:(NSString *)path;

+(UIImage *) readImage:(NSString *)name;



@end












































