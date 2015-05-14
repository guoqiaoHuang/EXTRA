//
//  NetTools.h
//  RDOA
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NetToolsDelegate <NSObject>
@optional
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg;
- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg;
@end


@interface NetTools : NSObject
{
    NSString    *url;           //下载地址
    NSMutableDictionary         *message;    //http 头部信息
    BOOL        synchronous;    //true 表示同步  false 是 异步. 默认是false
    BOOL        saveFlag;
    id<NetToolsDelegate>       delegate;
    NSString                   *fileName;       //保存的文件名称
    
    
}


@property(nonatomic,retain)NSString*    url;
@property(nonatomic,assign)BOOL         synchronous;
@property(nonatomic,assign)BOOL         saveFlag;
@property(nonatomic,retain)id           delegate;
@property(nonatomic,retain)NSMutableDictionary           *message;
@property(nonatomic,retain)NSString     *fileName;
@property(nonatomic,retain) NSMutableData *postBody;


-(id) initWithURL:(NSString *)tempURL;

-(id) initWithURL:(NSString *)tempURL delegate:(id)adelegate;

-(id) initWithURL:(NSString *)tempURL synchronous:(BOOL) sy;



-(id) initWithURL:(NSString *)tempURL httpMsg:(NSMutableDictionary *)tempMsg delegate:(id)adelegate;

-(id) initWithURL:(NSString *)tempURL httpMsg:(NSMutableDictionary *)tempMsg PostBody:(NSMutableData *)aPostBody delegate:(id)adelegate;

-(void) download;

-(void) downloadAndSave;

-(void) downloadAndSave:(NSString *)afileName;


@end
