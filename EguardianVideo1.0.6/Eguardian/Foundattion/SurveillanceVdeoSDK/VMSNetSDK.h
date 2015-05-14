//
//  VMSNetSDK.h
//  VMSNetSDK
//
//  Created by Dengsh on 13-7-31.
//  Copyright (c) 2013年 chenmengyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMSNetSDKDataType.h"

@interface VMSNetSDK : NSObject

/**
 *	@brief	获取VMSNetSDK单例
 *
 *	@return	VMSNetSDK单例
 */
+ (VMSNetSDK *) shareInstance;

#pragma mark -
#pragma mark - 和MSP服务器交互部分
/**
 *	@brief	获取客户端最新版本
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	curVersion 	[in] 当前版本号
 *	@param 	mobileType 	[in] 移动客户端类型
 *	@param 	clientVersionInfo 	[out] 客户端版本信息
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getClientNewestVersion:(NSString *)servAddr
                   toCurVersion:(NSString *)curVersion
                         toType:(int)mobileType
            toClientVersionInfo:(CClientVersionInfo *)clientVersionInfo;

/**
 *	@brief	获取服务器版本信息
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	serverVersionInfo 	[out] 服务器版本信息
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getServerVersion:(NSString *)servAddr
          toServerVersion:(CServerVersionInfo *)serverVersionInfo;

/**
 *	@brief	获取通信线路
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	lineInfoList 	[out] 通信线路列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getLineList:(NSString *)servAddr
      toLineInfoList:(NSMutableArray *)lineInfoList;

/**
 *	@brief	登录msp服务器
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	userName 	[in] 用户名
 *	@param 	password 	[in] 密码
 *	@param 	lineID 	    [in] 线路id
 *	@param 	mspInfo 	[out] msp服务器信息
 *
 *	@return	YES 登录成功 NO 登录失败
 */
- (BOOL) login:(NSString *)servAddr
    toUserName:(NSString *)userName
    toPassword:(NSString *)password
      toLineID:(int)lineID
    toServInfo:(CMSPInfo *)mspInfo;

/**
 *	@brief	登出MSP服务器
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *
 *	@return	YES 登出成功 NO 登出失败
 */
- (BOOL) logout:(NSString *)servAddr
    toSessionID:(NSString *)sessionID;

