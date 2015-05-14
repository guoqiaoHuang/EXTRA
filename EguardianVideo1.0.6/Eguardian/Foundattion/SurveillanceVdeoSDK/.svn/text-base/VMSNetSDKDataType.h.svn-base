//
//  VMSNetSDKDataType.h
//  VMSNetSDK
//
//  Created by Dengsh on 13-7-19.
//  Copyright (c) 2013年 Dengsh. All rights reserved.
//

#import <Foundation/Foundation.h>

/********* gloab ********************************************************/
int mLastError;                                                                 // 全局错误码
NSString *mLastErrorDescribe;                                                   // 全局错误描述

/********* ARC SUPPORT ********************************************************/
#ifndef SUPPORT_ARC_COMPILE
#define release(N) [N release];
#define retain(N) [N retain];
#define deallocSuper [super dealloc];
#define __bridge
#define __bridge_retained
#else
#define release(N)
#define retain(N)
#define deallocSuper
#endif

/********* ARC SUPPORT ********************************************************/
#define TestLog
#ifdef TestLog
#define LOG_INFO(fmt, ...)  NSLog((@"[Info]: " fmt), ##__VA_ARGS__);
#define LOG_WARN(fmt, ...)  NSLog((@"[Warn]: " fmt), ##__VA_ARGS__);
#define LOG_ERROR(fmt, ...) NSLog((@"[Error]: " fmt), ##__VA_ARGS__);
#else
#define LOG_INFO(fmt, ...)
#define LOG_WARN(fmt, ...)
#define LOG_ERROR(fmt, ...)
#endif

/********* define *************************************************************/
#define DATA_BOUNDARY @"------HikvisionFormBoundary9sZiFmmnHIfIILI"

// 终端类型
#define MOBILE_TYPE_IPHONE      1       // iPhone
#define MOBILE_TYPE_IPAD        2       // iPad
#define MOBILE_TYPE_ANPHONE     3       // Android Phone
#define MOBILE_TYPE_ANPAD       4       // Android Pad
#define MOBILE_TYPE_WP7         5       // Windows Phone 7

// 监控点类型
#define CAMERA_TYPE_UNKNOWN     -1      // 未知类型
#define CAMERA_TYPE_BOX_CAMERA  0       // 枪机
#define CAMERA_TYPE_DOME_CAMERA 1       // 半球
#define CAMERA_TYPE_FAST_CAMERA 2       // 快球
#define CAMERA_TYPE_PTZ_CAMERA  3       // 带云台的枪机

// 标记点类型
#define POINT_TYPE_ALL          0       // 所有点(包含监控点、报警输入、报警输出、兴趣点)
#define POINT_TYPE_CAMERA       1       // 监控点
#define POINT_TYPE_ALARMIN      2       // 报警输入
#define POINT_TYPE_ALARMOUT     3       // 报警输出
#define POINT_TYPE_INTEREST     4       // 兴趣点

// 云台控制命令
#define PTZ_CMD_UP              1       // 云台向上
#define PTZ_CMD_DOWN            2       // 云台向下
#define PTZ_CMD_LEFT            3       // 云台向左
#define PTZ_CMD_RIGHT           4       // 云台向右
#define PTZ_CMD_BRIGHTEN        5       // 图像变亮
#define PTZ_CMD_DARKEN          6       // 图像变暗
#define PTZ_CMD_ZOOMIN          7       // 镜头拉近
#define PTZ_CMD_ZOOMOUT         8       // 镜头拉远
#define PTZ_CMD_FOCUSNEAR       9       // 镜头近焦
#define PTZ_CMD_FOCUSFAR        10      // 镜头远焦
#define PTZ_CMD_UPLEFT          11      // 云台左上
#define PTZ_CMD_UPRIGHT         12      // 云台右上
#define PTZ_CMD_DOWNLEFT        13      // 云台左下
#define PTZ_CMD_DOWNRIGHT       14      // 云台右下
#define PTZ_CMD_STOP            15      // 云镜停止
#define PTZ_CMD_AOTUPAN         16      // 自动扫描
#define PTZ_CMD_SETPRESET       17      // 设置预置点
#define PTZ_CMD_GOTOPRESET      18      // 转到预置点
#define PTZ_CMD_CLEPRESET       19      // 清空预置点

