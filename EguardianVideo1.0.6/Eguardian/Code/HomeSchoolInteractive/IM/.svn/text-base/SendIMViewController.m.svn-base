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

#import "SendIMViewController.h"
#import "HPGrowingTextView.h"
#import "IMMsgDBAccess.h"
#import "GroupInfoViewController.h"
#import "Global.h"
#import "ConfigManager.h"
#import "NSDateFormatter+help.h"

#define ATTACH_BTN_TAG  100
#define VOICE_BTN_TAG   101

#define CONTAINER_VIEW_DISPLAY_HEIGHT 45.0f

#define R_CONTENT_FONT_SIZE 15.0f
#define R_CONTENT_WIDTH 220.0f

#define S_CONTENT_FONT_SIZE 13.0f
#define S_CONTENT_WIDTH 180.0f

@interface SendIMViewController ()
{
    HPGrowingTextView   *textView;
    NSInteger isGroupMsg;
}
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) NSArray *chatArray;
@property (nonatomic, retain) NSString *receiver;


@end

@implementation SendIMViewController
@synthesize curImg;
@synthesize groupID;
@synthesize curRecordFile;
@synthesize table;
@synthesize popView;
@synthesize ivPopImg;
@synthesize imgArray;
@synthesize curVoiceSid;
@synthesize backView;
@synthesize recordTimer;
@synthesize userdata;
@synthesize loginName;
@synthesize connectInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithReceiver:(NSString*)rec U:(NSString*)aUserdata L:(NSString *)aLoginName
{
    self = [super init];
    if (self)
    {
        self.receiver = rec;
        self.userdata = aUserdata;
        self.loginName = aLoginName;
    }
    return self;
}

- (id)initWithReceiver:(NSString*)rec{
    self = [super init];
    if (self)
    {
        self.receiver = rec;
//        self.groupName = aGroupName;
    }
    return self;
}

#pragma mark - LoadView
- (void)loadView
{
    isGroupMsg = 0;
    isPlaying = NO;
    UIView* selfview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    selfview.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
    self.view = selfview;
    [selfview release];
    
    //定制返回按钮
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(popToBackView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
    
    SEL rightSel = nil;
    NSString *rightTitle = nil;
    if ([self isGroupMsg])
    {
        if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
            //获取登录的姓名
            rightSel = @selector(goToGroupInfoView);
            rightTitle = @"群资料";
        }
    }
    else
    {
//        self.title = self.receiver;
        self.title = self.userdata;
        rightSel = @selector(clearMessage);
        rightTitle = @"清除";
    }
    
    //学生群的不要这个按钮
    if ([self isGroupMsg]){
        if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
            UIBarButtonItem *clearMessage=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:rightTitle target:self action:rightSel]];
            self.navigationItem.rightBarButtonItem = clearMessage;
            [clearMessage release];
        }
    }else {
        UIBarButtonItem *clearMessage=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:rightTitle target:self action:rightSel]];
        self.navigationItem.rightBarButtonItem = clearMessage;
        [clearMessage release];
    }
    
    
    UITableView* tableView = nil;
    if (IPHONE5)
    {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 578.f-44.f-45.f-20.f) style:UITableViewStylePlain];
    }
    else
    {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460 - 44 - 45) style:UITableViewStylePlain];
    }
    
    tableView.allowsSelection = NO;
    self.table = tableView;
    self.table.allowsSelection = YES;
    self.table.allowsSelectionDuringEditing = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
    tableView.tableFooterView = [[[UIView alloc] init] autorelease];
    [self.view addSubview:tableView];
    [tableView release];
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30.0f-45.0f + 30, 320, 40.0f + 5)];
    self.containerView = view;
    self.containerView.backgroundColor = [UIColor colorWithRed:225.0f/255.0f green:225.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
    [self.view addSubview:view];
    [view release];
        
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(50.0f, 6.5f, 220.0f - 50.0f + 20.0f,  37.0f)];
    textView.contentInset = UIEdgeInsetsMake(-2, 5, -2, 5);
    textView.backgroundColor = [UIColor clearColor];
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 4;
    textView.returnKeyType = UIReturnKeyDefault;
    textView.font = [UIFont systemFontOfSize:12.0f];
    textView.delegate = self;
    textView.placeholder = @"添加文本";
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.containerView addSubview:textView];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(250.0f,  8.0f, 60.0f, 27.0f);
    sendBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"talk_send_button_off.png"] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"talk_send_button_on.png"] forState:UIControlStateHighlighted];
    [self.containerView addSubview:sendBtn];
    
//    UIButton *attachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    attachBtn.tag = ATTACH_BTN_TAG;
//    attachBtn.frame = CGRectMake(0.0f, 45.0f, 160.0f, 30.0f);
//    attachBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//    [attachBtn setBackgroundImage:[UIImage imageNamed:@"file_icon.png"] forState:UIControlStateNormal];
//    [attachBtn setBackgroundImage:[UIImage imageNamed:@"file_icon_on.png"] forState:UIControlStateHighlighted];
//    [attachBtn addTarget:self action:@selector(additionFunction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.containerView addSubview:attachBtn];
    
    voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    voiceBtn.tag = VOICE_BTN_TAG;
    voiceBtn.frame = CGRectMake(5.0f, 3.5f, 50.0f, 37.0f);
    voiceBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"IM_voice_icon.png"] forState:UIControlStateNormal];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"IM_voice_icon.png"] forState:UIControlStateHighlighted];
    [voiceBtn addTarget:self action:@selector(additionFunction:) forControlEvents:UIControlEventTouchUpInside];

    [voiceBtn addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchDown];
    [voiceBtn addTarget:self action:@selector(recordCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [voiceBtn addTarget:self action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    [voiceBtn addTarget:self action:@selector(touchOutside) forControlEvents:(UIControlEventTouchDragOutside)];
    [voiceBtn addTarget:self action:@selector(touchInside) forControlEvents:(UIControlEventTouchDragInside)];    
    
    [self.containerView addSubview:voiceBtn];
    
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    
    UIView* viewPop = [[UIView alloc] initWithFrame:CGRectMake(90, self.view.frame.size.height-35.0f-40.0f- 200, 139, 139)];
    UIImageView* ivPhoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 139, 139)];
    ivPhoneIcon.image = [UIImage imageNamed:@"message_interphone_bg.png"];
    [viewPop addSubview:ivPhoneIcon];
    [ivPhoneIcon release];
    
    UIImageView* imgViewPop = [[UIImageView alloc] init];
    imgViewPop.frame  = CGRectMake(100, 55, 23, 53);
    imgViewPop.contentMode = UIViewContentModeBottom;
    [viewPop addSubview:imgViewPop];
    self.ivPopImg = imgViewPop;
    [imgViewPop release];
    
    viewPop.hidden = NO;
    [self.view addSubview:viewPop];
    self.popView = viewPop;
    [viewPop release];
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:6];
    for (int i = 0;i <= 5; i++)
    {
        UIImage * img =[UIImage imageNamed:[NSString stringWithFormat:@"message_interphone%02d.png",i+1]];
        [arr addObject:img];
    }
    self.imgArray = arr;
    [arr release];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopRecMsg];
    self.popView.hidden = YES;
}