/**
 *	@brief	获取指定控制中心下的控制中心列表
 *
 *	@param 	servAddr        [in] 服务器地址
 *	@param 	sessionID       [in] 会话id
 *	@param 	controlUnitID 	[in] 父控制中心id 如果为根控制中心，则为0
 *	@param 	numPerPage      [in] 分页获取，每页获取的个数
 *	@param 	curPage         [in] 当前页数
 *	@param 	controlUnitList [out] 获取的控制中心列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getControlUnitList:(NSString *)servAddr
                toSessionID:(NSString *)sessionID
            toControlUnitID:(int)controlUnitID
               toNumPerOnce:(int)numPerPage
                  toCurPage:(int)curPage
          toControlUnitList:(NSMutableArray *)controlUnitList;

/**
 *	@brief	获取指定控制中心下的区域列表
 *
 *	@param 	servAddr        [in] 服务器地址
 *	@param 	sessionID       [in] 会话id
 *	@param 	controlUnitID 	[in] 父控制中心id
 *	@param 	numPerPage      [in] 分页获取，每页获取的个数
 *	@param 	curPage         [in] 当前页数
 *	@param 	regionList      [out] 获取的区域列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getRegionListFromCtrlUnit:(NSString *)servAddr
                       toSessionID:(NSString *)sessionID
                   toControlUnitID:(int)controlUnitID
                      toNumPerOnce:(int)numPerPage
                         toCurPage:(int)curPage
                      toRegionList:(NSMutableArray *)regionList;

/**
 *	@brief	获取指定区域下的区域列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	regionID 	[in] 父区域id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *	@param 	regionList 	[out] 获取的区域列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getRegionListFromRegion:(NSString *)servAddr
                     toSessionID:(NSString *)sessionID
                      toRegionID:(int)regionID
                    toNumPerOnce:(int)numPerPage
                       toCurPage:(int)curPage
                    toRegionList:(NSMutableArray *)regionList;

/**
 *	@brief	获取指定控制中心下的监控点列表
 *
 *	@param 	servAddr        [in] 服务器地址
 *	@param 	sessionID       [in] 会话id
 *	@param 	controlUnitID 	[in] 父控制中心id
 *	@param 	numPerPage      [in] 分页获取，每页获取的个数
 *	@param 	curPage         [in] 当前页数
 *	@param 	cameraList      [out] 获取的监控点列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getCameraListFromCtrlUnit:(NSString *)servAddr
                       toSessionID:(NSString *)sessionID
                   toControlUnitID:(int)controlUnitID
                      toNumPerOnce:(int)numPerPage
                         toCurPage:(int)curPage
                      toCameraList:(NSMutableArray *)cameraList;

/**
 *	@brief	获取指定区域下的监控点列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	regionID 	[in] 父区域id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *	@param 	cameraList 	[out] 获取的监控点列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getCameraListFromRegion:(NSString *)servAddr
                     toSessionID:(NSString *)sessionID
                      toRegionID:(int)regionID
                    toNumPerOnce:(int)numPerPage
                       toCurPage:(int)curPage
                    toCameraList:(NSMutableArray *)cameraList;

/**
 *	@brief	获取设备信息
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	deviceID 	[in] 设备id
 *	@param 	deviceInfo 	[out] 设备信息
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getDeviceInfo:(NSString *)servAddr
           toSessionID:(NSString *)sessionID
            toDeviceID:(NSString *)deviceID
          toDeviceInfo:(CDeviceInfo *)deviceInfo;

/**
 *	@brief	获取监控点播放地址
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	realPlayURL [out] 监控点播放地址
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL) getRealPlayURL:(NSString *)servAddr
            toSessionID:(NSString *)sessionID
             toCameraID:(NSString *)cameraID
          toRealPlayURL:(CRealPlayURL *)realPlayURL
           toStreamType:(int) streamType;

/**
 *	@brief	发送云台开始命令
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	port        [in] 服务器端口
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	cmdID 	[in] 云台命令 见VMSNetSDKDataType.h 云台控制命令宏
 *	@param 	param1 	[in] 云台参数1：云台转动时转动速度（1-10）或者 预置点操作时预置点编号 或者 3d放大时起始点x坐标
 *	@param 	param2 	[in] 云台参数2：3d放大时起始点y坐标
 *	@param 	param3 	[in] 云台参数3：3d放大时终止点x坐标
 *	@param 	param4 	[in] 云台参数4：3d放大时终止点y坐标
 *
 *	@return	YES 发送成功 NO 发送失败
 */
- (BOOL) sendStartPTZCmd:(NSString *)servAddr
                  toPort:(int)port
             toSessionID:(NSString *)sessionID
              toCameraID:(NSString *)cameraID
                 toCmdID:(int)cmdID
                toParam1:(int)param1
                toParam2:(int)param2
                toParam3:(int)param3
                toParam4:(int)param4;

/**
 *	@brief	发送云台停止命令
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	port        [in] 服务器端口
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *
 *	@return	YES 发送成功 NO 发送失败
 */
- (BOOL) sendStopPTZCmd:(NSString *)servAddr
                 toPort:(int)port
            toSessionID:(NSString *)sessionID
             toCameraID:(NSString *)cameraID;

/**
 *	@brief	查询录像
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	recordType 	[in] 录像类型：1－计划录像 2－移动录像 16－手动录像 4－报警录像 拼接完的RecordType (用逗号隔开)
 *	@param 	recordPos 	[in] 录像存储位置：0－IPSAN 1－设备录像 2－PCNVR 3-ENVR 4-CISCO 5-DSNVR 7-CVR 目前只提供单条件查询
 *	@param 	startTime 	[in] 录像开始时间
 *	@param 	endTime 	[in] 录像结束时间
 *	@param 	recordInfo 	[out] 查询到的录像信息
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)queryCameraRecord:(NSString *)servAddr
              toSessionID:(NSString *)sessionID
               toCameraID:(NSString *)cameraID
             toRecordType:(NSString *)recordType
              toRecordPos:(NSString *)recordPos
              toStartTime:(ABSTIME *)startTime
                toEndTime:(ABSTIME *)endTime
             toRecordInfo:(CRecordInfo *)recordInfo;

/**
 *	@brief	添加收藏
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	groupID 	[in] 分组id 目前都为1
 *
 *	@return	YES 添加成功 NO 添加失败
 */
