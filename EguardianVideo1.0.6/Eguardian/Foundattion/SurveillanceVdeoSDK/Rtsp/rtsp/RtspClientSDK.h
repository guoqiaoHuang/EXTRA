/** @file RtspClient.h
 *   @note HangZhou Hikvision System Technology Co., Ltd. All Right Reserved.
 *   @brief RTSP通信库头文件
 *  This file defines the API for RtspClient.dll
 *   @author     Weilinfeng
 *   @date       2010-09-07
 *
 *   @note Created By Weilinfeng 2010-09-07
 *
 *   @warning
 */

#ifndef __RTSPCLIENTSDK_H__
#define __RTSPCLIENTSDK_H__

#ifdef __cpluscplus
#define RTSPCLIENTSDK_API extern
#else
#define  RTSPCLIENTSDKAPI
#endif

//#ifdef __cplusplus
//extern "C"
//{
//#endif

//#define TEST

#define RTSP_BASE_PORT				10000
#define RTSPCLIENT_MAXNUM			32

#define RTSPCLIENT_INVALIDATE_ENGINEID		-1
#define LIB_TAG								"RtspClientSDK"


#define RTSP_NPT_TIMETYPE                   0x8100  //NPT时间
#define RTSP_SMPTE_TIMETYPE                 0x8101	//SMPTE时间
#define RTSP_CLOCK_TIMETYPE                 0x8102	//壁钟时间

/******************************传输方式********************************************************/
#define RTPTCP_TRANSMODE				    0x0000	//RTP over TCP
#define RTPUDP_TRANSMODE				    0x0001	//RTP over UDP
#define RTPRTSP_TRANSMODE				    0x0003	//RTP over RTSP
#define RTPUDP_RELIABLE_TRANSMODE		    0x0004	//Reliable RTP over UDP
#define RTPMCAST_TRANSMODE				    0x0005	//RTP over multicast

/******************************流类型********************************************************/
#define DATATYPE_HEADER					    1		//头数据
#define DATATYPE_STREAM					    2		//流数据


#define RTSPCLIENT_INVALIDATE_ENGINEID		-1

#define LIB_TAG								"RtspClientSDK"

/******************************错误码********************************************************/

#define RTSPCLIENT_HPR_INIT_FAIL 						1 // HPR初始化失败
#define RTSPCLIENT_MSG_MANAGE_RUN_FAIL					2 // 消息队列启动失败
#define RTSPCLIENT_NO_INIT								3 // RtspClient未初始化
#define RTSPCLIENT_PROTOCOL_NOTSUPPORT      			4 // 协议不支持
#define RTSPCLIENT_CALLBACK_PARAM_NULL					5 // 回调参数为空
#define RTSPCLIENT_MOLLOC_RTSPENGINE_FAIL				6 // 创建Rtsp引擎失败
#define RTSPCLIENT_RTSPENGINE_EXCEED_ERROR				7 // 分配Rtsp引擎数超过最大数（32）
#define RTSPCLIENT_ENGINEID_INVALID						8 // 无效的引擎ID
#define RTSPCLIENT_ENGINE_NOT_EXSIT						9 // 引擎不存在
#define RTSPCLIENT_ENGINE_NULL							10 //引擎为空
#define RTSPCLIENT_START_TIME_NULL						11 // 开始时间为空
#define RTSPCLIENT_DEV_NAMEORPSW_NULL					12 // 设备名称或者密码为空
#define RTSPCLIENT_BASEPORT_ERROR						13 // 错误的基础端口号
#define RTSPCLIENT_MALLOC_MEMORY_FAIL					14 // 内存分配失败
#define RTSPCLIENT_ENGINEER_NOINIT						15 // 引擎未初始化
#define RTSPCLIENT_VERSION_PROTOCOL_NOTSUPPORT			16 // MAG、VTDU4.0不支持Rtp or Tcp
#define RTSPCLIENT_RTSPURL_ERROR						17 // Rtsp地址错误
#define RTSPCLIENT_CONNECT_SERVER_FAIL					18 // 连接流媒体服务器失败
#define RTSPCLIENT_NO_PLAY_STATE						19	// 不在播放状态

