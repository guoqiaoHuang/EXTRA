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

#import "IMListViewController.h"
#import "UIselectContactsViewController.h"
#import "SendIMViewController.h"
#import "IMMsgDBAccess.h"
#import "GroupListViewController.h"
#import "IMGroupNotifyViewController.h"
#import "Global.h"
//#import "GradeClassViewController.h"
#import "ContactPeopleViewController.h"
#import "ConfigManager.h"
#import "NetTools.h"
#import "AccountInfo.h"
#import "NSDateFormatter+help.h"
//#import "DefaultCreateCroupInstance.h"

@interface IMListViewController ()
@property (nonatomic, retain) NSMutableArray *msgArr;
@property (nonatomic, retain) UIView *noneMsgView;
@property (nonatomic, retain) UITableView *table;
@end

@implementation IMListViewController
@synthesize serverip;
@synthesize serverport;
@synthesize isLogin;
@synthesize connectInfo;
@synthesize msgArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    //清空服务
//    [self.modelEngineVoip resetVoipCallService];
    self.navigationController.navigationBarHidden = NO;
    
    //定制返回按钮
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(popToPreView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
    
    self.title = @"家校互动";
    
    UIBarButtonItem *clearMessage=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"清除会话" target:self action:@selector(clearMessage)]];
    self.navigationItem.rightBarButtonItem = clearMessage;
    [clearMessage release];
   
    UITableView *tableView = nil;
//    if (IPHONE5)
//    {
//        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 578.f-20.f)
//                                                 style:UITableViewStylePlain];;
//    }
//    else
//    {
//        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)
//                                                 style:UITableViewStylePlain];
//    }
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 0.0f)
                                             style:UITableViewStylePlain];
    tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	tableView.delegate = self;
	tableView.dataSource = self;
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
    tableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    tableView.tableFooterView = [[[UIView alloc] init] autorelease];
    self.table = tableView;
    self.table.bounces = NO;
	[self.view addSubview:tableView];
    
//    [self setTableHeaderOfTable:tableView];
    //清除UITableView底部多余的分割线mTableView
    [self setExtraCellLineHidden:tableView];
	[tableView release];
}

-(void)setTableFrame
{
	[self.table layoutIfNeeded];
    float height = 0;
    if (self.table.contentSize.height > self.viewHeight - 44) {
        height =  self.viewHeight - 44;
    }else {
        height =  self.table.contentSize.height;
    }
	self.table.frame = CGRectMake(0, 0, 320, height);
}

//清除UITableView底部多余的分割线mTableView
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BgImage.png"]];
    [tableView setTableFooterView:view];
    [view release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.modelEngineVoip.UIDelegate = self;
    
    [self getMsgArray];
    
    if (isLogin == YES) {
        [self.table reloadData];
    }
    [self setTableFrame];
    if ([self.msgArr count] > 0) {
        [self removenoneMsgView];
    }
    

}

- (void)getMsgArray{
    NSArray *array = [self.modelEngineVoip.imDBAccess getIMListArray:[ConfigManager sharedConfigManager].loginKey];
    [self.msgArr removeAllObjects];
    for (id object in array ) {
        [self.msgArr addObject:object];
    }
}

- (void)removenoneMsgView{
    if ([self.msgArr count] > 0) {
        if (self.noneMsgView) {
            [self.noneMsgView removeFromSuperview];
            self.noneMsgView = nil;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    msgArr = [[NSMutableArray alloc] init];
    //登录语音账号
    [self loginAccountInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationIMListViewController:) name:NotificationIMListViewController object:nil];
}

//登录语音通讯 (主账号)
- (void)loginVoiceCommunication:(NSDictionary *)dic{
    
    self.serverip = Serverip;
    self.serverport = Server_port;
    self.modelEngineVoip.appID = App_id;
    self.modelEngineVoip.mainAccount = Main_account;
    self.modelEngineVoip.mainToken = Main_token;
    
    if (self.modelEngineVoip)
    {
//        NSLog(@"执行");
//        NSLog(@"dic = %@",dic);
        [self.modelEngineVoip connectToCCP:self.serverip onPort:[self.serverport integerValue] withAccount:[dic objectForKey:@"voipAccount"] withPsw:[dic objectForKey:@"voipPwd"] withAccountSid:[dic objectForKey:@"subAccountid"] withAuthToken:[dic objectForKey:@"subToken"]];
    }
    
}

//获取语音通讯的子账号(都是学生)
- (void)getAccountInfoWithDic:(NSDictionary *)dic {
    NSString *loginKey = [ConfigManager sharedConfigManager].loginKey;
    NSMutableArray *postArray = [[NSMutableArray alloc] init];
    
    NSString *tempURL = [ConfigManager getAccountInfo];
    NSDictionary *userInfo = nil;
    
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        NSDictionary *oneStudentDic = [dic objectForKey:key];
        self.connectInfo = oneStudentDic;
        NSMutableDictionary *postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"xuehao"],@"xuehao",[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"sname"],@"sname", nil];
        NSError *error = nil;
        
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
        
        //json 数据
        NSString *jsonStr = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
        [postArray addObject:jsonStr];
        
        [jsonStr release];
        [postDic release];
    }
    
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationIMListViewController,NotificationKey,NotificationNOLoginAccountInfo,NotificationSecondKey, nil];
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
    //应用apikey type 老师2，学生 1
    [self formDataRequestWithURL:tempURL UserInfo:userInfo DataArray:postArray Header:headerDic Key:loginKey Type:@"1"];
    [postArray release];
}