- (BOOL)collectCamera:(NSString *)servAddr
          toSessionID:(NSString *)sessionID
           toCameraID:(NSString *)cameraID
            toGroupID:(int)groupID;

/**
 *	@brief	删除收藏
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	groupID 	[in] 分组id 目前都为1
 *
 *	@return	YES 删除成功 NO 删除失败
 */
- (BOOL)discollectCamera:(NSString *)servAddr
             toSessionID:(NSString *)sessionID
              toCameraID:(NSString *)cameraID
               toGroupID:(int)groupID;

/**
 *	@brief	获取收藏列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)getCollectedCamera:(NSString *)servAddr
               toSessionID:(NSString *)sessionID
              toNumPerOnce:(int)numPerPage
                 toCurPage:(int)curPage
              toCameraList:(NSMutableArray *) cameraList;

/**
 *	@brief	获取摄像头gis信息列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *	@param 	gisCameraInfoList 	[out] 获取到的gis信息列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)getGISCamera:(NSString *)servAddr
         toSessionID:(NSString *)sessionID
        toNumPerOnce:(int)numPerPage
           toCurPage:(int)curPage
 toGISCameraInfoList:(NSMutableArray *)gisCameraInfoList;

/**
 *	@brief	名称搜索摄像头gis信息列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *	@param 	keyString 	[in] 搜索的监控点名称的关键字
 *	@param 	gisCameraInfoList 	[out] 获取到的gis信息列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)getGISCameraByName:(NSString *)servAddr
               toSessionID:(NSString *)sessionID
              toNumPerOnce:(int)numPerPage
                 toCurPage:(int)curPage
               toKeyString:(NSString *)keyString
       toGISCameraInfoList:(NSMutableArray *)gisCameraInfoList;

/**
 *	@brief	定位搜索摄像头gis信息列表
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	numPerPage 	[in] 分页获取，每页获取的个数
 *	@param 	curPage 	[in] 当前页数
 *	@param 	keyString 	[in] 搜索的监控点名称的关键字
 *	@param 	longitude 	[in] 经度
 *	@param 	latitude 	[in] 纬度
 *	@param 	radius      [in] 搜索半径
 *	@param 	gisCameraInfoList 	[out] 获取到的gis信息列表
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)getGISCameraByPostion:(NSString *)servAddr
                  toSessionID:(NSString *)sessionID
                 toNumPerOnce:(int)numPerPage
                    toCurPage:(int)curPage
                  toKeyString:(NSString *)keyString
                  toLongitude:(NSString *)longitude
                   toLatitude:(NSString *)latitude
                     toRadius:(int)radius
          toGISCameraInfoList:(NSMutableArray *)gisCameraInfoList;

/**
 *	@brief	获取监控点详细信息
 *
 *	@param 	servAddr 	[in] 服务器地址
 *	@param 	sessionID 	[in] 会话id
 *	@param 	cameraID 	[in] 监控点id
 *	@param 	cameraDetailInfo 	[out] 监控点详细信息
 *
 *	@return	YES 获取成功 NO 获取失败
 */
- (BOOL)getCameraDetailInfo:(NSString *)servAddr
                toSessionID:(NSString *)sessionID
                 toCameraID:(NSString *)cameraID
         toCameraDetailInfo:(CCameraInfo *)cameraDetailInfo;

/**
 *	@brief	获取SDK版本
 *
 *	@return	sdk版本
 */
- (NSString *) getSDKVersion;

/**
 *	@brief	获取错误码
 *
 *	@return	错误码
 */
- (int) getLastErrorCode;

/**
 *	@brief	获取错误描述
 *
 *	@return	错误描述
 */
- (NSString *) getLastErrorDesc;

@end
