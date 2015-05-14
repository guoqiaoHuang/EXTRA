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

#import "CreateGroupViewController.h"
#import "UIselectContactsViewController.h"
#import "UISelectCell.h"
#import "GradeClassViewController.h"
#import "Global.h"
#import "ConfigManager.h"
#import "IntercomingViewController.h"

@interface CreateGroupViewController ()
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *declardField;
@property (nonatomic, retain) NSString * groupType;
@property (nonatomic, retain) NSString *permission;
@property (nonatomic, retain) UIButton *groupTypeBtn;
@property (nonatomic, retain) UIButton *permissionTypeBtn;
@end

@implementation CreateGroupViewController
@synthesize groupId;
@synthesize accountsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
    
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCreateGroupViewController:) name:NotificationCreateGroupViewController object:nil];
}

- (void)loadView
{
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"返回" target:self action:@selector(popToPreView)]];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
//    [leftBarItem release];
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

    
    self.title = @"建立新群组";
    
    UIBarButtonItem *creatGroup=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"创建" target:self action:@selector(creatNewGroup)]];
    self.navigationItem.rightBarButtonItem = creatGroup;
    [creatGroup release];
    
    UIView* selfview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    selfview.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
    self.view = selfview;
    [selfview release];
    
    UIButton *backgroundBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundBtn.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
    [backgroundBtn addTarget:self action:@selector(keyboardHid) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundBtn];
    [backgroundBtn release];
    
    [self createHeadView];
    [self createInputTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.nameField = nil;
    self.declardField = nil;
    self.groupType = nil;
    self.permission = nil;
    self.groupTypeBtn = nil;
    self.permissionTypeBtn = nil;
    self.groupId = nil;
    self.accountsArray = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCreateGroupViewController object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.modelEngineVoip.UIDelegate = self;
}
#pragma mark - private method

//创建新群组
- (void)creatNewGroup
{
    if ([self.nameField.text isEqualToString: @""] || self.nameField.text == nil){
        [self  popPromptViewWithMsg:@"请输入群组名称" AndFrame:CGRectMake(0, 160, 320, 30)];
        return;
    }
    [self displayProgressingView];
    
    //创建群组
    [self.modelEngineVoip createGroupWithName:self.nameField.text andType:self.groupType andDeclared:self.declardField.text andPermission:self.permission.integerValue];
}

- (void)keyboardHid
{
    [self.nameField resignFirstResponder];
    [self.declardField resignFirstResponder];
}

//创建显示页头
- (void)createHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 23.0f)];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_bg.png"]];
    [headView addSubview:image];
    [image release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, 300, 23.0f)];
    [headView addSubview:label];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"群基本信息";
    label.textColor = [UIColor whiteColor];
    [label release];
    
    [self.view addSubview:headView];
    [headView release];
}

//创建群组属性内容控件
- (void)createInputTextField
{
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 30.0, 300.0, 30.0)];
    self.nameField = myTextField;
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.placeholder = @"群组名称";
    [self.view addSubview:myTextField];
    [myTextField release];
    
//    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 65.0, 300.0, 30.0)];
//    self.declardField = myTextField;
//    myTextField.borderStyle = UITextBorderStyleRoundedRect;
//    myTextField.placeholder = @"群公告（选填）";
//    [self.view addSubview:myTextField];
//    [myTextField release];
    
    
    self.groupType = @"1";
//    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.groupTypeBtn = typeBtn;
//    typeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [typeBtn setTitle:@"临时组(上限100人)[点击进行选择]" forState:UIControlStateNormal];
//    typeBtn.tag = 100;
//    [typeBtn addTarget:self action:@selector(selectGroupInfo:) forControlEvents:UIControlEventTouchUpInside];
//    typeBtn.frame = CGRectMake(10, 100, 300, 30);
//    [self.view addSubview:typeBtn];
    
    self.permission = @"0";