//语音通讯积分添加
- (void)netWork:(NSArray *) array {
    if (array && [array count] > 0) {
        InfoStudent * info = [array objectAtIndex:0];
        NSString *g = [self.receiver substringToIndex:1];
        NSString *tempURL = nil;
        //群
        if ([g isEqualToString:@"g"]){
           tempURL = [ConfigManager getVdeoHomeSchoolInteractive:0 Classid:info.classid Gradeid:info.gradeid];

        }
        //点对点
        else{
            tempURL = [ConfigManager getVdeoHomeSchoolInteractive:info.xuehao Classid:info.classid Gradeid:info.gradeid];
        }

        [self requestWithURL:tempURL UserInfo:nil Model:PartViewModel];

    }
    
}

- (NSString *)dateStr:(NSString *) temDate{
    NSDateFormatter *farmatter = [NSDateFormatter getYyyyMmDdHMS];
    NSDate *date = [farmatter dateFromString:temDate];
    farmatter = [NSDateFormatter getYyyy_Mm_DdHMS];
    return  [farmatter stringFromDate:date];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    MWPhoto *photo = [MWPhoto photoWithFilePath:self.filename];
    return photo;
}

#pragma mark - ViewControllerDelegate
- (void)dealloc
{
    [textView release];
    self.containerView = nil;
    self.table = nil;
    self.receiver = nil;
    self.filename = nil;
    self.curImg = nil;
    self.groupID = nil;
    self.curRecordFile = nil;
    self.popView = nil;
    self.ivPopImg = nil;
    self.imgArray = nil;
    self.curVoiceSid = nil;
    self.backView = nil;
    [self.recordTimer invalidate];
    self.recordTimer = nil;
    self.loginName = nil;
    self.userdata = nil;
    self.connectInfo = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.popView.hidden = YES;
    self.modelEngineVoip.UIDelegate = self;
    [self.modelEngineVoip.imDBAccess updateUnreadStateOfSomeone:self.receiver LoginKey:[ConfigManager sharedConfigManager].loginKey];
    self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
    if ([self isGroupMsg])
    {
        [self.modelEngineVoip queryGroupDetailWithGroupId:self.receiver];
    }
    [self.table reloadData];
    [self addNotification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeNotification];
    [self.modelEngineVoip.imDBAccess updateUnreadStateOfSomeone:self.receiver LoginKey:[ConfigManager sharedConfigManager].loginKey];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(BOOL)isGroupMsg
{
    if (isGroupMsg == 0)
    {
        NSString *g = [self.receiver substringToIndex:1];
        if ([g isEqualToString:@"g"])
        {
            isGroupMsg = 100;
        }
        else
        {
            isGroupMsg = -100;
        }
    }
    
    if (isGroupMsg == 100)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)goToGroupInfoView
{
    GroupInfoViewController *view = [[GroupInfoViewController alloc] initWithGroupId:self.receiver andIsMyJoin:YES andPermission:0];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}

-(void)popToBackView
{
    [self.navigationController popToViewController:self.backView animated:YES];
}

- (void)clearMessage
{
    [self stopRecMsg];
    [self.modelEngineVoip.imDBAccess deleteIMOfSomeone:self.receiver];
    
    self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
    [self.table reloadData];
}

- (CGFloat)getCellHeightWithMsg:(IMMsg*)msg
{
    CGFloat heigt = 80.0f;
    if (msg.msgtype == 0 && (msg.imState == 0 || msg.imState == 1))
    {
        CGSize size = [msg.content sizeWithFont:[UIFont systemFontOfSize:S_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(S_CONTENT_WIDTH, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        heigt = size.height + 50.0f;
    }
    else if (msg.msgtype == 0 && (msg.imState == 2 || msg.imState == 3))
    {
        CGSize size = [msg.content sizeWithFont:[UIFont systemFontOfSize:R_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(R_CONTENT_WIDTH, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        heigt = size.height + 50.0f;
    }
    else if (msg.msgtype == 1 && (msg.imState == 0 || msg.imState == 1))
    {
        heigt = 70.0f;
    }
    return heigt;
}

-(void)sendMessage:(id)sender
{
    [self stopRecMsg];
    if (textView.text.length < 1)
    {
        return;
    }
    IMMsg *msg = [[IMMsg alloc] init];
    msg.content = textView.text;
    msg.someone = self.receiver;
    msg.msgtype = 0;
    msg.isRead = 1;
    msg.imState = 4;
    msg.userData = self.userdata;
    msg.loginName = self.loginName;
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *curTimeStr = [dateformatter stringFromDate:[NSDate date]];
    [dateformatter release];
    msg.date = curTimeStr;
    
    [self getLoginName];
    
    NSString* cid = [self.modelEngineVoip sendInstanceMessage:self.receiver andText:textView.text andAttached:nil andUserdata:self.loginName];
    if (cid.length > 0)
    {
        msg.msgid = cid;
        [self.modelEngineVoip.imDBAccess addNewIM:msg];
    }
    
    textView.text = @"";
    
    self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
    [self.table reloadData];
    
    if([self.chatArray count]>0)
		[self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    [msg release];
   
    [self teacherIntegral];
}

- (void)getLoginName{
    
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        //获取登录的姓名
        if (self.loginName == nil) {
            self.loginName = [DELEGATE getLoginName];
        }
    }else {
        if (self.loginName == nil) {
            self.loginName = [[ConfigManager sharedConfigManager].userMessage objectForKey:@"sname"];
        }
    }
}

- (NSString *)getName {
    NSString *name = nil;
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        //获取登录的姓名
        name = [DELEGATE getLoginName];
    }else {
        name = [[ConfigManager sharedConfigManager].userMessage objectForKey:@"sname"];
    }
    return name;
}

//老师积分
- (void)teacherIntegral{
    //只有老师才有积分
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        NSString *g = [self.receiver substringToIndex:1];
        NSArray *array = nil;
        //群
        if ([g isEqualToString:@"g"])
        {
            array = [self.modelEngineVoip.imDBAccess searchInfoAccountID:self.receiver];
        }
        //点对点
        else
        {
            array = [self.modelEngineVoip.imDBAccess searchInfoName:self.userdata];
            
        }
        if (array) {
             [self netWork:array];
        }
    
        
    }
}

-(void)additionFunction:(id)sender
{
    [self stopRecMsg];
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == ATTACH_BTN_TAG)
    {
        UIActionSheet *menu;
        menu = [[UIActionSheet alloc]
                initWithTitle:nil
                delegate:self
                cancelButtonTitle:@"取消"
                destructiveButtonTitle:nil
                otherButtonTitles: @"相册图片", @"拍照", nil];
        menu.tag = 9999;
        [menu showInView:self.view.window];
        self.viewActionSheet = menu;
        [menu release];
    }
    else if (btn.tag == VOICE_BTN_TAG)
    {
    
    }
}
#pragma mark - UIActionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == actionSheet.cancelButtonIndex )
    {
        return;
    }
    
    switch ( buttonIndex )
    {
        case 0:     //相册图片
        {
            isSavedToAlbum = NO;
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            ipc.allowsEditing = YES;
            self.imagePicker = ipc;
            [self presentModalViewController:ipc animated:YES];
            [ipc release];
        }
            break;
        case 1:     //拍照
        {
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )  //判断设备是否支持拍照功能
            {
                isSavedToAlbum = YES;
                UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
                ipc.delegate = self;
                ipc.allowsEditing = YES;
                self.imagePicker = ipc;
                [self presentModalViewController:ipc animated:YES];
                [ipc release];
            }
            else
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 9999;
                [alert show];
                [alert release];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark Camera View Delegate Methods
//3.x  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try
    {
        //    UIImagePickerControllerSourceType type = picker.sourceType;
        [self dismissModalViewControllerAnimated:NO];
        UIImage* imageSource = [info objectForKey:UIImagePickerControllerOriginalImage];
        if ( isSavedToAlbum )
        {
            UIImageWriteToSavedPhotosAlbum(imageSource, nil, nil, nil );
        }
        NSString* strFilename = [self saveToDocment:imageSource];
        self.imagePicker = nil;
        IMMsg* imMsg = [[IMMsg alloc] init];
        imMsg.content = strFilename;
        imMsg.someone = self.receiver;
        imMsg.imState = 4;
        imMsg.msgtype = 1;
        imMsg.isRead = 1;
        NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *curTimeStr = [dateformatter stringFromDate:[NSDate date]];
        [dateformatter release];
        imMsg.date = curTimeStr;
        
        NSString* msgid = [self.modelEngineVoip sendInstanceMessage:self.receiver andText:nil andAttached:strFilename andUserdata:self.userdata];
        imMsg.msgid = msgid;
        [self.modelEngineVoip.imDBAccess addNewIM:imMsg];
        [imMsg release];
        
        self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
        [self.table reloadData];
        
        if([self.chatArray count]>0)
            [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    @catch (NSException *exception)
    {
        [self  popPromptViewWithMsg:@"发送附件失败，请稍后再试！" AndFrame:CGRectMake(0, 160, 320, 30)];
    }
    @finally {
        [self.table reloadData];
        
        if([self.chatArray count]>0)
            [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(NSString*)saveToDocment:(UIImage*)image
{
	NSDate *date=[NSDate date];
	NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
	NSDateComponents *component=[calendar components:unitFlags fromDate:date];
    [calendar release];
    
	int year=[component year];
	int month=[component month];
	int day=[component day];
	int h=[component hour];
	int m=[component minute];
	int s=[component second];
	NSString* fileName=[NSString stringWithFormat:@"%d-%d-%d_%d:%d:%d.jpg",year,month,day,h,m,s];
	//NSLog(@"%@",fileName);
	NSString*  filePath=[NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
	//NSLog(@"filePath:%@",filePath);
    //图片按0.5的质量压缩－》转换为NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
	[imageData writeToFile:filePath atomically:YES];
    return filePath;
}

//用户选择取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    self.imagePicker = nil;
}
-(void) keyboardWillShow:(NSNotification*)note
{
    //get keyboard size and location
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    //nees to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    

    CGRect containerFrame = self.containerView.frame;

    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + CONTAINER_VIEW_DISPLAY_HEIGHT);
    
    //animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    //set views with new info
    self.containerView.frame = containerFrame;
    
    self.table.frame = CGRectMake(0.0f, 0.0f, 320.0f, containerFrame.origin.y);
    
    //commit animations
    [UIView commitAnimations];
    
    if([self.chatArray count]>0)
		[self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void) keyboardWillHide:(NSNotification*)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    //get a rect for the textView frame
    CGRect containerFrame = self.containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    //tableView
    //animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView setAnimationDuration:[duration doubleValue]];
    
    //set view with new info
    self.containerView.frame = containerFrame;
    
    self.table.frame = CGRectMake(0.0f, 0.0f, 320.0f, containerFrame.origin.y);
    
    //commit animations
    [UIView commitAnimations];
}


#pragma mark - HPGrowingTextView delegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = self.containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.containerView.frame = r;
    CGRect tableFrame = self.table.frame;
    tableFrame.size.height += diff;
    self.table.frame = tableFrame;

    if (self.chatArray.count>0)
    {
        [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.chatArray.count-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.length == 1) {
        return YES;
    }
    
    NSInteger textLength = textView.text.length;
    NSInteger replaceLength = text.length;
    if ( (textLength + replaceLength) >= 251)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:@"内容最多为250" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        [av release];
        return NO;
    }
    return YES;
}


-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [textView resignFirstResponder];
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMMsg *msg = [self.chatArray objectAtIndex:indexPath.row];
    
    return [self getCellHeightWithMsg:msg];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMMsg *msg = [self.chatArray objectAtIndex:indexPath.row];
    if (msg.msgtype == 1 ) {
        NSString *file =[msg.content lastPathComponent];
        NSString *fullFile =[NSTemporaryDirectory() stringByAppendingPathComponent:file];
        self.filename =fullFile;
        
        [photoBrowser reloadData];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:nc animated:YES];
        [nc release];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
//    NSString* strVoipAccount = [self.modelEngineVoip.voipAccount substringFromIndex:10];
    NSString* strVoipAccount =  [self getName];
    IMMsg *msg = [self.chatArray objectAtIndex:indexPath.row];
    
    if (msg.imState == 2)
    {
        //群组
        if ([self isGroupMsg])
        {
            cell = [self tableView:tableView cellOfGroupReceiveMsg:msg];
            if (msg.userData) {
                NSArray *tmpArray = [msg.userData componentsSeparatedByString:@","];
                if ([tmpArray count] > 1) {
                    strVoipAccount = [tmpArray objectAtIndex:1];
                }
            }
        }
        else
        {
            cell = [self tableView:tableView cellOfP2PReceiveMsg:msg];
            strVoipAccount = msg.userData;
        }
        
//        strVoipAccount = msg.sender.length>4?([msg.sender substringFromIndex:msg.sender.length-4]):(msg.sender);
//        strVoipAccount = msg.userData;
        
    }
    else if (msg.msgtype == 0 && (msg.imState <= 1 || msg.imState == 4 || msg.imState == 5)) //send text message
    {
        UILabel *contentLabel = nil;
        UILabel *timeLabel = nil;
        static NSString* cellid = @"im_text_s_message_cell_id";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"talk_line.png"]];
            lineImg.frame = CGRectMake(65.0f, 0.0f, 195.0f, 2.0f);
            [cell addSubview:lineImg];
            [lineImg release];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.tag = 1001;
            label1.font = [UIFont systemFontOfSize:S_CONTENT_FONT_SIZE];
            label1.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
            contentLabel = label1;
            contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            contentLabel.numberOfLines = 10;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = [UIColor grayColor];
            label2.tag = 1002;
            label2.backgroundColor = [UIColor clearColor];
            timeLabel = label2;
            label2.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:label2];
            [label2 release];            
        }
        else
        {
            contentLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
        }
        
        CGSize size = [msg.content sizeWithFont:[UIFont systemFontOfSize:S_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(S_CONTENT_WIDTH, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        contentLabel.frame = CGRectMake(65.0f, 7.0f, size.width, size.height);
        contentLabel.text = msg.content;
        
        timeLabel.frame = CGRectMake(70.0f, 12.0f+size.height, 160.0f, 10.0f);
//        timeLabel.text = msg.date;
        
        timeLabel.text = [self dateStr:msg.date];
    }
    else  if (msg.msgtype == 1)//send attach message
    {
        UILabel *nameLabel = nil;
        UILabel *timeLabel = nil;
        static NSString* cellid = @"im_attach_s_message_cell_id";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"talk_line.png"]];
            lineImg.frame = CGRectMake(65.0f, 0.0f, 195.0f, 2.0f);
            [cell addSubview:lineImg];
            [lineImg release];
            
            UIImageView *attachImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"talk_box_file_icon.png"]];
            attachImg.frame = CGRectMake(65.0f, 7.0f, 19.0f, 18.0f);
            [cell addSubview:attachImg];
            [attachImg release];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 9.0f, 150.0f, 18.0f)];
            label1.font = [UIFont systemFontOfSize:S_CONTENT_FONT_SIZE];
            label1.backgroundColor = VIEW_BACKGROUND_COLOR_WHITE;
            nameLabel = label1;
            label1.tag = 1001;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 28.0, 160.0f, 10.0f)];
            label2.textColor = [UIColor grayColor];
            timeLabel = label2;
            timeLabel.font = [UIFont systemFontOfSize:13.0f];
            label2.tag = 1002;
            label2.backgroundColor = [UIColor clearColor];
            [cell addSubview:label2];
            [label2 release];
        }
        else
        {
            nameLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
        }
        NSArray *strArr = [msg.content componentsSeparatedByString:@"/"];
        nameLabel.text = strArr.lastObject;