//登录语音账号 
- (void)loginAccountInfo{
//    [self addHUDWithMode:PartViewModel];
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];

    NSString *tempURL = [ConfigManager getAccountInfo];
    NSDictionary *userInfo = nil;
    NSMutableArray *postArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *postDic = nil;
    NSString *type = nil;
    //老师
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        NSArray *userArray = [[NSUserDefaults standardUserDefaults] objectForKey:User_LoginedUsers_Teachers];
        postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[userArray objectAtIndex:0] objectForKey:User_SchoolID],@"schoolid",[[userArray objectAtIndex:0] objectForKey:User_UserNumber],@"sname", nil];
        type = @"2";
    }
    //学生
    else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Parents]){
        NSArray *userArray = [[NSUserDefaults standardUserDefaults] objectForKey:User_LoginedUsers_Parents];
        postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [[ConfigManager sharedConfigManager].userMessage objectForKey:@"sname"],@"sname",[[userArray objectAtIndex:0] objectForKey:User_SchoolID],@"schoolid",[[userArray objectAtIndex:0] objectForKey:User_UserNumber],@"xuehao", nil];
        type = @"1";
    }
    
    NSString *key  = [ConfigManager sharedConfigManager].loginKey;
    NSError *error = nil;
    
    NSData *registerData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
    
    //json 数据
    NSString *jsonStr = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    [postArray addObject:jsonStr];
    
    [jsonStr release];
    [postDic release];
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
     NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
   userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationIMListViewController,NotificationKey,NotificationLoginAccountInfo,NotificationSecondKey,nil];
    
    //应用apikey type 老师2，学生 1
    [self formDataRequestWithURL:tempURL UserInfo:userInfo DataArray:postArray Header:headerDic Key:key Type:type];
    [postArray release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.msgArr = nil;
    if (self.noneMsgView) {
        self.noneMsgView = nil;
    }
    
    self.table = nil;
    self.serverip = nil;
    self.serverport = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationIMListViewController object:nil];
    [super dealloc];
}

- (NSString *)dateStr:(NSString *) temDate{
    NSDateFormatter *farmatter = [NSDateFormatter getYyyyMmDdHMS];
    NSDate *date = [farmatter dateFromString:temDate];
    farmatter = [NSDateFormatter getYyyy_Mm_DdHMS];
    return  [farmatter stringFromDate:date];
}

#pragma mark - private method

//返回值0 P2P；1 group；2 notify
-(NSInteger)sessionTypeOfSomeone:(NSString*)someone
{
    NSInteger type = 0;
    
    NSString *g = [someone substringToIndex:1];
    if ([g isEqualToString:@"g"])
    {
        type = 1;
    }
    else if ([someone isEqualToString:IMGROUP_NOTIFY_MESSAGE_SOMEONE])
    {
        type = 2;
    }
    return type;
}

- (UIView*)getNoneMsgView
{
    if (self.noneMsgView == nil)
    {
        float  originY = 0;
        if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
            originY = 100;
                       
        }else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Parents]){
            originY = 0;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, originY, 320.0, 150.0f)];
        self.noneMsgView = view;
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 80.0f, 300.0f, 25.0f)];
        label.text = @"暂无消息";
        [view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [label release];
        
        //如果是老师，有这个提示
        if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 115.0f, 300.0f, 15.0f)];
            label1.text = @"可通过通讯录或群组开始聊天";
            [view addSubview:label1];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = [UIColor grayColor];
            label1.backgroundColor = [UIColor clearColor];
            [label1 release];
        }
        
        [view release];
    }
    return self.noneMsgView;
}