//    UIButton *permissionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.permissionTypeBtn = permissionBtn;
//    [permissionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [permissionBtn setTitle:@"默认直接加入[点击进行选择]" forState:UIControlStateNormal];
//    permissionBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    permissionBtn.tag = 101;
//    [permissionBtn addTarget:self action:@selector(selectGroupInfo:) forControlEvents:UIControlEventTouchUpInside];
//    permissionBtn.frame = CGRectMake(10, 135, 300, 30);
//    [self.view addSubview:permissionBtn];
}

//群组属性按钮事件
- (void)selectGroupInfo:(id)sender
{
    [self keyboardHid];
    UIButton *typebtn = (UIButton*)sender;
    UIActionSheet *menu = nil;
    if (typebtn.tag == 100)
    {
        //群组类型
        menu = [[UIActionSheet alloc]
                initWithTitle: @"群组类型"
                delegate:self
                cancelButtonTitle:nil
                destructiveButtonTitle:nil
                otherButtonTitles:nil];
        menu.tag = 100;
        [menu addButtonWithTitle:@"临时组(上限100人)"]; 
        [menu addButtonWithTitle:@"普通组(上限300人)"];
        [menu addButtonWithTitle:@"VIP组(上限500人)"];
        
    }
    else if (typebtn.tag == 101)
    {
        //群组权限
        menu = [[UIActionSheet alloc]
                initWithTitle: @"群组模式"
                delegate:self
                cancelButtonTitle:nil
                destructiveButtonTitle:nil
                otherButtonTitles:nil];
        menu.tag = 101;
        [menu addButtonWithTitle:@"默认直接加入"];
        [menu addButtonWithTitle:@"需要身份验证"];
        [menu addButtonWithTitle:@"私有群组"];
    }
    
    if (menu != nil)
    {
        [menu addButtonWithTitle:@"取消"];
        [menu setCancelButtonIndex:3];
        [menu showInView:self.view.window];
        [menu release];
    }
}

//创建群组成功跳转选择联系人页面
- (void)goToSelectMembersViewWithGroupId:(NSString*)aGroupId
{
//    UIselectContactsViewController* selectView = [[UIselectContactsViewController alloc] initWithAccountList:self.modelEngineVoip.accountArray andSelectType:ESelectViewType_GroupMemberView];
//    selectView.backView = self.backView;
//    selectView.groupId = groupId;
//    [self.navigationController pushViewController:selectView animated:YES];
//    [selectView release];
    
    //成功后修改名片
    IMGruopCard* groupCard = [[IMGruopCard alloc] init];
    groupCard.belong = aGroupId;
    groupCard.display = [DELEGATE getLoginName];
    [self.modelEngineVoip modifyGroupCard:groupCard];
    [groupCard release];
    
    //添加群成员
    self.groupId = aGroupId;
    GradeClassViewController *nc = [[GradeClassViewController alloc] initWithDelegate:self Select:NO ];
    [self.navigationController pushViewController:nc animated:YES];
    [nc release];

}

#pragma mark GradeClassViewController delegate //班级、学生、老师选中名称委托
- (void) selectNamesFinsh:(id)tempData
{
    NSDictionary *studentsDic = tempData;
    
    //有数据才返回
    NSArray *keys = [studentsDic allKeys];
    if (keys) {
        if ([keys count] > 0) {
            [self getAccountInfoWithDic:studentsDic];         
        }
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
        NSMutableDictionary *postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"xuehao"],@"xuehao",[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"sname"],@"sname", nil];
        NSError *error = nil;
        
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
        
        //json 数据
        NSString *jsonStr = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
        [postArray addObject:jsonStr];
        
        [jsonStr release];
        [postDic release];
    }
    
    if ([keys count] > 0) {
         NSDictionary *oneStudentDic = [dic objectForKey:[keys objectAtIndex:0]];
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"classid"],@"classid",[oneStudentDic objectForKey:@"gradeid"],@"gradeid", nil];
        [self save:tmpDic];
        [tmpDic release];
    }
    
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationCreateGroupViewController,NotificationKey, nil];
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
    //应用apikey type 老师2，学生 1
    [self formDataRequestWithURL:tempURL UserInfo:userInfo DataArray:postArray Header:headerDic Key:loginKey Type:@"1"];
    [postArray release];
}

