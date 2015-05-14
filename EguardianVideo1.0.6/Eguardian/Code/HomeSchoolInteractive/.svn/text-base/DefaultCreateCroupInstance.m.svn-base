//
//  DefaultCreateCroupInstance.m
//  Eguardian
//
//  Created by S.C.S on 13-10-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DefaultCreateCroupInstance.h"
#import "JSONProcess.h"
#import "Global.h"
#import "ModelEngineVoip.h"
#import "ConfigManager.h"
#import "ASIHTTPTool.h"

//默认创建群
@implementation DefaultCreateCroupInstance
@synthesize myJoinGroupArr;
@synthesize classList;
@synthesize currentAcountArray;
@synthesize defautCount;

static DefaultCreateCroupInstance *defaultCreateCroupInstance;

+ (DefaultCreateCroupInstance *)sharedInstance{
    @synchronized(self) {
        if (nil == defaultCreateCroupInstance)
            defaultCreateCroupInstance = [[DefaultCreateCroupInstance alloc] init];
        
    }
    return defaultCreateCroupInstance;
}


- (id) init{
    
    if ((self = [super init])) {
        defautCount = 0;
        classList = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCreateGroupInstance:) name:NotificationCreateGroupInstance object:nil];
    }
    return self;
}

//获取班级(步骤1)
- (void)getGradeClassList{
    NSString *tempURL = [ConfigManager getGradeClass];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:tempURL];
    [request setURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *temdata, NSError *error) {
                               
                               if (error)
                               {
                                   
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:temdata options:NSJSONReadingAllowFragments error:&parseError];
                                   //                                       self.data = [jsonObject objectForKey:@"content"];
                                   NSDictionary *tmpDic = [jsonObject objectForKey:@"content"];
                                   
                                   NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                                   for ( NSString *gradeID in tmpDic)
                                   {
                                       NSDictionary *gradeMessage = [tmpDic objectForKey:gradeID];
                                       NSDictionary *classMessage = [gradeMessage objectForKey:@"cls"];
                                       
                                       NSString *gradeName = [gradeMessage objectForKey:@"grade"];
                                       
                                       for (NSString *classID in classMessage)
                                       {
                                           NSMutableDictionary *tempObj = [[NSMutableDictionary alloc] init];
                                           [tempObj setObject:gradeID forKey:@"gradeID"];  //年级ID
                                           [tempObj setObject:gradeName forKey:@"grade"];  //年级名称
                                           [tempObj setObject:classID forKey:@"classID"];  //班级ID
                                           [tempObj setObject:[classMessage objectForKey:classID] forKey:@"cls"];          //班级名称
                                            [tempObj setObject:[NSString stringWithFormat:@"%@%@", gradeName, [classMessage objectForKey:classID]] forKey:@"gradeClass"];
                                           [tempArray addObject:tempObj];
                                           [tempObj release];
                                       }
                                   }
                                   self.classList = tempArray;
                                   [tempArray release];
                                   
                               }
                           }];
    

}

//获取群成员(步骤2)
- (void)searchGroupList{
    [DELEGATE.modeEngineVoip queryGroupWithAsker:DELEGATE.modeEngineVoip.voipAccount];
}

//判断创建群(如果搜索不到群名则创建)
- (void)judgeCreateGroup{
    //根据群名判断有没有创建
    NSMutableArray *tmpClassList = [classList copy];
    for (NSDictionary *dic in tmpClassList) {
        BOOL b = NO;
        for (int i = 0; i < [myJoinGroupArr count]; i++) {
            IMGroup * group = [self.myJoinGroupArr objectAtIndex:i];
            if ([[dic objectForKey:@"gradeClass"] isEqualToString:group.name]) {
                b = YES;
                
//                如果有群名则删除班级的记录
                [self.classList removeObject:dic];
                break;
            }
        }
        if (b == NO) {
            //创建群组
            [DELEGATE.modeEngineVoip createGroupWithName:[dic objectForKey:@"gradeClass"] andType:@"0" andDeclared:nil andPermission:0];
             [tmpClassList release];
            return;
        }
    }
    [tmpClassList release];
}

