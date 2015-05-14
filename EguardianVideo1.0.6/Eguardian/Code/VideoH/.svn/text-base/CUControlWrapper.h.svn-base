//
//  iMcuSdk.h
//  iMcuSdk
//
//  Created by  on 12-9-7.
//  Copyright (c) 2012年 Crearo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ResEntity.h"

#define NC_CU_VERIFY_ERROR					-1					// 其他错误，如报文格式错误等
#define NC_CU_VERIFY_OK						0					// 认证成功
#define NC_CU_VERIFY_USERNOTEXIST			1					// 用户不存在
#define NC_CU_VERIFY_USERINACTIVE			2					// 用户被禁用
#define NC_CU_VERIFY_PASSWORDWRONG			6					// 密码错误
#define NC_CU_VERIFY_TIMEOUT				9					// 认证超时
#define NC_CU_VERIFY_ROUTEFAILED			10					// 路由失败
#define NC_CU_RecvNotify_Error              -3                  // 接收命令超时
#define DC7_E_TCPSEND                       -7                   //数据发送出错
#define DC7_E_TCPRECV                       -8                   // 数据接收出错

// 分辨率
extern NSString *kVideoResolution704x576;
extern NSString *kVideoResolution640x480;
extern NSString *kVideoResolution352x288;
extern NSString *kVideoResolution320x240;
extern NSString *kVideoResolution240x192;
extern NSString *kVideoResolution176x144;

// 只有在平台转码流时, 才可以设置码率,帧率和分辨率
extern NSString *kTranscodeStream;

// 设置为实时流时, 码率,帧率和分辨率的值会被忽略
extern NSString *kRealTimeStream;

// 下载图片完成的回调函数
typedef void (*DownloadPictureCallBack)(char *pData, unsigned int uiLen, void *pContext);

@class VideoView;
@protocol CUControlWrapperDelegate;

@interface CUControlWrapper : NSObject
{
    NSString                            *_version;
    NSDomainNode                        *_rootDomain;
    id<CUControlWrapperDelegate>        _delegate;
}
@property (nonatomic, readonly) NSDomainNode                 *rootDomain;// 域节点, 默认为空, 在调用fetchDomainNode后才会有效
@property (nonatomic, readonly) NSString                     *version;   // 版本号
@property (nonatomic, assign) id<CUControlWrapperDelegate>   delegate;   // 代理

/**
 *	@brief              连接服务器
 *
 *	@param 	address     地址
 *	@param 	usPort      端口
 *	@param 	userName 	用户名
 *	@param 	password 	密码
 *	@param 	epid        epid
 *
 *	@return             返回的错误码 0表示登录成功
 */
- (NSInteger)login:(NSString *)address
              port:(unsigned short)usPort
              user:(NSString *)userName
               psd:(NSString *)password
              epid:(NSString *)epid;

/**
 *	@brief	退出服务器
 */
- (void)loginOut;

/**
 *	@brief	获取服务器下的域节点, 获取成功以后可通过rootDomain来获取.
 *
 *	@return	0表示成功
 */
- (NSInteger)fetchDomainNode;

/**
 *	@brief	获取当前域下所有的设备, 确保之前已经调用了fetchDomainNode,获取成功以后可以在rootDomain的childrenArray集合中查找
 *          这个函数会去发网络远程命令,一般只需要调用一次,除非想刷新资源.
 *	@param 	pDomain 	域节点
 *
 *	@return	错误码; 0表示成功
 */
- (NSInteger)fetchPeerUnits;

/**
 *	@brief	获取摄像头资源，确保之前已经调用了fetchDomainNode和fetchPeerUnits。
 *          这个函数会去发网络远程命令,第一次调用该函数会获取域下所有的摄像头资源,所以全局只需要调用一次,此时peerUnit参数可为NULL; 如果想刷新某个PU下的摄像头资源,
 *          需再次调用,此时就需要传入具体NSPeerUnit实例. 获取成功以后如果想要查找某个摄像头,应该通过PUID和cIdx在对应的NSPeerUnit实例的childrenArray集合中查找
 *          
 *  @param 	pPU 	可为NULL或者域下某个具体的设备对象
 *
 *	@return	错误码; 0表示成功
 */
- (NSInteger)fetchCameras:(NSPeerUnit *)peerUnit;

/**
 *	@brief	设置流类型
 *
 *	@param 	streamType 	参考流类型的定义
 */
- (void)setStreamType:(NSString *)streamType;

/**
 *	@brief	设置视频的分辨率, 只能在启动视频之前设置,不支持动态的修改
 *
 *	@param 	resolution 	参考分辨率的定义
 */
- (void)setResolution:(NSString *)resolution;

/**
 *	@brief	设置码率, 只能在启动视频之前设置,不支持动态的修改
 *
 *	@param 	bps 	范围(0, 300) 默认为256
 */
- (void)setBps:(NSInteger)bps;

/**
 *	@brief	设置帧率
 *
 *	@param 	fps 	范围(1, 15) 默认为8
 */
- (void)setFps:(NSInteger)fps;

/**
 *	@brief	渲染视频接口.
 *
 *	@param 	puid 	视频资源的PUID
 *	@param 	ucIdx 	视频资源的index
 *	@param 	renderView 	播放窗口, renderView必须是VideoView类的实例. 
 *
 *	@return	0 成功
 */