//        timeLabel.text = msg.date;
        timeLabel.text = [self dateStr:msg.date];
    }
    else
    {
        cell = [self getVoiceCellWithTable:tableView andCell:cell andMsg: msg andType:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in cell.subviews)
    {
        if (view.tag > 2000)
        {
            [view removeFromSuperview];
        }
    }
    
    //头像
    int x1 = 320 -55;
    if (msg.imState ==2 || msg.imState ==3)
    {
        x1 = 12;
    }
    UIImageView* ivContact = [[UIImageView alloc] initWithFrame:CGRectMake(x1, 8, 45, 46)];
    ivContact.image = [UIImage imageNamed:@"message_avatar.png"];
    [cell addSubview:ivContact];
    ivContact.tag = 2001;
    [ivContact release];
    
    UILabel* lbName = [[UILabel alloc] initWithFrame:CGRectMake(x1, 56, 45, 13)];
    lbName.text  = strVoipAccount;
    lbName.textAlignment = UITextAlignmentCenter;
    lbName.font = [UIFont systemFontOfSize:11];
    lbName.backgroundColor = [UIColor clearColor];
    lbName.textColor = [UIColor blackColor];
    lbName.tag = 2002;
    [cell addSubview:lbName];
    [lbName release];
        
    if (msg.imState == 1)
    {
        UIImageView *failureImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sms_failure.png"]];
        failureImg.frame = CGRectMake(10.0f, 26.0f, 44.0f, 24.0f);
        [cell addSubview:failureImg];
        failureImg.tag = 2003;
        [failureImg release];
    }    
    else if (msg.imState == 4)
    {
        UIActivityIndicatorView *actview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [actview startAnimating];
        actview.frame = CGRectMake(40,26,11,11);
        actview.tag = 2004;
        [cell addSubview:actview];
        [actview release];
    }
        
    return cell;
}