//根据班级获取子账号
- (void)netWorkForAccount:(NSDictionary *)dic
{
//    app.shouhubao365.com/eguardian/service/accountsById/school_id/123/gradeid/23/classid/45/key/1235555555555
    //get
   NSString *loginKey = [ConfigManager sharedConfigManager].loginKey;
    id schoolID = nil;
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        NSArray *array = (NSArray *)[[NSUserDefaults standardUserDefaults]objectForKey:User_LoginedUsers_Teachers];
        if ([array count] > 0 ) {
            schoolID = [[array objectAtIndex:0] objectForKey:@"SchoolID"];
        }
    }
    NSString *strURL = [NSString stringWithFormat:@"http://app.shouhubao365.com/eguardian/service/accountsById/school_id/%@/gradeid/%@/classid/%@/key/%@",schoolID,[dic objectForKey:@"gradeID"],[dic objectForKey:@"classID"],loginKey];
    //重新请求
    NSURL *url = [NSURL URLWithString:strURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationCreateGroupInstance,NotificationKey,NotificationGroupAccount,NotificationSecondKey, nil];
    request.userInfo = userInfo;
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
    NSArray *keys = [headerDic allKeys];
    for (NSString *key in keys) {
        //相反 要注意
        [request addRequestHeader:key value:[headerDic objectForKey:key]];
        
    }
    [request setRequestMethod:@"GET"];

    ASIHTTPTool *tool = [ASIHTTPTool sharedInstance];
    [tool netWorkWithRequest:request];

}



- (void)notificationCreateGroupInstance:(NSNotification*) notification{
    @try
    {
        //获取群列表
        if ([[notification.userInfo objectForKey:NotificationSecondKey] isEqualToString:NotificationGroupList]) {
            if (defautCount == 0) {
                self.myJoinGroupArr = notification.object;
                [self judgeCreateGroup];
            }
            defautCount ++;
            
            for (int i = 0; i < [myJoinGroupArr count]; i++) {
                IMGroup * group = [self.myJoinGroupArr objectAtIndex:i];
                NSLog(@"%@",group.name);
               
            }
        }
        //创建群名
        else if([[notification.userInfo objectForKey:NotificationSecondKey] isEqualToString:NotificationCreateGroupName]){
            if ([self.classList count] > 0) {
                self.currentGroupId = notification.object;
                //成功后修改名片 群成员的名片
                IMGruopCard* groupCard = [[IMGruopCard alloc] init];
                groupCard.belong = self.currentGroupId;
                groupCard.display = [DELEGATE getLoginName];
                [DELEGATE.modeEngineVoip modifyGroupCard:groupCard];
                [groupCard release];

                NSDictionary *dic = [self.classList objectAtIndex:0];
                [self netWorkForAccount:dic];
                [self.classList removeObjectAtIndex:0];
            }
        }
//       获取班级账号
        else if([[notification.object objectForKey:NotificationSecondKey] isEqualToString:NotificationGroupAccount] ){
            NSMutableArray *voipIdArray = [[NSMutableArray alloc] init];
            NSArray *array = [notification.userInfo objectForKey:@"account"];
            self.currentAcountArray = array;
            for (NSDictionary *subaccountInfo in array) {
                [voipIdArray addObject:[subaccountInfo objectForKey:@"voipAccount"]];
            }
            if ([voipIdArray count] > 0) {
                //群组添加子账号
                [DELEGATE.modeEngineVoip inviteJoinGroupWithGroupId:self.currentGroupId andMembers:voipIdArray andDeclared: nil andConfirm:1];
            }else {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationCreateGroupInstance,NotificationKey,NotificationGroupAddAccount,NotificationSecondKey, nil];
                [[NSNotificationCenter defaultCenter] postNotificationName: NotificationCreateGroupInstance object:nil userInfo: userInfo];
            }
            [voipIdArray release];
        }
        
        else if([[notification.userInfo objectForKey:NotificationSecondKey] isEqualToString:NotificationGroupAddAccount]){
            if (self.currentAcountArray) {
                for (NSDictionary *dic in self.currentAcountArray) {
                    //成功后修改名片 群成员的名片
                    IMGruopCard* groupCard = [[IMGruopCard alloc] init];
                    groupCard.belong = self.currentGroupId;
                    groupCard.display =  [dic objectForKey:@"sname"];
                    NSLog(@"groupCard.display = %@",groupCard.display);
                    
                    id voipAccount = [dic objectForKey:@"voipAccount"];
                    if ([voipAccount isKindOfClass:[NSString class]]) {
                        groupCard.voipAccount =  voipAccount;
                    }else if ([voipAccount isKindOfClass:[NSArray class]]) {
                        if ([voipAccount count] > 0) {
                            groupCard.voipAccount =  [voipAccount objectAtIndex:0];
                        }
                    }
                    NSLog(@"groupCard.voipAccount = %@,leng = %d",groupCard.voipAccount,groupCard.voipAccount.length);
                    
                    
                    [DELEGATE.modeEngineVoip modifyGroupCard:groupCard];
                    [groupCard release];
                }
            }
            self.currentAcountArray = nil;
            self.currentGroupId = nil;
            [self judgeCreateGroup];

        }
       
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


@end