- (void)goToSelectContact
{
    UIselectContactsViewController* view = [[UIselectContactsViewController alloc] initWithAccountList:self.modelEngineVoip.accountArray andSelectType:ESelectViewType_IMMsgView];
    view.backView = self;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}

- (void)goToGroupView
{
    GroupListViewController *view = [[GroupListViewController alloc] init];
    view.backView = self;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}

- (void)clearMessage
{
    [self.modelEngineVoip.imDBAccess deleteAllMsg];
    
    [self getMsgArray];
    
//    [self.table reloadData];
    if (isLogin == YES) {
        [self.table reloadData];
    }
     [self setTableFrame];
    
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        //获取群列表
        [self.modelEngineVoip queryGroupWithAsker:self.modelEngineVoip.voipAccount];
    }
   
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1 && indexPath.row==0 && self.msgArr.count==0)
    {
        return 160.0f;
    }
    return 54.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.0f;
    }
    return 23.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0)
    {
        UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 23.0f)] autorelease];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_bg.png"]];
        [headView addSubview:image];
        [image release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, 300, 23.0f)];
        [headView addSubview:label];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"消息列表";
        label.textColor = [UIColor whiteColor];
        [label release];
        
        return headView;
    }
    return [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)] autorelease];;
}

//    划动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //数据库删除
         IMMsg *msg = [self.msgArr objectAtIndex:indexPath.row];
        [self.modelEngineVoip.imDBAccess deleteIMOfSomeone:msg.someone];
        
        [self.msgArr removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.table reloadData];
        
        [self setTableFrame];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && [DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]){
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && [DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers])
    {
        if (indexPath.row == 0)
        {
             [self pushContactPeopleViewController];
        }
        else
        {
            [self goToGroupView];
        }
    }
    else
    {
        if (self.msgArr.count > 0 )
        {
            IMMsg *msg = [self.msgArr objectAtIndex:indexPath.row];
            if (2 == [self sessionTypeOfSomeone:msg.someone])
            {
                IMGroupNotifyViewController *view = [[IMGroupNotifyViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
                [view release];
            }
            else
            {
                SendIMViewController *imdetailView = [[SendIMViewController alloc] initWithReceiver:msg.someone U:msg.userData L:nil];
                imdetailView.backView = self;
                [self.navigationController pushViewController:imdetailView animated:YES];
                [imdetailView release];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        if (section == 0)
        {
            count = 2;
        }
        else
        {
            count = self.msgArr.count==0?0:self.msgArr.count;
        }
        
    }else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Parents]){
        
        if (section == 0) {
            count = self.msgArr.count==0?0:self.msgArr.count;
            
        }
    }
    if (count == 0) {
        [self.view addSubview:[self getNoneMsgView]];
    }else {
       [self removenoneMsgView];
    }

    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    if (indexPath.section == 0 && [DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers])
    {
        static NSString* cellid = @"imlist_section_0_cell";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        
        UILabel *countLabel = nil;
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_icon01.png"]];
            image.center = CGPointMake(28.0f, 27.0f);
            
            if (indexPath.row == 1)
            {
                image.image = [UIImage imageNamed:@"list_icon02.png"];
            }
            
            [cell.contentView addSubview:image];
            [image release];
            
            UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(56.0f, 17.0f, 320.0f-88.0f, 20.0f)];
            idLabel.backgroundColor = [UIColor clearColor];
            idLabel.font = [UIFont systemFontOfSize:17.0f];
            idLabel.tag = 1001;
            countLabel = idLabel;
            [cell.contentView addSubview:idLabel];
            [idLabel release];
            
            UIImageView *accessImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon02.png"]];
            accessImage.center = CGPointMake(320.0f-22.0f, 27.0f);
            [cell.contentView addSubview:accessImage];
            [accessImage release];
            
//            UIImageView *lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"voice_mail_line.png"]];
//            lineImg.frame = CGRectMake(0.0f, 43.0f, 320.0f, 1.0f);
//            [cell addSubview:lineImg];
//            [lineImg release];
        }
        else
        {
            countLabel = (UILabel*)[cell.contentView viewWithTag:1001];
        }
        
        if (indexPath.row == 0)
        {
            countLabel.text = [NSString stringWithFormat:@"通讯录"];
        }
        else
        {
            countLabel.text = @"群组";
        }
    }
    else if(self.msgArr.count == 0 )
    {
        static NSString* cellid = @"imlist_section_1_none_cell";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:[self getNoneMsgView]];
        }
    }
    else
    {
        IMMsg *msg = [self.msgArr objectAtIndex:indexPath.row];
        static NSString* cellid = @"imlist_section_1_cell";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        UILabel *nameLabel = nil;
        UILabel *msgLabel = nil;
        UILabel *timeLabel = nil;
        UILabel *unreadLabel = nil;
        UIImageView *porImage = nil;
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
           
            
            for (UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_icon02.png"]];
            image.center = CGPointMake(28.0f, 27.0f);
            porImage = image;
            image.tag = 1000;
            [cell.contentView addSubview:image];
            [image release];
            
            UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(56.0f, 12.0f, 320.0f-88.0f, 17.0f)];
            idLabel.backgroundColor = [UIColor clearColor];
            idLabel.font = [UIFont systemFontOfSize:15.0f];
            idLabel.tag = 1001;
            nameLabel = idLabel;
            [cell.contentView addSubview:idLabel];
            [idLabel release];
            
            UILabel *msgLabeltmp = [[UILabel alloc] initWithFrame:CGRectMake(56.0f, 31.0f, 200.0f, 13.0f)];
            msgLabeltmp.backgroundColor = [UIColor clearColor];
            msgLabeltmp.font = [UIFont systemFontOfSize:12.0f];
            msgLabel.textColor = [UIColor grayColor];
            msgLabeltmp.tag = 1002;
            msgLabel = msgLabeltmp;
            [cell.contentView addSubview:msgLabeltmp];
            [msgLabeltmp release];
            
            UILabel *ttLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 15.0f, 110.0f, 13.0f)];
            ttLabel.backgroundColor = [UIColor clearColor];
            ttLabel.font = [UIFont systemFontOfSize:11.0f];
            ttLabel.textColor = [UIColor grayColor];
            ttLabel.tag = 1003;
            ttLabel.textAlignment = NSTextAlignmentRight;
            timeLabel = ttLabel;
            [cell.contentView addSubview:ttLabel];
            [ttLabel release];
            
            UILabel *ucLabel = [[UILabel alloc] initWithFrame:CGRectMake(280.0f, 30.0f, 21.0f, 15.0f)];
            ucLabel.backgroundColor = [UIColor redColor];
            ucLabel.font = [UIFont systemFontOfSize:11.0f];
            ucLabel.textColor = [UIColor whiteColor];
            ucLabel.tag = 1004;
            ucLabel.textAlignment = NSTextAlignmentCenter;
            unreadLabel = ucLabel;
            [cell.contentView addSubview:ucLabel];
            [ucLabel release];
            