#define PTZ_CME_SCAN_OPEN       3      // 雨刷开
#define PTZ_CME_SCAN_CLOSE      3      // 雨刷关
#define PTZ_CME_LIGHT_OPEN      2      // 灯光开
#define PTZ_CME_LIGHT_CLOSE     2      // 灯光关
#define PTZ_CME_ONEKEYFORCUS_OPEN       24      // 聚焦开
#define PTZ_CME_ONEKEYFORCUS_CLOSE      25      // 聚焦关
#define PTZ_CME_INITCAMERA_OPEN         200      // 初始化相机开
#define PTZ_CME_INITCAMERA_CLOSE        201      // 初始化相机关
#define PTZ_CME_3DZOOM                  99      // 3D放大

// 录像类型
#define RECORD_TYPE_PLAN        1       // 计划录像
#define RECORD_TYPE_MOVE        2       // 移动录像
#define RECORD_TYPE_MANU        16      // 手动录像
#define RECORD_TYPE_ALARM       4       // 报警录像

// 存储位置类型
#define RECORD_POS_IPSAN        0       // IPSAN
#define RECORD_POS_DEVICE       1       // 设备录像
#define RECORD_POS_PCNVR        2       // PCNVR
#define RECORD_POS_ENVR         3       // ENVR
#define RECORD_POS_CISCO        4       // CISCO
#define RECORD_POS_DSNVR        5       // DSNVR
#define RECORD_POS_CVR          7       // CVR

// 错误码定义
#define VMSNETSDK_NO_ERROR                          0       // 没有错误

// 操作错误(100-120)
#define VMSNETSDK_INPUT_PARAM_ERROR                 100     // 输入参数错误

// http请求相关(120-140)
#define VMSNETSDK_HTTP_NEW_URL_OBJ_FAIL             120     // 创建url对象失败
#define VMSNETSDK_HTTP_NEW_REQUEST_OBJ_FAIL         121     // 创建request对象失败
#define VMSNETSDK_HTTP_REQUEST_TIMEOUT              122     // http请求超时
#define VMSNETSDK_HTTP_REQUEST_EXCEPTION            123     // http请求异常
#define VMSNETSDK_HTTP_REQUEST_RETURN_NOT_200       124     // http请求返回非200
#define VMSNETSDK_HTTP_REQUEST_RETURN_NULL          125     // http请求返回空

// XML解析相关(140-160)
#define VMSNETSDK_XMLPARSER_NEW_DATADOC_OBJ_FAIL    140     // 创建data doc对象失败
#define VMSNETSDK_XMLPARSER_GET_ROOTNODE_FAIL       141     // 获取root节点失败
#define VMSNETSDK_XMLPARSER_PARSESTATUS_FAIL        142     // 解析返回状态码和描述失败

// msp服务器返回错误(160-200)
#define VMSNETSDK_MSP_NO_DATA                       160     // 不存在数据
#define VMSNETSDK_MSP_PARAM_ERROR                   161     // URL请求时参数缺少或参数错误
#define VMSNETSDK_MSP_SESSION_ERROR                 162     // 会话错误
#define VMSNETSDK_MSP_USER_NOT_EXIST                163     // 用户不存在
#define VMSNETSDK_MSP_PASSOWRD_ERROR                164     // 密码错误
#define VMSNETSDK_MSP_DEVICE_NOT_EXIST              165     // 设备不存在
#define VMSNETSDK_MSP_CAMERA_NOT_EXIST              166     // 监控点不存在
#define VMSNETSDK_MSP_LINE_NOT_EXIST                167     // 线路不存在
#define VMSNETSDK_MSP_CTRLUNIT_NOT_EXIST            168     // 控制中心不存在
#define VMSNETSDK_MSP_REGION_NOT_EXIST              169     // 区域不存在
#define VMSNETSDK_MSP_VTDU_DISABLE                  170     // 流媒体没有被启用
#define VMSNETSDK_MSP_NO_PERMISSION                 171     // 没有权限
#define VMSNETSDK_MSP_RECORDPOS_NOT_EXIST           172     // 录像不存在
#define VMSNETSDK_MSP_USER_BLOCKED                  173     // 用户被冻结
#define VMSNETSDK_MSP_USER_LOGGIN                   174     // 用户已经登录
#define VMSNETSDK_MSP_NO_SUPPORT                    175     // 没有支持
#define VMSNETSDK_MSP_UNKNOWN_ERROR                 199     // 未知错误
#define VMSNETSDK_MSP_ERROR_NEED_DESCRIBE           198     // 平台需要提示的错误描述
#define VMSNETSDK_MSP_SERVER_EXCEPTION              200     // 服务器异常