#define RTSPCLIENT_DECRIBE_REDIRCT_FAIL					101 // Describe重定向失败
#define RTSPCLIENT_GENERATE_DESCRIBE_FAIL				102 // 生成Describe信令失败
#define RTSPCLIENT_SEND_DESCRIBE_FAIL					103 // 发送Describe信令失败
#define RTSPCLIENT_RECV_DESCRIBE_FAIL					104 // 接受Describe信令失败
#define RTSPCLIENT_DESCRIBE_STATUS_NO_200OK				105 // Describe回复非200OK
#define RTSPCLIENT_PARSE_DESCRIBE_FAIL					106 // Describe解析失败

#define RTSPCLIENT_GENERATE_SETUP_FAIL					201 // 生成Setup信令失败
#define RTSPCLIENT_SEND_SETUP_FAIL						202 // 发送Setup信令失败
#define RTSPCLIENT_RECV_SETUP_FAIL						203 // 接收Setup信令失败
#define RTSPCLIENT_SETUP_STATUS_NO_200OK				204 // Setup回复非200OK
#define RTSPCLIENT_PARSE_SETUP_FAIL						205 // 解析Setup失败

#define RTSPCLIENT_GENERATE_PLAY_FAIL					301 // 生成Play信令失败
#define RTSPCLIENT_SEND_PLAY_FAIL						302 // 发送Play信令失败
#define RTSPCLIENT_RECV_PLAY_FAIL						303 // 接收Play信令失败
#define RTSPCLIENT_PLAY_STATUS_NO_200OK					304 // Play回复非200OK

#define RTSPCLIENT_GENERATE_CHANGERATE_FAIL				401 // 创建改变速率信令失败
#define RTSPCLIENT_SEND_CHANGERATE_FAIL					402 // 发送改变速率信令失败
#define RTSPCLIENT_RECV_CHANGERATE_FAIL					403 // 接收改变速率信令失败
#define RTSPCLIENT_CHANGERATE_STATUS_NO_200OK			404 // 改变速率回复非200OK

#define RTSPCLIENT_GENERATE_FORCEIFRAME_FAIL			501 // 创建强制I帧信令失败
#define RTSPCLIENT_SEND_FORCEIFRAME_FAIL				502 // 发送强制I帧信令失败
#define RTSPCLIENT_RECV_FORCEIFRAME_FAIL				503 // 接收强制I帧信令失败
#define RTSPCLIENT_FORCEIFRAME_STATUS_NO_200OK			504 // 强制I帧回复非200OK

#define RTSPCLIENT_GENERATE_RANDOMPLAY_FAIL				601 // 创建随机定位信令失败
#define RTSPCLIENT_SEND_RANDOMPLAY_FAIL					602 // 发送随机定位信令失败
#define RTSPCLIENT_RECV_RANDOMPLAY_FAIL					603 // 接收随机定位信令失败
#define RTSPCLIENT_RANDOMPLAY_STATUS_NO_200OK			604 // 随机定位回复非200OK

#define RTSPCLIENT_GENERATE_PAUSE_FAIL					701 // 创建暂停信令失败
#define RTSPCLIENT_SEND_PAUSE_FAIL						702 // 发送暂停信令失败
#define RTSPCLIENT_RECV_PAUSE_FAIL						703 // 接收暂停信令失败
#define RTSPCLIENT_PAUSE_STATUS_NO_200OK				704 // 暂停回复非200OK
#define RTSPCLIENT_NOT_PAUSE_STATE_FAIL					705 // 不在暂停状态

#define RTSPCLIENT_GENERATE_RESUME_FAIL					801 // 创建恢复信令失败
#define RTSPCLIENT_SEND_RESUME_FAIL						802 // 发送恢复信令失败
#define RTSPCLIENT_RECV_RESUME_FAIL						803 // 接收恢复信令失败
#define RTSPCLIENT_RESUME_STATUS_NO_200OK				804 // 恢复回复非200OK


#define RTSPCLIENT_MOLLOC_RTPUDPENGINE_FAIL				901 // 创建RtpUdp引擎失败
#define RTSPCLIENT_INIT_RTPUDPENGINE_FAIL				902 // 初始化RtpUdp引擎失败
#define RTSPCLIENT_START_RTPUDPENGINE_FAIL				903 // 开始RtpUdp引擎失败