//            UIImageView *lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"voice_mail_line.png"]];
//            lineImg.frame = CGRectMake(0.0f, 43.0f, 320.0f, 1.0f);
//            [cell addSubview:lineImg];
//            [lineImg release];
        }
        else
        {
            porImage = (UIImageView*)[cell.contentView viewWithTag:1000];
            nameLabel = (UILabel*)[cell.contentView viewWithTag:1001];
            msgLabel = (UILabel*)[cell.contentView viewWithTag:1002];
            timeLabel = (UILabel*)[cell.contentView viewWithTag:1003];
            unreadLabel = (UILabel*)[cell.contentView viewWithTag:1004];
        }
        
        NSInteger type = [self sessionTypeOfSomeone:msg.someone];
        
        cell.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;

//        nameLabel.text = msg.someone;
         NSLog(@"原来%@",msg.userData);
        if(![msg.userData isEqualToString:[DELEGATE getLoginName]]){
            NSArray *tmpArray = [msg.userData componentsSeparatedByString:@","];
            if ([tmpArray count] > 1) {
                nameLabel.text = [tmpArray objectAtIndex:0];
            }else{
               nameLabel.text = msg.userData;
            }
        }
       
        if (msg.msgtype == 1)
        {
            msgLabel.text = @"文件";
        }
        else if (msg.msgtype == 3)
        {
            msgLabel.text = @"语音";
        }
        else
        {
            msgLabel.text = msg.content;
        }
        if (type == 2)
        {
            porImage.image = [UIImage imageNamed:@"system_messages_icon.png"];
            nameLabel.text = @"系统通知消息";
            msgLabel.text = msg.content;
        }
        else if(type == 1)
        {
            porImage.image = [UIImage imageNamed:@"list_icon02.png"];
        }
        else
        {
            porImage.image = [UIImage imageNamed:@"list_icon03.png"];
        }
        

        timeLabel.text = [self dateStr:msg.date];
        int count = [self.modelEngineVoip.imDBAccess getUnreadCountOfSomeone:msg.someone LoginKey:[ConfigManager sharedConfigManager].loginKey];
        if (count == 0)
        {
            unreadLabel.text = @"";
            unreadLabel.backgroundColor = [UIColor clearColor];
        }
        else
        {
            unreadLabel.backgroundColor = [UIColor redColor];
            unreadLabel.text = [NSString stringWithFormat:@"%d", count];
        }
    }
    