#pragma mark - UITableViewCell create methods
- (UITableViewCell*) tableView:(UITableView*)tableView cellOfP2PReceiveMsg:(IMMsg*)msg
{
    UITableViewCell *cell = nil;
    if (msg.msgtype == 0) //receive text message
    {
        UILabel *contentLabel = nil;
        UILabel *timeLabel = nil;
        UIImageView *talkBgView = nil;
        static NSString* cellid = @"im_text_r_message_cell_id";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *talkBg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"talk_box_bg.png"] stretchableImageWithLeftCapWidth:100.0f topCapHeight:30.0f]];
            talkBg.frame = CGRectMake(85.0f, 10.0f, 10.0f, 10.0f);
            [cell addSubview:talkBg];
            talkBg.tag = 1003;
            talkBgView = talkBg;
            [talkBg release];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.tag = 1001;
            label1.font = [UIFont systemFontOfSize:R_CONTENT_FONT_SIZE];
            contentLabel = label1;
            contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            contentLabel.numberOfLines = 10;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = [UIColor grayColor];
            label2.tag = 1002;
            timeLabel = label2;
            label2.backgroundColor = [UIColor clearColor];
            timeLabel.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:label2];
            [label2 release];
        }
        else
        {
            contentLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
            talkBgView = (UIImageView *)[cell viewWithTag:1003];
        }
        
        CGSize size = [msg.content sizeWithFont:[UIFont systemFontOfSize:R_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(R_CONTENT_WIDTH, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        if (size.width < 130)
        {
            size.width = 130;
        }
        CGRect bgFrame = talkBgView.frame;
        bgFrame.size.height = size.height + 30.0f;
        bgFrame.size.width = size.width+10.0f;
        talkBgView.frame = bgFrame;
        
        contentLabel.frame = CGRectMake(90.0f, 15.0f, size.width, size.height);
        contentLabel.text = msg.content;
        
        timeLabel.frame = CGRectMake(90.0f, 27.0f+size.height, 160.0f, 10.0f);
//        timeLabel.text = msg.date;
        
        timeLabel.text = [self dateStr:msg.date];
    }
    else if (msg.msgtype == 1)//receive attach message
    {
        UILabel *contentLabel = nil;
        UILabel *timeLabel = nil;
        static NSString* cellid = @"im_attach_r_message_cell_id";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *talkBg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"talk_box_bg.png"] stretchableImageWithLeftCapWidth:100.0f topCapHeight:30.0f]];
            talkBg.frame = CGRectMake(85.0f, 10.0f, 231.0f, 60.0f);
            [cell addSubview:talkBg];
            [talkBg release];
            
            UIImageView *attachImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"talk_box_file_icon.png"]];
            attachImg.frame = CGRectMake(90.0f, 15.0f, 19.0f, 18.0f);
            [cell addSubview:attachImg];
            [attachImg release];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.tag = 1001;
            label1.font = [UIFont systemFontOfSize:R_CONTENT_FONT_SIZE];
            contentLabel = label1;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = [UIColor grayColor];
            label2.tag = 1002;
            timeLabel = label2;
            label2.backgroundColor = [UIColor clearColor];
            timeLabel.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:label2];
            [label2 release];
        }
        else
        {
            contentLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
        }
        
        NSString *file =[msg.content lastPathComponent];
        
        contentLabel.frame = CGRectMake(105.0f, 15.0f, 190.0f, 18.0f);
        contentLabel.text = file;
        
        timeLabel.frame = CGRectMake(110.0f, 12.0f+40.0f, 160.0f, 10.0f);
