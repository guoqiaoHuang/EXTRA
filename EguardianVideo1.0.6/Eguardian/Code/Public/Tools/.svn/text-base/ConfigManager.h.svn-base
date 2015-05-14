//
//  Config.h
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CUControlWrapper.h"

@interface ConfigManager : NSObject
{
    NSDictionary             *configData;          //配置信息
    NSString                 *loginKey;
    NSDictionary             *userMessage;         //绑定后用户的信息
    
//    CUControlWrapper         *wrapper;
    BOOL                     isLeader;              //判断是否是领导
    NSString                 *deviceToken;          //通知  deviceToken
    
}

@property(nonatomic,retain)NSDictionary     *configData;
@property(nonatomic,retain)NSString         *loginKey;
@property(nonatomic,retain)NSDictionary     *userMessage;

//@property(nonatomic,retain)CUControlWrapper *wrapper;
@property(nonatomic,assign)BOOL isLeader;


@property(nonatomic,retain)NSString     *deviceToken;


+ (ConfigManager *)sharedConfigManager;

+(NSString *)getParantMessage;

+(NSString *)getCheckWorkWithString:(NSString *)date;

+(NSString *)getHomeWorkWithString:(NSString *)date;

+(NSString *)getCommentWithString:(NSString *)date;

+(NSString *)getNoticeWithString:(NSString *)date;




+(NSString *)getTHomeWorkWithString:(NSString *)date;

+(NSString *)getDeleteTWorkWithIds:(NSString *)ids;


+(NSString *)getAccountInfo;

+(NSString *)createAccountInfo;

+(NSString *)getGradeClass;

+(NSString *)getStudentsWithGradeID:(NSString *)gradeID classID:(NSString *)cls;

+(NSString *)getSubject;


+(NSString *)getSendHomeWorkWithGradeID:(NSString *)gradeID classID:(NSString *)classID ids:(NSString *)ids subjectID:(NSString *)subjectID content:(NSString *)content;


+(NSString *)getSeatsAttendanceAddress:(NSString *)date;



+(NSString *)getcheckWorksubmit;


+(NSString *)getAdvertising;


+(NSString *)getSendComment:(NSString *)classID content:(NSString *)content;


+(NSString *)getTCommentWithDate:(NSString *)date;

+(NSString *)getDeleteTCommentWithID:(NSString *)sid;


+(NSString *)getTNotice;

+(NSString *)getSendTNotice:(NSString *)atitle content:(NSString *)content gradeID:(NSString *)gradeID classID:(NSString *)classID;


+(NSString *)getDeleteTNoticeWithID:(NSString *)nid;


+(NSString *)getTCheckWorkWithString:(NSString *)date;

//班主任
+(NSString *)getTCheckWorkWithString:(NSString *)date Gradeid:(id) gradeid Classid:(id)classid;

+(NSString *)getTeacherMessage;

#pragma mark 查看老师的积分
+ (NSString *)getCheckTeacherIntegral;

#pragma mark 视频积分
+ (NSString *)getVdeoTeacherIntegral;

#pragma mark 家校互动积分 只有老师的才能调用这个接口
+ (NSString *)getVdeoHomeSchoolInteractive:(NSInteger) studentId Classid:(NSInteger)classId Gradeid:(NSInteger)gradeId;

#pragma mark 家长获取未读取信息条数
+(NSString *)getReadNumber;

#pragma mark 更新未读信息状态
+(NSString *)getUpdataReadNumber:(id)type ID:(id)tmpID;

#pragma mark 取得无考勤的老师信息
+(NSString *)getNOKaoqing:(NSString *)date;

@end