#define PTZ_OUT_TIME           600

/********* struct *************************************************************/
typedef struct
{
	int year;
	int month;
	int day;
	int hour;
	int minute;
	int second;
}ABSTIME, *PABSTIME;

/********* classes ************************************************************/
//@interface VMSNetSDKDataType : NSObject
//
//@end

/**
 *	@brief	服务器信息
 */
@interface CServInfo : NSObject
{
    NSString    *_servAddr;                                                     // 服务器地址
    int          _port;                                                         // 服务器端口
}

@property (nonatomic, copy)     NSString    *servAddr;
@property (nonatomic, assign)   int          port;

@end

/**
 *	@brief	web app 信息
 */
@interface CWebAppInfo : NSObject
{
    NSString    *_appName;                                                      // app 名称
    NSString    *_appIconUrl;                                                   // app 图标链接
    NSString    *_appLinkUrl;                                                   // app 连接地址
    int          _appIndex;                                                     // app 排序位置
}

@property (nonatomic, copy)     NSString *appName;
@property (nonatomic, copy)     NSString *appIconUrl;
@property (nonatomic, copy)     NSString *appLinkUrl;
@property (nonatomic, assign)   int       appIndex;

@end

/**
 *	@brief	MSP登录信息,登录MSP后返回
 */
@interface CMSPInfo : NSObject
{
    BOOL             _isWebAppDefaultSel;                                       // web app 是否默认选中
    BOOL             _isLocalTitleVisible;                                      // 本地标题栏是否可见，1:可见 0:不可见
    NSString        *_sessionID;                                                // 会话ID
    NSString        *_userCapability;                                           // 用户能力集
    NSString        *_userID;                                                   // 用户ID
    NSMutableArray  *_vmsList;                                                  // 电视墙服务器信息列表
    NSMutableArray  *_webAppList;                                               // web app 列表 (元素为WebAppInfo)
    CServInfo       *_ptzProxyInfo;                                             // 云台代理服务器信息
    CServInfo       *_magInfo;                                                  // MAG服务器信息
    CServInfo       *_vtduInfo;                                                 // VTDU服务器信息
    CServInfo       *_picServerInfo;                                            // 图片服务器信息
}

@property (nonatomic, assign)   BOOL            isWebAppDefaultSel;
@property (nonatomic, assign)   BOOL            isLocalTitleVisible;
@property (nonatomic, copy)     NSString        *sessionID;
@property (nonatomic, copy)     NSString        *userCapability;
@property (nonatomic, copy)     NSString        *userID;
@property (nonatomic, retain)   NSMutableArray  *vmsList;
@property (nonatomic, retain)   NSMutableArray  *webAppList;
@property (nonatomic, retain)   CServInfo       *ptzProxyInfo;
@property (nonatomic, retain)   CServInfo       *magInfo;
@property (nonatomic, retain)   CServInfo       *vtduInfo;
@property (nonatomic, retain)   CServInfo       *picServerInfo;

@end

/**
 *	@brief	控制中心
 */
@interface CControlUnitInfo : NSObject
{
    int       _controlUnitID;                                                   // 控制中心ID
    int       _parentID;                                                        // 控制中心父亲ID
    NSString *_name;                                                            // 控制中心名称
}

@property (nonatomic, assign)   int              controlUnitID;
@property (nonatomic, assign)   int              parentID;
@property (nonatomic, copy)     NSString        *name;

@end

/**
 *	@brief	区域信息
 */
@interface CRegionInfo : NSObject
{
    int       _regionID;                                                        // 区域ID
    int       _controlUnitID;                                                   // 控制中心ID
    int       _parentID;                                                        // 控制中心父亲ID
    NSString *_name;                                                            // 控制中心名称
}

@property (nonatomic, assign)   int              regionID;
@property (nonatomic, assign)   int              controlUnitID;
@property (nonatomic, assign)   int              parentID;
@property (nonatomic, copy)     NSString        *name;

@end

/**
 *	@brief	设备信息
 */
