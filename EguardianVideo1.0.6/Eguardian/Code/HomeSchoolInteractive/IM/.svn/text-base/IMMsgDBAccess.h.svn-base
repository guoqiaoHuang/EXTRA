/*
 *  Copyright (c) 2013 The CCP project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a Beijing Speedtong Information Technology Co.,Ltd license
 *  that can be found in the LICENSE file in the root of the web site.
 *
 *                    http://www.cloopen.com
 *
 *  An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import <Foundation/Foundation.h>
#import "DBConnection.h"
#import "Statement.h"


@interface IMMsg: NSObject

//发送消息的sdk生成id
@property (nonatomic, retain) NSString *msgid;

//文本消息时为空 附件消息保存服务器下发的msgid 系统消息保存groupid
@property (nonatomic, retain) NSString *data;

//如果是文本信息则是内容，如果是多媒体信息，则是文件全路径 notify保存验证消息
@property (nonatomic, retain) NSString *content;

//会话的分组，群消息保存groupid 点对点保存对方voip 系统消息保存特殊值IMGROUP_NOTIFY_MESSAGE_SOMEONE
@property (nonatomic, retain) NSString *someone;

//群组消息，消息的发送者voip； 系统消息中的voip账号
@property (nonatomic, retain) NSString *sender;

//0 text msg; 1 attach msg; 3 voice msg
//系统消息时，保存是否需要认证的confirm字段 对于imState=2时，0需要通过 1不需要通过 2已通过 3已拒绝 
@property (nonatomic, assign) NSInteger msgtype;

@property (nonatomic, retain) NSString *date;

//IM消息 0发送成功 1发送失败 2收到附件成功 3收到附件失败 4发送中 5对方已接收
//notify消息 0 申请加入   1 回复加入  2邀请加入  3移除成员 4退出 5解散 6有人加入
@property (nonatomic, assign) NSInteger imState; 

@property (nonatomic, assign) NSInteger isRead;

@property (nonatomic, assign) double duration;

//联系人
@property (nonatomic, retain) NSString *userData;

@property (nonatomic, retain) NSString *loginName;

//软件登录人--学生老师（不是语音登录的人）
@property (nonatomic, retain) NSString *loginKey;

//学号
@property (nonatomic, assign) NSInteger xuehao;

//学校ID
@property (nonatomic, assign) NSInteger schoolid;

//班级id
@property (nonatomic, assign) NSInteger classid;

//年级id
@property (nonatomic, assign) NSInteger gradeid;

@end

@interface InfoStudent : NSObject

//学号
@property (nonatomic, assign) NSInteger xuehao;

//学校ID
@property (nonatomic, assign) NSInteger schoolid;

//班级id
@property (nonatomic, assign) NSInteger classid;

//年级id
@property (nonatomic, assign) NSInteger gradeid;

//姓名
@property (nonatomic, retain) NSString  *sname;

//姓名
@property (nonatomic, retain) NSString  *groupVoipAccount;

@end


@interface IMMsgDBAccess : NSObject
{
    sqlite3 * shareDB;
}

- (IMMsgDBAccess *)init;

- (NSArray *)getIMListArray:(NSString *)aSomeOne;

- (BOOL)deleteAllMsg;

//删除前几天的数据
- (BOOL)deleteBeforeTime:(NSString *)time;

//删除amr
- (BOOL)deleteFileWithAmr:(NSString *)time;

- (NSArray *)getIMOfSomeone:(NSString *)someone;
- (BOOL)deleteIMOfSomeone:(NSString *)someone;

- (BOOL)addNewIM:(IMMsg*)im;

- (NSInteger)getUnreadCountOfSomeone:(NSString *)someone LoginKey:(NSString *)loginKey;

//获取总的未读的条数
- (NSInteger)getUnreadCountOfLoginName;

- (BOOL)updateUnreadStateOfSomeone:(NSString *)someone;

- (BOOL)updateUnreadStateOfSomeone:(NSString *)someone LoginKey:(NSString *)loginKey;

- (BOOL)updateInviteState:(NSInteger)type OfGroupId:(NSString *)groupid andPushMsgType:(NSInteger)state andVoip:(NSString*)voip;

- (BOOL)updateimState:(NSInteger)status OfmsgId:(NSString *)msgId;

- (NSInteger)getCountOfmsgid:(NSString*)msgid;

- (BOOL)updateAllSendingTofailed;

- (BOOL)insertInfoTable:(InfoStudent*) info;

- (NSArray *)searchInfoName:(NSString *)sname;

- (NSArray *)searchInfoAccountID:(NSString *)groupVoipAccount;

@end

