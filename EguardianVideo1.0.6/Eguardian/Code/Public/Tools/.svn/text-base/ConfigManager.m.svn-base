//
//  Config.m
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ConfigManager.h"
#import "SynthesizeSingleton.h"

@implementation ConfigManager
@synthesize configData;
@synthesize loginKey;
@synthesize userMessage;
//@synthesize wrapper;
@synthesize isLeader;
@synthesize deviceToken;

- (void)dealloc
{
    [deviceToken release];
//    [wrapper release];
    [userMessage release];
    [loginKey release];
    [configData release];
    [super dealloc];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(ConfigManager);

+(NSString *)getParantMessage
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?key=%@",url,key];
    return result;
}

+(NSString *)getCommentWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=comment&date=%@&key=%@",url,date,key];
    return result;
}



+(NSString *)getHomeWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;

    NSString *result = [NSString stringWithFormat:@"%@?action=work&date=%@&key=%@",url,date,key];
    return result;
}


+(NSString *)getCheckWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=kaoqin&date=%@&key=%@",url,date,key];
    return result;
}



+(NSString *)getNoticeWithString:(NSString *)date
{    
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=notice&key=%@",url,key];
    return result;
}


#pragma mark 座位考勤
+(NSString *)getSeatsAttendanceAddress:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=ex_kaoqin&key=%@&date=%@",url,key,date];
    return result;
}

#pragma mark 班主任考勤提交
+(NSString *)getcheckWorksubmit{
//    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
//    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"http://app.shouhubao365.com/eguardian/push/api/kaoqin"];
    return result;
}

//**************************************************************************************************************************
//**************************************************************************************************************************
//**************************************************************************************************************************



+(NSString *)getTHomeWorkWithString:(NSString *)date
{

    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=homework&key=%@&date=%@",url,key,date];
    return result;
}




#pragma makr 删除作业
+(NSString *)getDeleteTWorkWithIds:(NSString *)ids
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=homework_del&key=%@&id=%@",url,key,ids];
    return result;
}


#pragma mark 获取年级和班级
+(NSString *)getGradeClass
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=class&key=%@",url,key];
    return result;
}

#pragma mark 获取语音账号
+(NSString *)getAccountInfo{
    NSString *url = @"http://app.shouhubao365.com/eguardian/service/accounts";
    return url;
}

#pragma mark 创建语音账号
+(NSString *)createAccountInfo{
    NSString *url = @"http://app.shouhubao365.com/eguardian/service/account";
    
    return url;
}

#pragma mark 获取学生的名字
+(NSString *)getStudentsWithGradeID:(NSString *)gradeID classID:(NSString *)cls
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=student&key=%@&gradeid=%@&classid=%@",url,key,gradeID,cls];
    return result;
}




+(NSString *)getSubject
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=subject&key=%@",url,key];
    return result;
}

+(NSString *)getSendHomeWorkWithGradeID:(NSString *)gradeID classID:(NSString *)classID ids:(NSString *)ids subjectID:(NSString *)subjectID content:(NSString *)content
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=homework_add&key=%@&gradeid=%@&classid=%@&ids=%@&subjectid=%@&content=%@",
                         url,key,gradeID,classID,ids,subjectID,content];

    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}


#pragma mark 获取广告地址
+(NSString *)getAdvertising
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"ads"];
    return url;
}



#pragma mark 发送评语
+(NSString *)getSendComment:(NSString *)classID content:(NSString *)content
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment_add&key=%@&id=%@&content=%@",
                         url,key,classID,content];
    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}







+(NSString *)getTCommentWithDate:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment&key=%@&date=%@",url,key,date];
    
    return restutl;
}




+(NSString *)getDeleteTCommentWithID:(NSString *)sid
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment_delete&key=%@&id=%@",url,key,sid];
    return restutl;
}



+(NSString *)getTNotice
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=notice_manage&key=%@",url,key];
    return restutl;
}




+(NSString *)getSendTNotice:(NSString *)atitle content:(NSString *)content gradeID:(NSString *)gradeID classID:(NSString *)classID
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:
                         @"%@?app=teacher&action=notice_add&goal=student&key=%@&title=%@&content=%@&gradeid=%@&classid=%@",
                         url,key,atitle,content,gradeID,classID];
    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}





+(NSString *)getDeleteTNoticeWithID:(NSString *)nid
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=notice_delete&key=%@&id=%@",url,key,nid];
    return restutl;
}






+(NSString *)getTCheckWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=kaoqin_me&key=%@&date=%@",url,key,date];
    return result;
}

//班主任
+(NSString *)getTCheckWorkWithString:(NSString *)date Gradeid:(id) gradeid Classid:(id)classid
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=unkaoqin&key=%@&gradeid=%@&classid=%@&date=%@",url,key,gradeid,classid,date];
    return result;
}



+(NSString *)getTeacherMessage
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action&key=%@",url,key];
    return result;
}

#pragma mark 查看老师的积分
+ (NSString *)getCheckTeacherIntegral{
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"http://api.shouhubao365.com/index.php?app=teacher&action=top&key=%@",key];
    return result;
}

#pragma mark 视频积分
+ (NSString *)getVdeoTeacherIntegral{
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"http://api.shouhubao365.com/index.php?app=teacher&action=video&key=%@",key];
    return result;
}

#pragma mark 家校互动积分 只有老师的才能调用这个接口
+ (NSString *)getVdeoHomeSchoolInteractive:(NSInteger) studentId Classid:(NSInteger)classId Gradeid:(NSInteger)gradeId{
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"http://api.shouhubao365.com/index.php?app=teacher&action=bbsjf&key=%@&student_id=%d&classid=%d&gradeid=%d",key,studentId,classId,gradeId];
    return result;
}

#pragma mark 家长获取未读取信息条数
+(NSString *)getReadNumber
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=noread&key=%@",url,key];
    return result;
}

#pragma mark 更新未读信息状态
+(NSString *)getUpdataReadNumber:(id)type ID:(id)detailID
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=update_read&key=%@&type=%@&id=%@",url,key,type,detailID];
    return result;
}

#pragma mark 取得无考勤的老师信息
+(NSString *)getNOKaoqing:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=unkaoqin_teacher&key=%@&date=%@",url,key,date];
    return result;
}



@end