- (NSInteger)rend:(NSString *)puid index:(unsigned char)ucIdx target:(UIView *)renderView;

/**
 *	@brief	回放远程录像(平台录像或前端存储的录像),调用StopRend可停止播放
 *
 *	@param 	fileInfo 	录像文件
 *	@param 	res 	对应的摄像头资源
 *	@param 	pStorage 	对应的存储器
 *	@param 	uiOffset 	默认为0,表示从文件的起始位置播放
 *	@param 	renderView 	播放窗口
 *
 *	@return	0 成功
 */
- (NSInteger)rendRemoteVideo:(StorageFile *)fileInfo
                      camera:(NSResEntity *)res
                     storage:(NSResEntity *)pStorage
                      offset:(uint)uiOffset
                      target:(UIView *)renderView;


/**
 *	@brief	回放本地录像
 *
 *	@param 	filePath 	本地录像的全路径
 *	@param 	renderView 	播放窗口
 *	@param 	uiLen       返回文件的时间长度
 *
 *	@return 0	成功
 */
//- (NSInteger)rendLocalVieo:(NSString *)filePath target:(UIView *)renderView length:(unsigned int &)uiLen;


/**
 *	@brief	录像
 */
- (void)startRecord;
- (void)stopRecord;

/**
 *	@brief	截取当前正在渲染的视频,可以用来抓拍
 *
 *	@return	
 */
- (UIImage *)currentImage;


/**
 *	@brief	设置渲染视频的区域
 *
 *	@param 	rect 	区域
 */
- (void)setRendRect:(CGRect)rect;

/**
 *	@brief	停止视频
 */
- (void)stopRend;

/**
 *	@brief	获取平台下的中心存储器,调用该接口前要先调用fetchPeerUnits
 *
 *	@return	NSPeerUnit
 */
- (NSArray *)getStorageCell;

/**
 *	@brief	获取某个设备下的前端存储器,调用该接口前要先调用fetchCameras
 *
 *	@param 	peerUnit 	设备
 *
 *	@return	NSResEntity
 */
- (NSArray *)getStorage:(NSPeerUnit *)peerUnit;

/**
 *	@brief	查询存储器下的指定时间断的录像文件,调用该接口前要先调用fetchCameras
 *
 *	@param 	storage 	存储器(可以为中心存储或者前端存储器)
 *	@param 	camera 	要查询的摄像头资源
 *	@param 	startTime 	开始时间
 *	@param 	endTime 	结束时间
 *
 *	@return	成功则返回文件名称的集合
 */
- (NSArray *)fetchVideoFiles:(NSResEntity *)storage
                      camera:(NSResEntity *)camera
                        from:(NSInteger)startTime
                          to:(NSInteger)endTime;


/**
 *	@brief	查询存储器下的指定时间断的图片文件,调用该接口前要先调用fetchCameras
 *
 *	@param 	storage 	存储器(可以为中心存储或者前端存储器)
 *	@param 	camera 	要查询的摄像头资源
 *	@param 	startTime 	开始时间,
 *	@param 	endTime 	结束时间
 *
 *	@return	成功则返回文件名称的集合
 */
- (NSArray *)fetchPictures:(NSResEntity *)storage
                      camera:(NSResEntity *)camera
                        from:(NSInteger)startTime
                          to:(NSInteger)endTime;


/**
 *	@brief	下载图片,调用该接口前要先调用fetchCameras
 *
 *	@param 	fileInfo 	文件
 *	@param 	storage 	存储器(可以为中心存储或者前端存储器)
 *	@param 	camera 	对应的摄像头资源
 *	@param 	callback 	下载完成的回调函数
 *	@param 	target 	对象
 */
- (void)downloadPictures:(StorageFile *)fileInfo
                 storage:(NSResEntity *)storage
                  camera:(NSResEntity *)camera
                callback:(DownloadPictureCallBack)callback
                  target:(id)target;

/**
 *	@brief	转动摄像头
 *
 *	@param 	pVideo 	摄像头对象
 *	@param 	direction 	转动的方向
 *
 *	@return	0表示成功
 */
- (NSInteger)ptzStartTurn:(NSResEntity *)pVideo direction:(PtzTurnDirection)direction;

/**s
 *	@brief	停止转动摄像头
 *
 *	@param 	pVideo 	摄像头对象
 *
 *	@return	0 表示成功
 */
- (NSInteger)ptzStopTurn:(NSResEntity *)pVideo;

/**
 *	@brief	缩放图像
 *
 *	@param 	pVideo 	进行缩放的摄像头对象
 *	@param 	zoomIn 	YES表示放大图像, NO表示缩小图像
 *
 *	@return	0 返回成功
 */
- (NSInteger)ptzStartZoom:(NSResEntity *)pVideo zoomIn:(BOOL)zoomIn;

/**
 *	@brief	停止缩放
 *
 *	@param 	pVideo 	摄像头对象
 *
 *	@return	0返回成功
 */
- (NSInteger)ptzStopZoom:(NSResEntity *)pVideo;


@end

/**
 *	@brief	代理类
 */
@protocol CUControlWrapperDelegate <NSObject>

/**
 *	@brief	这个代理方法是执行在子线程中,主要是侦测连接服务器,接受数据出错时返回的错误码
 *
 *	@param 	error 	返回的错误码
 */
- (void)connectError:(NSInteger)error;


@end