@interface CDeviceInfo : NSObject
{
    NSString *_cameraID;                                                        // 监控点ID
    NSString *_deviceIP;                                                        // 设备IP
    int       _devicePort;                                                      // 设备端口
    NSString *_userName;                                                        // 用户名
    NSString *_password;                                                        // 密码
    NSString *_deviceType;                                                      // 设备类型
    NSString *_deviceSupplier;                                                  // 设备供应商(V1.1)HIKVISION、DAHUA
}
@property (nonatomic, copy)     NSString    *cameraID;
@property (nonatomic, copy)     NSString    *deviceIP;
@property (nonatomic, assign)   int          devicePort;
@property (nonatomic, copy)     NSString    *userName;
@property (nonatomic, copy)     NSString    *password;
@property (nonatomic, copy)     NSString    *deviceType;
@property (nonatomic, copy)     NSString    *deviceSupplier;

@end

/**
 *	@brief	监控点信息
 */
@interface CCameraInfo : NSObject
{
    NSString       *_cameraID;                                                  // 监控点ID
    NSString       *_name;                                                      // 监控点名称
    int             _cameraType;                                                // 监控点类型
    BOOL            _isOnline;                                                  // 监控点是否在线
    BOOL            _isPTZControl;                                              // 是否具有云台控制权限(V1.1)
    NSString       *_deviceID;                                                  // 设备ID
    int             _channelNo;                                                 // 通道号
    NSMutableArray *_userCapability;                                            // 用户能力说明 1: 实时预览  2: 远程回放
    NSMutableArray *_recordPos;                                                 // 录像位置
    NSString       *_acsIP;                                                     // 云台控制IP
    int             _acsPort;                                                   // 云台控制端口
    int             _collectedFlag;                                             // 收藏标识 0: 未收藏 1: 收藏
    int             _groupID;                                                   // 该监控点所在平台分组id
    int             _cascadeFlag;                                               // 级联标识 0: 非级联 1: 级联
    NSString       *_longitude;                                                 // 经度(实际度*3600*100)
    NSString       *_latitude;                                                  // 纬度(实际度*3600*100)
}

@property (nonatomic, copy)     NSString        *cameraID;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, assign)   int              cameraType;
@property (nonatomic, assign)   BOOL             isOnline;
@property (nonatomic, assign)   BOOL             isPTZControl;
@property (nonatomic, copy)     NSString        *deviceID;
@property (nonatomic, assign)   int              channelNo;
@property (nonatomic, retain)   NSMutableArray  *userCapability;
@property (nonatomic, retain)   NSMutableArray  *recordPos;
@property (nonatomic, copy)     NSString        *acsIP;
@property (nonatomic, assign)   int              acsPort;
@property (nonatomic, assign)   int              collectedFlag;
@property (nonatomic, assign)   int              groupID;
@property (nonatomic, assign)   int              cascadeFlag;
@property (nonatomic, copy)     NSString        *longitude;
@property (nonatomic, copy)     NSString        *latitude;

@end

/**
 *	@brief	录像片段信息
 */
@interface CRecordSegment : NSObject
{
    ABSTIME   _beginTime;                                                       // 开始时间
    ABSTIME   _endTime;                                                         // 结束时间
    int       _recordType;                                                      // 录像类型
    int       _mediaDataLen;                                                    // 媒体数据大小
    int       _metaDataLen;
    BOOL      _isLocked;                                                        // 是否锁定录像
    NSString *_playUrl;                                                         // 播放地址
}

@property (nonatomic, assign)   ABSTIME          beginTime;
@property (nonatomic, assign)   ABSTIME          endTime;
@property (nonatomic, assign)   int              recordType;
@property (nonatomic, assign)   int              mediaDataLen;
@property (nonatomic, assign)   int              metaDataLen;
@property (nonatomic, assign)   BOOL             isLocked;
@property (nonatomic, copy)     NSString        *playUrl;

/**
 *	@brief	设置开始时间
 *
 *	@param 	beginTime 	开始时间
 */
- (void)setBeginTime:(ABSTIME)beginTime;

/**
 *	@brief	设置结束时间
 *
 *	@param 	endTime 	结束时间
 */
- (void)setEndTime:(ABSTIME)endTime;

@end

/**
 *	@brief	录像信息
 */