- (void)save:(NSDictionary *)dic{
    @try {
        InfoStudent *info = [[InfoStudent alloc] init];
        info.schoolid = [[dic objectForKey:@"schoolid"] integerValue];
        info.classid = [[dic objectForKey:@"classid"] integerValue];
        info.gradeid = [[dic objectForKey:@"gradeid"] integerValue];
        info.groupVoipAccount = self.groupId ;
        NSArray *array = [self.modelEngineVoip.imDBAccess searchInfoName:info.sname] ;
        if ( array != nil && [array count] == 0) {
            [self.modelEngineVoip.imDBAccess insertInfoTable:info];
        }
        [info release];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
    }
    @finally {
    }
}



#pragma mark -
#pragma mark 语音通讯账号返回 自己服务器的接口
- (void)notificationCreateGroupViewController:(NSNotification*) notification{
    @try
    {
        NSMutableArray *voipIdArray = [[NSMutableArray alloc] init];
        NSArray *array = [notification.userInfo objectForKey:@"account"];
        self.accountsArray = array;
        for (NSDictionary *subaccountInfo in array) {
            [voipIdArray addObject:[subaccountInfo objectForKey:@"voipAccount"]];
        }
        if ([voipIdArray count] > 0) {
            //群组添加子账号
            [self.modelEngineVoip inviteJoinGroupWithGroupId:groupId andMembers:voipIdArray andDeclared: nil andConfirm:1];
        }
        [voipIdArray release];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    NSString *selectStr = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (actionSheet.tag == 100)
    {
        //群组类型
        self.groupType = [NSString stringWithFormat:@"%d", buttonIndex];
        [self.groupTypeBtn setTitle:[NSString stringWithFormat:@"%@[点击进行选择]", selectStr] forState:UIControlStateNormal];
    }
    else if (actionSheet.tag == 101)
    {
        //申请加入模式
        self.permission = [NSString stringWithFormat:@"%d", buttonIndex];
        [self.permissionTypeBtn setTitle:[NSString stringWithFormat:@"%@[点击进行选择]", selectStr] forState:UIControlStateNormal];
    }
}

//创建群名成功返回
-(void)onGroupCreateGroupWithReason:(NSInteger)reason andGroupId:(NSString *)aGroupId
{
    [self dismissProgressingView];
    if (reason == 0)
    {
        [self goToSelectMembersViewWithGroupId:aGroupId];
    }
    else
    {
        [self  popPromptViewWithMsg:@"创建群组失败，请稍后再试！" AndFrame:CGRectMake(0, 160, 320, 30)];
    }
}

//对讲场景状态
- (void)onInterphoneStateWithReason:(NSInteger)reason andConfNo:(NSString*)confNo
{
    [self dismissProgressingView];
    if (reason == 0 && confNo.length > 0)
    {
        IntercomingViewController *intercoming = [[IntercomingViewController alloc] init];
        intercoming.curInterphoneId = confNo;
        intercoming.navigationItem.hidesBackButton = YES;
        intercoming.backView = self.backView;
        [self.navigationController pushViewController:intercoming animated:YES];
        [intercoming release];
    }
    else
    {
        UIAlertView *alertView=nil;
        alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发起对讲失败，请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void) onGroupInviteJoinGroupWithReason:(NSInteger)reason
{
    if (reason == 0) {
        if (self.accountsArray) {
            for (NSDictionary *dic in self.accountsArray) {
                //成功后修改名片 群成员的名片
                IMGruopCard* groupCard = [[IMGruopCard alloc] init];
                groupCard.belong = self.groupId;
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
                
                
                [self.modelEngineVoip modifyGroupCard:groupCard];
                [groupCard release];
            }
           
        }
        [self dismissProgressingView];
        [self popToPreView];
    }
}
@end