//    cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 0;
    if (isLogin == YES) {
        if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
            count = 2;
        }else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Parents]){
            count = 1;
        }
    }
    
    return count;
}

//#pragma mark 班级
//-(void) pushGradeClass
//{
//    GradeClassViewController *nc = [[GradeClassViewController alloc] initWithDelegate:self Select:YES ];
//    [self.navigationController pushViewController:nc animated:YES];
//    [nc release];
//}

- (void)pushContactPeopleViewController{
    ContactPeopleViewController *next = [[ContactPeopleViewController alloc] init ];
    next.backView = self;
    [self.navigationController pushViewController:next animated:YES];
    [next release];

}

#pragma mark - UIDelegate
- (void)responseMessageStatus:(EMessageStatusResult)event callNumber:(NSString *)callNumber data:(NSString *)data
{
    switch (event)
	{
        case EMessageStatus_Received:
        {
            [self getMsgArray];
            
            if (isLogin == YES) {
                [self.table reloadData];
            }
             [self setTableFrame];
        }
            break;
        case EMessageStatus_Send:
        {
            
        }
            break;
        case EMessageStatus_SendFailed:
        {
            
        }
            break;
        default:
            break;
    }
    
}

-(void)responseDownLoadMediaMessageStatus:(int)event
{
    switch (event)
	{
        case 0:
        {
            [self getMsgArray];
            
            if (isLogin == YES) {
                [self.table reloadData];
            }
             [self setTableFrame];
        }
            break;
        default:
            break;
    }
}

//登录成功
- (void)loginOnConnected{
//    [self animationRemoveHUD];
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    if (self.isLogin == NO) {
        self.isLogin = YES;
        [self.table reloadData];
    }
     [self setTableFrame];
    
}

//登录失败
- (void) loginOnConnectError{
//    [self animationRemoveHUD];
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    if (self.isLogin == NO) {
        [self  popPromptViewWithMsg:@"当前无网络，请稍后再试！" AndFrame:CGRectMake(0, 160, 320, 30)];
    }
}

#pragma mark GradeClassViewController delegate //班级、学生、老师选中名称委托 (只有老师才能选择联系学生)
- (void) selectNamesFinsh:(id)tempData
{
    NSDictionary *studentsDic = tempData;
    
    //有数据才返回
    NSArray *keys = [studentsDic allKeys];
    if (keys) {
        if ([keys count]) {
            [self getAccountInfoWithDic:studentsDic];
            [self save:studentsDic];
        }
    }

}

- (void)save:(NSDictionary *)dic{
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        NSDictionary *oneStudentDic = [dic objectForKey:key];
        InfoStudent *info = [[InfoStudent alloc] init];
        info.sname = [oneStudentDic objectForKey:@"sname"];
        info.schoolid = [[oneStudentDic objectForKey:@"schoolid"] integerValue];
        info.xuehao = [[oneStudentDic objectForKey:@"xuehao"] integerValue];
        info.classid = [[oneStudentDic objectForKey:@"classid"] integerValue];
        info.gradeid = [[oneStudentDic objectForKey:@"gradeid"] integerValue];
        NSArray *array = [self.modelEngineVoip.imDBAccess searchInfoName:info.sname] ;
        if ( array != nil && [array count] == 0) {
            [self.modelEngineVoip.imDBAccess insertInfoTable:info];
        }
        [info release];
    }
}