#define RTSPCLIENT_MOLLOC_RTCPUDPENGINE_FAIL			1001 // 创建RtcpUdp引擎失败
#define RTSPCLIENT_INIT_RTCPUDPENGINE_FAIL				1002 // 初始化RtcpUdp引擎失败
#define RTSPCLIENT_START_RTCPUDPENGINE_FAIL				1003 // 开始RtcpUdp引擎失败

#define RTSPCLIENT_MOLLOC_RTPTCPENGINE_FAIL				1101 // 创建RtpTcp引擎失败
#define RTSPCLIENT_INIT_RTPTCPENGINE_FAIL				1102 // 初始化RtpTcp引擎失败
#define RTSPCLIENT_START_RTPTCPENGINE_FAIL				1103 // 开始 RtpTcp引擎失败

#define RTSPCLIENT_MOLLOC_RTPRTSPENGINE_FAIL		    1201 // 创建RtpRtsp引擎失败
#define RTSPCLIENT_INIT_RTPRTSPENGINE_FAIL				1202 // 初始化RtpRtsp引擎失败
#define RTSPCLIENT_START_RTPRTSPENGINE_FAIL				1203 // 开始RtpRtsp引擎失败


#define RTSPCLIENT_MSG_PLAYBACK_FINISH      0x0100 //回放数据接收完成
#define RTSPCLIENT_MSG_BUFFER_OVERFLOW		0x0101 //数据缓存不足，建议切换低分辨率
#define RTSPCLIENT_MSG_CONNECTION_EXCEPTION	0x0102 //RTSP连接异常，建议关闭重新请求
#define RTSPCLIENT_MSG_ISCONNECTING			0x0103 // 重连中


typedef int (*pRtspDataCallback)(int handle, int dataType, char* data, int len, unsigned int timestamp, int packetNo, void* pUser);
typedef int (*pRtspMsgCallback)(int handle, int opt, void* param1, void* param2, void* pUser);

typedef struct _ABS_TIME_
{
    unsigned int dwYear;
    unsigned int dwMonth;
    unsigned int dwDay;
    unsigned int dwHour;
    unsigned int dwMinute;
    unsigned int dwSecond;
}ABS_TIME, *pABS_TIME;

/** @fn bool RtspClientInitLib()
 *   @brief 初始化RTSP库
 *   @param [in] 无
 *   @param [out] 无
 *   @return true - 初始化成功; false - 初始化库失败
 */
RTSPCLIENTSDKAPI bool RtspClientInitLib();

/** @fn bool RtspClientFiniLib()
 *   @brief 释放RTSP库
 *   @param [in] 无
 *   @param [out] 无
 *   @return 无
 */
RTSPCLIENTSDKAPI bool RtspClientFiniLib();

/** @fn bool RtspClientCreateEngine()
 *   @brief 初始化RTSP库
 *   @param [in] rtpProtocol - RTP传输协议
 *   @param [in] dataCallBack - 数据回调函数
 *   @param [in] msgCallback - 消息回调函数
 *   @param [out] handle	- 引擎句柄
 *   @return true - 初始化成功; false - 初始化库失败
 */
RTSPCLIENTSDKAPI int RtspClientCreateEngine(int tansmethod,
                                            int (*pRTSPDataCallback)(int handle, int dataType, char* data, int len, unsigned int timestamp, int packetNo, void* pUser), 
                                            int (*pRTSPMsgCallback)(int handle, int opt, void* param1, void* param2, void* pUser), 
                                            void* pUser);

/** @fn bool RtspClientReleaseEngine(void* handle)
 *   @brief 释放RTSP库
 *   @param [in] handle - 引擎句柄
 *   @param [out] 无
 *   @return true - 成功; false - 失败
 */
RTSPCLIENTSDKAPI bool RtspClientReleaseEngine( int engineId );

/** @fn bool RtspClientStartRtspProc()
 *   @brief 开始Rtsp流程, 向服务器发送Describe\Setup\Play信令
 *   @param [in] handle - 引擎句柄
 *   @param [in] pszRtspUrl - Rtsp地址
 *   @param [out] 无
 *   @return true - 打开成功, false - 打开失败
 */
//RTSPCLIENTSDKAPI bool RtspClientStartRtspProc( int engineId, const char* pszRtspUrl);

