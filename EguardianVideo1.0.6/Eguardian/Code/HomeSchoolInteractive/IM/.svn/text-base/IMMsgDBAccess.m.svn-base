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

#import "IMMsgDBAccess.h"
#import "ConfigManager.h"
@implementation IMMsg
@synthesize duration;
@synthesize sender;
@synthesize data;
@synthesize content;
@synthesize someone;
@synthesize date;
@synthesize msgid;
@synthesize userData;
@synthesize loginName;

- (void)dealloc
{
    self.sender = nil;
    self.data = nil;
    self.content = nil;
    self.someone = nil;
    self.date = nil;
    self.msgid = nil;
    self.userData = nil;
    self.loginName = nil;
    [super dealloc];
}
@end

@implementation InfoStudent
@synthesize xuehao;
@synthesize schoolid;
@synthesize classid;
@synthesize gradeid;
@synthesize sname;
@synthesize groupVoipAccount;

- (void)dealloc
{
    self.sname = nil;
    self.groupVoipAccount = nil;
    [super dealloc];
}

@end
@interface IMMsgDBAccess()
- (BOOL) IMTableCreate;
@end

@implementation IMMsgDBAccess
- (IMMsgDBAccess *)init
{
    if (self=[super init]) {
        shareDB = [DBConnection getSharedDatabase];
        [self IMTableCreate];
        [self infoTableCreate];
        return self;
    }
    return nil;
}

- (BOOL)IMTableCreate {
    const char * createTable = "create table if not exists im_message(id integer primary key,msgid text,data text, msg_content text,someone text, sender text, imState integer,LASTDATE text,MSG_TYPE integer, readState integer,duration double,userData text,loginName text,loginKey text,xuehao integer, schoolid integer,classid integer,gradeid integer)";
    char * errmsg;
    int flag = sqlite3_exec(shareDB, createTable, NULL, NULL, &errmsg);
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0)
    {
        free(errmsg);
    }
    if (SQLITE_OK!=flag) {
        NSLog(@"ERROR: Failed to create table Thread or im_message!");
    }
    
    if (SQLITE_OK==flag) {
        return YES;
    }
    else return NO;
}