//群列表信息
-(void)onMemberQueryGroupWithReason:(NSInteger)reason andGroups:(NSArray *)groups
{
    if (reason == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i < [groups count]; i++) {
//                IMGroup * group = [groups objectAtIndex:i];
//                NSLog(@"%@",group.name);
//                NSLog(@"%@",group.type);
//                
//            }
            for (int i = 0; i < [groups count]; i++) {
                IMGroup * group = [groups objectAtIndex:i];
                if ([group.type isEqualToString:@"0"]) {
                    //解散
                    [self.modelEngineVoip deleteGroupWithGroupId:group.groupId];
                }
            }
        });
    }
}

#pragma mark -
#pragma mark 语音通讯账号返回(只有老师才能选择联系学生)
- (void)notificationIMListViewController:(NSNotification*) notification{
    //登录账号
    if ([[notification.object objectForKey:NotificationSecondKey] isEqualToString:NotificationLoginAccountInfo]) {
        //有可能 object 是NSArray
        id object = [notification.userInfo objectForKey:@"account"];
        id subObject = nil;
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray *array = object;
            if ([array count] > 0) {
                subObject = [array objectAtIndex:0];
            }
        }else if([object isKindOfClass:[NSDictionary class]]){
            subObject = object;
        }
        
        //判断是否是NSDictionary
        if ([subObject isKindOfClass:[NSDictionary class]]) {
//             NSLog(@"NSDictionary = %@",subObject);
            [self loginVoiceCommunication:subObject];
           
        }else {
//            [self animationRemoveHUD];
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            [self  popPromptViewWithMsg:@"当前无网络，请稍后再试！" AndFrame:CGRectMake(0, 160, 320, 30)];
        }
    }
    
    //用于联系其它子账号 (学生的账号)
    else if ([[notification.object objectForKey:NotificationSecondKey] isEqualToString:NotificationNOLoginAccountInfo]) {
        NSDictionary *subaccountInfo = [[notification.userInfo objectForKey:@"account"] objectAtIndex:0];
        AccountInfo *info = nil;
        if (subaccountInfo) {
            info = [[AccountInfo alloc] init];
            id subAccount = [subaccountInfo objectForKey:@"subAccountid"];
            if ([subAccount isKindOfClass:[NSString class]]) {
                info.subAccount =  subAccount;
            }else if ([subAccount isKindOfClass:[NSArray class]]) {
                if ([subAccount count] > 0) {
                    info.subAccount =  [subAccount objectAtIndex:0];
                }
            }
            id subToken = [subaccountInfo objectForKey:@"subToken"];
            if ([subToken isKindOfClass:[NSString class]]) {
                info.subToken =  subToken;
            }else if ([subToken isKindOfClass:[NSArray class]]) {
                if ([subToken count] > 0) {
                    info.subToken =  [subToken objectAtIndex:0];
                }
            }
            id voipId = [subaccountInfo objectForKey:@"voipAccount"];
            if ([voipId isKindOfClass:[NSString class]]) {
                info.voipId =  voipId;
            }else if ([voipId isKindOfClass:[NSArray class]]) {
                if ([voipId count] > 0) {
                    info.voipId =  [voipId objectAtIndex:0];
                }
            }

            id password = [subaccountInfo objectForKey:@"voipPwd"];
            if ([password isKindOfClass:[NSString class]]) {
                info.password =  password;
            }else if ([password isKindOfClass:[NSArray class]]) {
                if ([password count] > 0) {
                    info.password =  [password objectAtIndex:0];
                }
            }
            
            BOOL isExist = NO;
            for (AccountInfo *tmpInfo in self.modelEngineVoip.accountArray) {
                if([info.voipId isEqualToString:tmpInfo.voipId]){
                    isExist = YES;
                    break;
                }
            }
            if (isExist == NO) {
                [self.modelEngineVoip.accountArray addObject:info];
            }
            //用户登录姓名
            NSString *name = [DELEGATE getLoginName];
            
            SendIMViewController *imdetailView = [[SendIMViewController alloc] initWithReceiver:info.voipId U:[subaccountInfo objectForKey:@"sname"] L:name];
            
            //联系人的信息
            if ([[self.connectInfo objectForKey:@"sname"] isEqualToString:[subaccountInfo objectForKey:@"sname"]]) {
                imdetailView.connectInfo = self.connectInfo;
            }
            
            [self.navigationController pushViewController:imdetailView animated:YES];
            [imdetailView release];
            if (info) {
                [info release]; info = nil;
            }
        }
    }
}

@end