/** @fn bool RtspClientStartRtspProc()
 *   @brief 开始Rtsp流程, 向服务器发送Describe\Setup\Play信令
 *   @param [in] handle - 引擎句柄
 *   @param [in] pszRtspUrl - Rtsp地址
 *   @param [out] 无
 *   @return true - 打开成功, false - 打开失败
 */
RTSPCLIENTSDKAPI bool RtspClientStartRtspProc( int engineId, const char* pszRtspUrl, const char* deviceName, const char* devicePsw);

/** @fn bool RtspClientStopRtspProc(void* handle )
 *   @brief 停止RTSP库
 *   @param [in] handle - 引擎句柄
 *   @param [out] 无
 *   @return true - 停止成功; false - 停止失败
 */
RTSPCLIENTSDKAPI bool RtspClientStopRtspProc(int engineId);

/** @fn bool RtspClientPlaybackByTime
 *   @brief 按时间回放
 *   @param [in] handle - 引擎句柄
 *   @param [in] pszRtspUrl - 回放地址
 *   @param [in] deviceName - 设备名称
 *   @param [in] devicePsw - 设备密码
 *   @param [out] 无
 *   @param [out] 无
 *   @return true - 播放成功, false - 播放失败
 */
RTSPCLIENTSDKAPI bool RtspClientPlaybackByTime(int engineId, const char* pszRtspUrl, const char* deviceName, const char* devicePsw, pABS_TIME from, pABS_TIME to);

/** @fn bool RtspClientPause(void* handle)
 *   @brief 在绝对时间范围内，随机定位
 *   @param [in] handle - 引擎句柄
 *   @param [in] pfrom - 回放开始时间
 *   @param [in] pto - 回放结束时间，默认为空
 *   @param [out] 无
 *   @return true - 成功, false - 失败
 */
RTSPCLIENTSDKAPI bool RtspClientSetPlaybackPos(int engineId, pABS_TIME pfrom, pABS_TIME pto);

/** @fn bool RtspClientChangeRate(void* handle)
 *   @brief 快进
 *   @param [in] handle - 引擎句柄
 *   @param [in] scale为速率改变的方向, >0 播放速率加倍, <0 播放速率减半, =0 恢复正常播放速率
 *   @param [out] 无
 *   @return true - 暂停成功, false - 暂停失败
 */
RTSPCLIENTSDKAPI bool RtspClientPlaybackFast( int engineId);

/** @fn bool RtspClient_PlaybackSlow
 *   @brief 慢进
 *   @param [in] handle - 引擎句柄
 *   @param [in] scale为速率改变的方向, >0 播放速率加倍, <0 播放速率减半, =0 恢复正常播放速率
 *   @param [out] 无
 *   @return true - 暂停成功, false - 暂停失败
 */
RTSPCLIENTSDKAPI bool RtspClientPlaybackSlow( int engineId);

/** @fn bool RtspClient_PlaybackNormal
 *   @brief 恢复正常速率
 *   @param [in] handle - 引擎句柄
 *   @param [in] scale为速率改变的方向, >0 播放速率加倍, <0 播放速率减半, =0 恢复正常播放速率
 *   @param [out] 无
 *   @return true - 暂停成功, false - 暂停失败
 */
RTSPCLIENTSDKAPI bool RtspClientPlaybackNormal( int engineId);

/** @fn bool RtspClientPause(void* handle)
 *   @brief 暂停
 *   @param [in] handle - 引擎句柄
 *   @param [out] 无
 *   @return true - 成功, false - 失败
 */
RTSPCLIENTSDKAPI bool RtspClientPause(int engineId);

/** @fn bool RtspClientResume(void* handle)
 *   @brief  恢复
 *   @param [in] handle - 引擎句柄
 *   @param [out] 无
 *   @return true - 成功, false - 失败
 */
RTSPCLIENTSDKAPI bool RtspClientResume(int engineId);

/** @fn int RtspClientGetLastError()
 *  @brief  获取错误码
 *  @param [in] 无
 *  @param [out] 无
 *  @return 错误码
 */
RTSPCLIENTSDKAPI int RtspClientGetLastError();

/** @fn int GetRtspClientVersion()
 *  @brief  获取版本号
 *  @param [in] 无
 *  @param [out] 无
 *  @return 错误码
 */
RTSPCLIENTSDKAPI char* GetRtspClientVersion();

//#ifdef __cplusplus
//}
//#endif

#endif  // __RTSPCLIENT_H__