//        timeLabel.text = msg.date;
        timeLabel.text = [self dateStr:msg.date];
    }
    else
    {
        cell =  [self getVoiceCellWithTable:tableView andCell:cell andMsg: msg andType:0];
    }
    return cell;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellOfGroupReceiveMsg:(IMMsg*)msg
{
    UITableViewCell *cell = nil;
    if (msg.msgtype == 0) //receive text message
    {
        UILabel *contentLabel = nil;
        UILabel *nameLabel = nil;
        UILabel *timeLabel = nil;
        UIImageView *talkBgView = nil;
        static NSString* cellid = @"im_text_r_message_cell_id_g";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
                        
            UIImageView *talkBg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"talk_box_bg.png"] stretchableImageWithLeftCapWidth:100.0f topCapHeight:30.0f]];
            talkBg.frame = CGRectMake(85.0f, 10.0f, 10.0f, 10.0f);
            [cell addSubview:talkBg];
            talkBg.tag = 1003;
            talkBgView = talkBg;
            [talkBg release];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.tag = 1001;
            label1.font = [UIFont systemFontOfSize:R_CONTENT_FONT_SIZE];
            contentLabel = label1;
            contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            contentLabel.numberOfLines = 10;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = [UIColor grayColor];
            label2.tag = 1002;
            timeLabel = label2;
            label2.backgroundColor = [UIColor clearColor];
            timeLabel.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:label2];
            [label2 release];
        }
        else
        {
            contentLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
            talkBgView = (UIImageView *)[cell viewWithTag:1003];
            nameLabel = (UILabel *)[cell viewWithTag:1000];
        }
        
        CGSize size = [msg.content sizeWithFont:[UIFont systemFontOfSize:R_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(R_CONTENT_WIDTH, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        if (size.width < 130)
        {
            size.width = 130;
        }
        CGRect bgFrame = talkBgView.frame;
        bgFrame.size.height = size.height + 30.0f;
        bgFrame.size.width = size.width+10.0f;
        talkBgView.frame = bgFrame;
        
        contentLabel.frame = CGRectMake(90.0f, 15.0f, size.width, size.height);
        contentLabel.text = msg.content;
        
        timeLabel.frame = CGRectMake(91.5f, 27.0f+size.height, 160.0f, 10.0f);
//        timeLabel.text = msg.date;
        timeLabel.text = [self dateStr:msg.date];
        
        nameLabel.text = msg.sender.length>3?([msg.sender substringFromIndex:msg.sender.length-3]):(msg.sender);
    }
    else if (msg.msgtype == 1)//receive attach message
    {
        UILabel *contentLabel = nil;
        UILabel *timeLabel = nil;
        UILabel *nameLabel = nil;
        static NSString* cellid = @"im_attach_r_message_cell_id_g";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            for (UIView *view in cell.subviews)
            {
                [view removeFromSuperview];
            }
            
            UIImageView *talkBg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"talk_box_bg.png"] stretchableImageWithLeftCapWidth:100.0f topCapHeight:30.0f]];
            talkBg.frame = CGRectMake(85.0f, 10.0f, 231.0f, 60.0f);
            [cell addSubview:talkBg];
            [talkBg release];
            
            UIImageView *attachImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"talk_box_file_icon.png"]];
            attachImg.frame = CGRectMake(90.0f, 15.0f, 19.0f, 18.0f);
            [cell addSubview:attachImg];
            [attachImg release];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.tag = 1001;
            label1.font = [UIFont systemFontOfSize:R_CONTENT_FONT_SIZE];
            contentLabel = label1;
            [cell addSubview:label1];
            label1.textColor = [UIColor grayColor];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = [UIColor grayColor];
            label2.tag = 1002;
            timeLabel = label2;
            label2.backgroundColor = [UIColor clearColor];
            timeLabel.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:label2];
            [label2 release];
        }
        else
        {
            contentLabel = (UILabel *)[cell viewWithTag:1001];
            timeLabel = (UILabel *)[cell viewWithTag:1002];
        }
        
        NSString *file =[msg.content lastPathComponent];
        contentLabel.frame = CGRectMake(105.0f, 15.0f, 190.0f, 18.0f);
        contentLabel.text = file;
        
        timeLabel.frame = CGRectMake(110.0f, 12.0f+40.0f, 160.0f, 10.0f);
        