@interface CRecordInfo : NSObject
{
    int              _queryType;                                                // 录像类型
    BOOL             _isRecvAll;                                                // 是否接收完毕
    int              _segmentCount;                                             // 录像片段数
    NSString        *_segmentListPlayUrl;                                       // 录像片段播放地址
    NSMutableArray  *_recSegmentList;                                           // 录像片段列表
}

@property (nonatomic, assign)   int               queryType;
@property (nonatomic, assign)   BOOL              isRecvAll;
@property (nonatomic, assign)   int               segmentCount;
@property (nonatomic, copy)     NSString         *segmentListPlayUrl;
@property (nonatomic, retain)   NSMutableArray   *recSegmentList;

@end

/**
 *	@brief	客户端版本信息
 */
@interface CClientVersionInfo : NSObject
{
    NSString *_versionDesc;                                                     // 最新版本描述,格式为V3.00.00 build20120512
    NSString *_downloadAddr;                                                    // 软件下载地址
}

@property (nonatomic, copy) NSString *versionDesc;
@property (nonatomic, copy) NSString *downloadAddr;

@end

/**
 *	@brief	服务器版本信息
 */
@interface CServerVersionInfo : NSObject
{
    int       _platformID;                                                      // 平台ID
    NSString *_platformVersion;                                                 // 平台版本
    NSString *_MSPVersion;                                                      // MSP版本信息
    NSString *_MAGVersion;                                                      // MAG版本信息
    NSString *_VTDUVersion;                                                     // VTDU版本信息
    NSString *_PTZProxyVersion;                                                 // 云台代理服务器版本信息
    NSString *_VMSVersion;                                                      // 电视墙服务器版本信息
}

@property (nonatomic, assign)   int       platformID;
@property (nonatomic, copy)     NSString *platformVersion;
@property (nonatomic, copy)     NSString *MSPVersion;
@property (nonatomic, copy)     NSString *MAGVersion;
@property (nonatomic, copy)     NSString *VTDUVersion;
@property (nonatomic, copy)     NSString *PTZProxyVersion;
@property (nonatomic, copy)     NSString *VMSVersion;

@end

/**
 *	@brief	线路信息
 */
@interface CLineInfo : NSObject
{
    int         _lineID;                                                        // 线路ID
    NSString   *_lineName;                                                      // 线路名称
}

@property (nonatomic, assign)   int       lineID;
@property (nonatomic, copy)     NSString *lineName;

@end

/**
 *	@brief	设备GPS信息
 */
@interface CDeviceGPSInfo : NSObject
{
    NSString *_deviceID;                                                        // 设备ID
    NSString *_gpsTime;                                                         // GSP采集时间
    int       _speed;                                                           // 速度(实际速度*100)
    int       _direction;                                                       // 方向(厘米/小时)
    int       _longitude;                                                       // 经度(实际度*3600*100)
    int       _latitude;                                                        // 纬度(实际度*3600*100)
}

@property (nonatomic, copy)     NSString *deviceID;
@property (nonatomic, copy)     NSString *gpsTime;
@property (nonatomic, assign)   int       speed;
@property (nonatomic, assign)   int       direction;
@property (nonatomic, assign)   int       longitude;
@property (nonatomic, assign)   int       latitude;

@end

/**
 *	@brief	GIS点信息
 */
@interface CGISCameraInfo : NSObject
{
    NSString       *_cameraID;                                                  // 监控点ID
    NSString       *_name;                                                      // 监控点名称
    int             _cameraType;                                                // 监控点类型
    BOOL            _isOnline;                                                  // 监控点是否在线
    NSMutableArray *_userCapability;                                            // 用户能力说明 1: 实时预览  2: 远程回放
    NSString       *_longitude;                                                 // 经度(实际度*3600*100)
    NSString       *_latitude;                                                  // 纬度(实际度*3600*100)
}

@property (nonatomic, copy)     NSString        *cameraID;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, assign)   int              cameraType;
@property (nonatomic, assign)   BOOL             isOnline;
@property (nonatomic, retain)   NSMutableArray  *userCapability;
@property (nonatomic, copy)     NSString        *longitude;
@property (nonatomic, copy)     NSString        *latitude;

@end

/**
 *	@brief	播放地址
 */
@interface CRealPlayURL : NSObject
{
    NSString       *_url1;                                                      // vtdu地址
    NSString       *_url2;                                                      // mag地址
}

@property (nonatomic, copy)     NSString        *url1;
@property (nonatomic, copy)     NSString        *url2;

@end