- (BOOL)deleteAllMsg
{
    @try {
        const char * deleteRelatedInfo = "delete from im_message where loginKey = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindString:[ConfigManager sharedConfigManager].loginKey forIndex:1];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to delete table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

//删除会话消息
- (BOOL)deleteIMOfSomeone:(NSString *)someone
{
    @try {
        const char * deleteRelatedInfo = "delete from im_message where someone = ? AND loginKey = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindString:someone forIndex:1];
        [stmt bindString:[ConfigManager sharedConfigManager].loginKey forIndex:2];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to delete table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

//删除前几天的数据
- (BOOL)deleteBeforeTime:(NSString *)time
{
    @try {
        const char * deleteRelatedInfo = "delete from im_message where LASTDATE < ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindString:time forIndex:1];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to delete table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

//删除amr
- (BOOL)deleteFileWithAmr:(NSString *)time
{
    @try {
//        const char * deleteRelatedInfo = "select * from im_message where left(fileids,4) = ? AND LASTDATE < ? ";
//        where right(fileids,4) = ?
//        NSLog(@"time = %@",time);
        const char * sqlString = "SELECT msg_content from im_message where LASTDATE < ?";
        static Statement * stmt = nil;
        if (nil == stmt)
        {
            stmt = [DBConnection statementWithQuery:sqlString];
            [stmt retain];
        }
        [stmt bindString:time forIndex:1];
        while (SQLITE_ROW==[stmt step])
        {
            NSString *fileStr = [stmt getString:0];
            if ([fileStr hasSuffix:@".amr"]) {
                //判断文件
                if ([[NSFileManager defaultManager] fileExistsAtPath:fileStr]) {
//                    NSLog(@"filestr = %@",fileStr);
                    [[NSFileManager defaultManager] removeItemAtPath:fileStr error:nil];
                }
            }
        }
        
        [stmt reset];
        return NO;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally
    {
    }
    return NO;
}

- (NSArray *)getIMListArray:(NSString *)loginKey
{
    @try {
        [DBConnection beginTransaction];
        
        const char * getPhoneSql = "SELECT msgid, data, msg_content, someone, LASTDATE, MSG_TYPE , userData,loginName,max(LASTDATE) from im_message where loginKey = ? group by someone order by LASTDATE desc";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:getPhoneSql];
            [stmt retain];
        }
        [stmt bindString:loginKey forIndex:1];
        
        NSMutableArray * IMArray = [[NSMutableArray alloc] init];
        while (SQLITE_ROW==[stmt step])
        {
            IMMsg *msg = [[IMMsg alloc] init];
            msg.msgid = [stmt getString:0];
            msg.data = [stmt getString:1];
            msg.content = [stmt getString:2];
            msg.someone = [stmt getString:3];
            msg.date = [stmt getString:4];
            msg.msgtype = [stmt getInt32:5];
            msg.userData = [stmt getString:6];
            msg.loginName = [stmt getString:7];
            
            //".amr"
//            NSRange range ;
//            range.location = msg.content.length - 4;
//            range.length = 4;
//            NSString *str = [msg.content substringWithRange:range];
            
            [IMArray addObject:msg];
            [msg release];
        }
        
        [stmt reset];
        [DBConnection commitTransaction];
        return [IMArray autorelease];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return nil;
}

//获取会话内容
- (NSArray *)getIMOfSomeone:(NSString *)someone
{
    @try
    {
        const char* sqlString = "select msgid, data,msg_content,someone,imState,LASTDATE,MSG_TYPE,readState,sender,duration,userData,loginName from im_message where someone = ? AND loginKey = ? order by id";
        static Statement * stmt = nil;
        if (nil == stmt)
        {
            stmt = [DBConnection statementWithQuery:sqlString];
            [stmt retain];
        }
        [stmt bindString:someone forIndex:1];
        [stmt bindString:[ConfigManager sharedConfigManager].loginKey forIndex:2];
        NSMutableArray * IMArray = [[NSMutableArray alloc] init];
        while (SQLITE_ROW==[stmt step])
        {
            IMMsg *msg = [[IMMsg alloc] init];
            msg.msgid = [stmt getString:0];
            msg.data = [stmt getString:1];
            msg.content = [stmt getString:2];
            msg.someone = [stmt getString:3];
            msg.imState = [stmt getInt32:4];
            msg.date = [stmt getString:5];
            msg.msgtype = [stmt getInt32:6];
            msg.isRead = [stmt getInt32:7];
            msg.sender = [stmt getString:8];
            msg.duration = [stmt getDouble:9];
            msg.userData = [stmt getString:10];
            msg.loginName = [stmt getString:11];
            [IMArray addObject:msg];
            [msg release];
        }
        
        [stmt reset];
        return [IMArray autorelease];        
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally
    {
    }
    return nil;
}

- (NSInteger)getCountOfmsgid:(NSString*)msgid
{
    NSInteger count = 0;
    @try
    {
        const char * sqlString = "select count(*) from im_message where msgid = ?";
        static Statement * stmt = nil;
        if (nil == stmt)
        {
            stmt = [DBConnection statementWithQuery:sqlString];
            [stmt retain];
        }
        [stmt bindString:msgid forIndex:1];
        if (SQLITE_ROW == [stmt step])
        {
            count = [stmt getInt32:0];
        }
        [stmt reset];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally
    {
        return count;
    }
}

- (BOOL)addNewIM:(IMMsg*)im
{
    @try {
        const char * add = "insert into im_message(msgid,data,msg_content,someone,imState,LASTDATE,MSG_TYPE,readState,sender,duration,userData,loginName,loginKey) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        static Statement * stmt = nil;
        if (stmt == nil) {
            stmt = [DBConnection statementWithQuery:add];
            [stmt retain];
        }
        [stmt bindString:im.msgid forIndex:1];
        [stmt bindString:im.data forIndex:2];
        [stmt bindString:im.content forIndex:3];
        [stmt bindString:im.someone forIndex:4];
        [stmt bindInt32:im.imState forIndex:5];
        [stmt bindString:im.date forIndex:6];
        [stmt bindInt32:im.msgtype forIndex:7];
        [stmt bindInt32:im.isRead forIndex:8];
        [stmt bindString:im.sender forIndex:9];
        [stmt bindDouble:im.duration forIndex:10];
        [stmt bindString:im.userData forIndex:11];
        [stmt bindString:im.loginName forIndex:12];
        [stmt bindString:[ConfigManager sharedConfigManager].loginKey forIndex:13];
//        [stmt bindInt32:im.xuehao forIndex:14];
//        [stmt bindInt32:im.schoolid forIndex:15];
//        [stmt bindInt32:im.classid forIndex:16];
//        [stmt bindInt32:im.gradeid forIndex:17];
        
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to add new message into im_message!ret=%d,%s",ret,__func__);
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

- (NSInteger)getUnreadCountOfSomeone:(NSString *)someone LoginKey:(NSString *)loginKey
{
    NSInteger count = 0;
    @try
    {
        const char * sqlString = "select count(*) from im_message where readState = 0 and someone = ? and loginKey = ?";
        static Statement * stmt = nil;
        if (nil == stmt)
        {
            stmt = [DBConnection statementWithQuery:sqlString];
            [stmt retain];
        }
        [stmt bindString:someone forIndex:1];
        [stmt bindString:loginKey forIndex:2];
        if (SQLITE_ROW == [stmt step])
        {
            count = [stmt getInt32:0];
        }
        [stmt reset];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally
    {
        return count;
    }
}

//获取总的未读的条数
- (NSInteger)getUnreadCountOfLoginName
{
    NSInteger count = 0;
    @try
    {
        const char * sqlString = "select count(*) from im_message where readState = 0 and loginKey = ?";
        static Statement * stmt = nil;
        if (nil == stmt)
        {
            stmt = [DBConnection statementWithQuery:sqlString];
            [stmt retain];
        }
        [stmt bindString:[ConfigManager sharedConfigManager].loginKey forIndex:1];
        if (SQLITE_ROW == [stmt step])
        {
            count = [stmt getInt32:0];
        }
        [stmt reset];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally
    {
        return count;
    }
}

- (BOOL)updateUnreadStateOfSomeone:(NSString *)someone
{
    @try {
        const char * deleteRelatedInfo = "update im_message set readState = 1 where someone = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindString:someone forIndex:1];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to update table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

- (BOOL)updateUnreadStateOfSomeone:(NSString *)someone LoginKey:(NSString *)loginKey
{
    @try {
        const char * deleteRelatedInfo = "update im_message set readState = 1 where someone = ? and loginKey = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindString:someone forIndex:1];
        [stmt bindString:loginKey forIndex:2];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to update table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}


- (BOOL)updateimState:(NSInteger)status OfmsgId:(NSString *)msgId
{
    @try {
        const char * deleteRelatedInfo = "update im_message set imState = ? where msgid = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindInt32:status forIndex:1];
        [stmt bindString:msgId forIndex:2];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to update table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

- (BOOL)updateInviteState:(NSInteger)type OfGroupId:(NSString *)groupid andPushMsgType:(NSInteger)state andVoip:(NSString*)voip
{
    @try {
        const char * deleteRelatedInfo = "update im_message set MSG_TYPE = ? where data=? and imState=? and sender=?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        [stmt bindInt32:type forIndex:1];
        [stmt bindString:groupid forIndex:2];
        [stmt bindInt32:state forIndex:3];
        [stmt bindString:voip forIndex:4];
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to update table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

- (BOOL)updateAllSendingTofailed
{
    @try {
        const char * deleteRelatedInfo = "update im_message set imState=1 where imState=4 and someone<>'000notify000'";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:deleteRelatedInfo];
            [stmt retain];
        }
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to update table im_message!");
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

//存储学生的信息
- (BOOL)infoTableCreate {
    const char * createTable = "create table if not exists Info_student(id integer primary key,sname text,xuehao integer, schoolid integer,classid integer,gradeid integer,groupVoipAccount text)";
    char * errmsg;
    int flag = sqlite3_exec(shareDB, createTable, NULL, NULL, &errmsg);
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0)
    {
        free(errmsg);
    }
    if (SQLITE_OK!=flag) {
        NSLog(@"ERROR: Failed to create table Thread or im_message!");
    }
    
    if (SQLITE_OK==flag) {
        return YES;
    }
    else return NO;
}

- (BOOL)insertInfoTable:(InfoStudent*) info
{
    @try {
        const char * add = "insert into Info_student(sname,xuehao,schoolid,classid,gradeid,groupVoipAccount) values (?,?,?,?,?,?)";
        static Statement * stmt = nil;
        if (stmt == nil) {
            stmt = [DBConnection statementWithQuery:add];
            [stmt retain];
        }
        [stmt bindString:info.sname forIndex:1];
        [stmt bindInt32:info.xuehao forIndex:2];
        [stmt bindInt32:info.schoolid forIndex:3];
        [stmt bindInt32:info.classid forIndex:4];
        [stmt bindInt32:info.gradeid forIndex:5];
        [stmt bindString:info.groupVoipAccount forIndex:6];
        
        int ret = [stmt step];
        if (SQLITE_DONE!=ret) {
            NSLog(@"ERROR: Failed to add new message into Info_student!ret=%d,%s",ret,__func__);
            [stmt reset];
            return NO;
        }
        [stmt reset];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return NO;
}

//- (NSArray *)searchInfoXuehao:(NSInteger )xuehao Name:(NSString *)sname
- (NSArray *)searchInfoName:(NSString *)sname
{
    @try {
        [DBConnection beginTransaction];
        
//        const char * getPhoneSql = "SELECT sname,xuehao,schoolid,classid,gradeid,groupVoipAccount from Info_student where xuehao =  ? AND sname = ?";
        const char * getPhoneSql = "SELECT sname,xuehao,schoolid,classid,gradeid,groupVoipAccount from Info_student where sname = ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:getPhoneSql];
            [stmt retain];
        }
//        [stmt bindInt32:xuehao forIndex:1];
//        [stmt bindString:sname forIndex:2];
        [stmt bindString:sname forIndex:1];
        
        NSMutableArray * infoArray = [[NSMutableArray alloc] init];
        while (SQLITE_ROW==[stmt step])
        {
            InfoStudent *info = [[InfoStudent alloc] init];
            info.sname = [stmt getString:0];
            info.xuehao = [stmt getInt32:1];
            info.schoolid = [stmt getInt32:2];
            info.classid = [stmt getInt32:3];
            info.gradeid = [stmt getInt32:4];
            [infoArray addObject:info];
            [info release];
        }
        
        [stmt reset];
        [DBConnection commitTransaction];
        return [infoArray autorelease];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return nil;
}

- (NSArray *)searchInfoAccountID:(NSString *)groupVoipAccount
{
    @try {
        [DBConnection beginTransaction];
        
        const char * getPhoneSql = "SELECT sname,xuehao,schoolid,classid,gradeid,groupVoipAccount from Info_student where groupVoipAccount =  ?";
        static Statement * stmt = nil;
        if (nil==stmt) {
            stmt = [DBConnection statementWithQuery:getPhoneSql];
            [stmt retain];
        }
        [stmt bindString:groupVoipAccount forIndex:1];
        
        NSMutableArray * infoArray = [[NSMutableArray alloc] init];
        while (SQLITE_ROW==[stmt step])
        {
            InfoStudent *info = [[InfoStudent alloc] init];
            info.sname = [stmt getString:0];
            info.xuehao = [stmt getInt32:1];
            info.schoolid = [stmt getInt32:2];
            info.classid = [stmt getInt32:3];
            info.gradeid = [stmt getInt32:4];
            [infoArray addObject:info];
            [info release];
        }
        
        [stmt reset];
        [DBConnection commitTransaction];
        return [infoArray autorelease];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
    return nil;
}

@end