//        timeLabel.text = msg.date;
        timeLabel.text = [self dateStr:msg.date];
        
        nameLabel.text = msg.sender.length>3?([msg.sender substringFromIndex:msg.sender.length-3]):(msg.sender);
    }
    else if (msg.msgtype == 3)
    {
       cell = [self getVoiceCellWithTable:tableView andCell:cell andMsg: msg andType:0];
    }
    
    return cell;
}

- (UITableViewCell*) getVoiceCellWithTable:(UITableView*)tableView andCell:(UITableViewCell*)cell andMsg:(IMMsg*) msg andType:(int) type
{
    static NSString* cellid = @"im_voice_message_cell_id_g";
    cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    
    for (UIView *view in cell.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIImage *image_in1;
    UIImage *image_in2;
    UIImage *image_in3;
    UIImage *image_in4;
    int x = 0;
    int x2 = 0;
    int x3 = 0;
    int tag = 1002;
    int x4 = 0;
    BOOL isOut = NO;
    double duration = msg.duration;
    int width = 82+ 148 * (duration/ 1000.f / 60.f);
    CGRect TimeRect = CGRectMake(110.0f, 61.f, 160.0f, 10.0f);
    if (msg.imState <=1)
    {
        image_in1 = [UIImage imageNamed:@"message01.png"];
        image_in2 = [image_in1 stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        image_in3 = [UIImage imageNamed:@"message01_on.png"];
        image_in4 = [image_in3 stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        x = 320 - width - 45 - 20;
        x2 = 215;
        x3 = x+9;
        x4 = x2 - 60;
        isOut = YES;
    }
    else
    {
        image_in1 = [UIImage imageNamed:@"message02.png"];
        image_in2 = [image_in1 stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        image_in3 = [UIImage imageNamed:@"message02_on.png"];
        image_in4 = [image_in3 stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        x = 65;
        x2 = 90;
        x3 = x + width - 9;
        x4 = x2 + 22;
        tag = 1003;
        TimeRect = CGRectMake(90.0f, 61.f , 160.0f, 10.0f);
    }
    
    UIButton *ivb = [UIButton buttonWithType:UIButtonTypeCustom];
    ivb.frame = CGRectMake(x, 12, width, 45);
    [ivb setBackgroundImage:image_in2 forState:(UIControlStateNormal)];
    [ivb setBackgroundImage:image_in4 forState:(UIControlStateHighlighted)];
    [ivb addTarget:self action:@selector(playVoiceMsg:) forControlEvents:(UIControlEventTouchDown)];
    ivb.tag = tag;
    [cell addSubview:ivb];
    
    
    UIImageView* ivPlay= [[UIImageView alloc] initWithFrame:CGRectMake(x2, 22, 16, 24)];
    if (isOut)
    {
        ivPlay.animationImages=[NSArray arrayWithObjects:
                                [UIImage imageNamed:@"voice_to_playing_s0.png"],
                                [UIImage imageNamed:@"voice_to_playing_s1.png"],
                                [UIImage imageNamed:@"voice_to_playing_s2.png"],
                                [UIImage imageNamed:@"voice_to_playing_s3.png"],nil ];
        [ivPlay setImage:[UIImage imageNamed:@"voice_to_playing_s0.png"]];
    }
    else
    {
        ivPlay.animationImages=[NSArray arrayWithObjects:
                                [UIImage imageNamed:@"voice_from_playing_s0.png"],
                                [UIImage imageNamed:@"voice_from_playing_s1.png"],
                                [UIImage imageNamed:@"voice_from_playing_s2.png"],
                                [UIImage imageNamed:@"voice_from_playing_s3.png"],nil ];
        [ivPlay setImage:[UIImage imageNamed:@"voice_from_playing_s0.png"]];
    }
    
    //设定动画的播放时间
    ivPlay.animationDuration=.7;
    //设定重复播放次数
    ivPlay.animationRepeatCount=100000;
    [cell addSubview:ivPlay];
    ivPlay.tag = 1005;
    [ivPlay release];    
    

    UILabel* lbTime = [[UILabel alloc] initWithFrame:TimeRect];
//    lbTime.text  = msg.date;
    lbTime.text = [self dateStr:msg.date];
    
    lbTime.textAlignment = UITextAlignmentLeft;
    lbTime.font = [UIFont systemFontOfSize:13];
    lbTime.backgroundColor = [UIColor clearColor];
    lbTime.textColor = [UIColor grayColor];
    lbTime.tag = 1001;
    [cell addSubview:lbTime];
    [lbTime release];
    
    UILabel* lbduration = [[UILabel alloc] initWithFrame:CGRectMake(x4, 25, 60, 17)];
    lbduration.text  = [NSString stringWithFormat:@"%d\" ",(int)(duration / 1000.f)];
    if (isOut)
    {
        lbduration.textAlignment = UITextAlignmentRight;
    }
    else
        lbduration.textAlignment = UITextAlignmentLeft;
    lbduration.font = [UIFont systemFontOfSize:15];
    lbduration.backgroundColor = [UIColor clearColor];
    lbduration.textColor = [UIColor grayColor];
    lbduration.tag = 1001;
    [cell addSubview:lbduration];
    [lbduration release];
    return cell;
}

#pragma mark - UIDelegate
- (void)responseMessageStatus:(EMessageStatusResult)event callNumber:(NSString *)callNumber data:(NSString *)data
{
    switch (event)
	{
        case EMessageStatus_Received:
        {
            self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
            [self.table reloadData];
             [self.table scrollRectToVisible:CGRectMake(0, self.table.contentSize.height-15, self.table.contentSize.width, 10) animated:YES];
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
            self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
            [self.table reloadData];
            [self.table scrollRectToVisible:CGRectMake(0, self.table.contentSize.height-15, self.table.contentSize.width, 10) animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void) onSendInstanceMessageWithReason: (NSInteger) reason andMsg:(InstanceMsg*) data
{
    if (reason == ERROR_FILE)
    {
        [self  popPromptViewWithMsg:@"发送的文件过大，不能发送超过限制大小的文件！" AndFrame:CGRectMake(0, 160, 320, 30)];
        return;
    }
    else if (reason == EUploadFailedTimeIsShort)
    {
        [self  popPromptViewWithMsg:@"语音过短，发送失败！" AndFrame:CGRectMake(0, 160, 320, 30)];
        return;
    }
    else if (reason == EUploadFailedTimeIsShort)
    {
        [self  popPromptViewWithMsg:@"语音过短，发送失败！" AndFrame:CGRectMake(0, 160, 320, 30)];
        return;
    }
    else if (reason == EUploadCancel)//用户取消上传
    {
        return;
    }
    else if (reason == 110138 )
    {
        [self  popPromptViewWithMsg:@"你已经被管理员禁言！" AndFrame:CGRectMake(0, 160, 320, 30)];
    }
//    else if (reason != 0 )
//    {        
//        return;
//    }
    
    if ([data isKindOfClass:[IMAttachedMsg class]])
    {
        IMAttachedMsg *msg = (IMAttachedMsg*)data;
        NSInteger count = [self.modelEngineVoip.imDBAccess getCountOfmsgid:msg.msgId];
        if (count > 0)
        {
            NSInteger imstate = 1;
            if (reason == 0)
                imstate = 0;
            
            [self.modelEngineVoip.imDBAccess updateimState:imstate OfmsgId:msg.msgId];
        }
        else
        {
            IMMsg* imMsg = [[IMMsg alloc] init];
            imMsg.content = msg.fileUrl;
            imMsg.someone = self.receiver;
            //self.title 有可能是群名，有可能是联系人
            imMsg.userData = self.userdata;
//            imMsg.userData = self.title;
            imMsg.loginName = self.loginName;
            if (reason == 0)
                imMsg.imState = 0;
            else
                imMsg.imState = 1;
            
            if ([msg.ext isEqualToString:@"amr"])
            {
                imMsg.msgtype = 3;
                imMsg.duration = [self.modelEngineVoip getVoiceDuration:msg.fileUrl];
            }
            else
            {
                imMsg.msgtype = 1;
            }
            imMsg.isRead = 1;
            NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *curTimeStr = [dateformatter stringFromDate:[NSDate date]];
            [dateformatter release];
            imMsg.date = curTimeStr;
            
            [self.modelEngineVoip.imDBAccess addNewIM:imMsg];
            [imMsg release];
        }
        
        self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
        [self.table reloadData];
        
        if([self.chatArray count]>0)
            [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else if ([data isKindOfClass:[IMTextMsg class]])
    {
        //报告发送状态
        IMTextMsg *msg = (IMTextMsg*)data;
        NSInteger status = [msg.status integerValue];
        NSInteger imStatus = 0;
        if (status == -1)
        {
            imStatus = 1;
        }
        else if(status == 0)
        {
            imStatus = 0;
        }
        else if(status == 1)
        {
            imStatus = 5;
        }
        NSLog(@"reason=%d,状态报告=%d",reason,status);
        [self.modelEngineVoip.imDBAccess updateimState:imStatus OfmsgId:msg.msgId];
        self.chatArray = [self.modelEngineVoip.imDBAccess getIMOfSomeone:self.receiver];
        [self.table reloadData];
    }
}

-(void)touchOutside
{
    isOutside = YES;
}

-(void)touchInside
{
    isOutside = NO;
}

-(void)setButtonState:(BOOL) on
{
    if (on) {
        [voiceBtn setBackgroundImage:[UIImage imageNamed:@"voice_icon_on.png"] forState:UIControlStateNormal];
        [voiceBtn setBackgroundImage:[UIImage imageNamed:@"voice_icon_on.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [voiceBtn setBackgroundImage:[UIImage imageNamed:@"IM_voice_icon.png"] forState:UIControlStateNormal];
        [voiceBtn setBackgroundImage:[UIImage imageNamed:@"IM_voice_icon.png"] forState:UIControlStateHighlighted];
    }

}
#pragma mark - modelEngineVoip function

//开始录音
-(void)record:(id)sender
{
    if (recordState != 0)
    {
        return;
    }
    recordState = 1;
    if ( self.recordTimer)
    {
        [self.recordTimer invalidate];
        self.recordTimer = nil;
    }
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(startRecording) userInfo:nil repeats:NO];
}

-(void)startRecording
{
    if (recordState != 1)
    {
        return;
    }
    [self setButtonState:YES];
    recordState = 2;
    [self stopRecMsg];
    self.curRecordFile = [self createFileName];
    NSString* filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:self.curRecordFile];
    self.popView.hidden = NO;
    if (self.containerView.frame.origin.y == (self.view.frame.size.height-30.0f-45.0f + 30)) {
        self.popView.frame = CGRectMake(90, self.view.frame.size.height-35.0f-40.0f- 200, 139, 139);
    }else {
        self.popView.frame = CGRectMake(90, self.containerView.frame.origin.y - 120, 139, 139);
    }

    self.ivPopImg.image = [self.imgArray objectAtIndex:0];
    [self.view bringSubviewToFront:self.popView];
    
    [self getLoginName];
    
    [self.modelEngineVoip startVoiceRecordingWithReceiver:self.receiver andPath:filePath andChunked:YES andUserdata:self.loginName];
    
    //老师语音积分
    [self teacherIntegral];
}

//录音取消
-(void)recordCancel:(id)sender
{
    if (recordState != 2)
    {
        recordState = 0;
        return;
    }
    [self setButtonState:NO];
    self.popView.hidden = YES;
    isRecording = NO;
    [self.modelEngineVoip cancelVoiceRecording];
    recordState = 0;
    if (isTimeOut)
    {
        isTimeOut = NO;
    }
}

//停止录音
-(void)stopRecording:(id)sender
{
    if (recordState != 2)
    {
        recordState = 0;
        return;
    }
    [self setButtonState:NO];
    self.popView.hidden = YES;
    isRecording = NO;
    [self stop];
    recordState = 0;
    if (isTimeOut)
    {
        isTimeOut = NO;
        return;
    }
}

//调用底层的停止录音
-(void)stop
{
    [self.modelEngineVoip stopCurRecording];
}

//根据一定规则生成文件不重复的文件名
- (NSString *)createFileName
{
    static int seedNum = 0;
    if(seedNum >= 1000)
        seedNum = 0;
    seedNum++;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSString *file = [NSString stringWithFormat:@"tmp%@%03d.amr", currentDateStr, seedNum];
    return file;
}

//停止放音
-(void)stopRecMsg
{
    isPlaying = NO;
    [self.curImg stopAnimating];
    [self.modelEngineVoip stopVoiceMsg];
}

//播放当前点击的语音
-(void)playVoiceMsg:(id)sender
{
    if (isRecording)
    {
        return;
    }
    [self stopAnimation];
    self.curImg = nil;
    UITableViewCell* cell = (UITableViewCell*)[sender superview];
    self.curImg = (UIImageView*)[cell viewWithTag:1005];
    int i = [self.table indexPathForCell:cell].row;
    IMMsg *msg = [self.chatArray objectAtIndex:i];
    
    NSString* strFileName = msg.content;    
    if (isPlaying && [msg.data isEqualToString:self.curVoiceSid])
    {
        [self stopRecMsg];
        return;
    }
    self.curVoiceSid = msg.data;
    [self playRecMsg:strFileName];
}

//根据传入的文件名播放语音
-(void)playRecMsg:(NSString*) fileName
{
    isPlaying = YES;
    [self.curImg startAnimating];
    [self.modelEngineVoip playVoiceMsg:fileName];
}

//停止播放语音的动画效果
-(void)stopAnimation
{
    if (self.curImg)
    {
        [self.curImg stopAnimating];
    }
}

#pragma mark - VoipModelEngine Delegate

-(void)responseFinishedPlaying
{
    isPlaying = NO;
    [self stopAnimation];
}

//录音超时
-(void)responseRecordingTimeOut:(int) ms
{
    isTimeOut = YES;
    isRecording = NO;
    [self popPromptViewWithMsg:[NSString stringWithFormat: @"语音超时，已达到最大时长%d秒，即将自动进行发送",ms/1000] AndFrame:CGRectMake(0, 160, 320, 30)];
    self.popView.hidden = YES;
    [self stop];
}

//下载完成后的回调
-(void)responseDownLoadMessageStatus:(int)event;
{
    switch (event)
	{
        case 0:
        {
            //[self updateVoiceMsgArray];
        }
            break;
        default:
            break;
    }
}

//上传录音时声音振幅的回调
-(void)responseRecordingAmplitude:(double) amplitude
{
    if (isOutside)
    {
        self.ivPopImg.image = [UIImage imageNamed:@"message_interphone_bg_off.png"];
        return;
    }
    int iAmplitude = 1;
    
    if (amplitude > .76)
    {
        iAmplitude = 6;
    }
    else if (amplitude > .52)
    {
        iAmplitude = 5;
    }
    else if (amplitude > .37)
    {
        iAmplitude = 4;
    }
    else if (amplitude > .27)
    {
        iAmplitude = 3;
    }
    else if (amplitude > .17)
    {
        iAmplitude = 2;
    }
    
    self.ivPopImg.image = [self.imgArray objectAtIndex:iAmplitude-1];
}

//群名
-(void)onGroupQueryGroupWithReason:(NSInteger)reason andGroup:(IMGroup *)group
{
    if (reason == 0)
    {
        self.title = group.name;
        NSString *strVoipAccount = [self getName];
        //群名，获取登录的姓名
        self.loginName = [NSString stringWithFormat:@"%@,%@",group.name,strVoipAccount];
        self.userdata = group.name;

    }
}

@end
