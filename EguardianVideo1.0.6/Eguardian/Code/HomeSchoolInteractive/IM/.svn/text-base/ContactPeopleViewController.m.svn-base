//
//  ContactPeopleViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ContactPeopleViewController.h"
#import "NSDictionary+Extemsions.h"
#import "ConfigManager.h"
#import "CommonTools.h"
#import "CheckWorkCell.h"
#import "StringExpand.h"
#import "SendIMViewController.h"
#import "AccountInfo.h"
#import "GroupListViewController.h"

#define MainTableViewTag 1000
#define popupTableViewTag 1001
#define BottonViewTag 2000
#define contentLbFont 16
#define NoneNumberViewTag 7000

@interface ContactPeopleViewController ()

@end

@implementation ContactPeopleViewController

@synthesize classList;
@synthesize titleView;
@synthesize popupTableView;
@synthesize studentList;
@synthesize mainTableView;
@synthesize groupId;
@synthesize groupIDName;
@synthesize accountsArray;
@synthesize backView;
@synthesize connectInfo;

- (void)dealloc
{
    [mainTableView release];
    [classList release];
    [titleView release];
    [popupTableView release];
    [studentList release];
    [groupId release];
    [groupIDName release];
    [accountsArray release];
    [connectInfo release];
    backView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationContactPeople object:nil];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    cellBtnCount = 0;
    studentList = [[NSMutableArray alloc] init];
    
    [self initView];
    
    [self netWorkgOfGradeClass];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationContactPeople:) name:NotificationContactPeople object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     self.modelEngineVoip.UIDelegate = self;
}

- (void)initView{
    //定制返回按钮
    
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
    
    {
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,320, self.viewHeight - 44 - 50) style:UITableViewStylePlain];
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.rowHeight = 48;
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.allowsSelection = NO;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.tag = MainTableViewTag;
        [self.view addSubview:mainTableView];
    }
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"群组" target:self action:@selector(goToGroupView)]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [rightBarItem release];
    
}

//群组
- (void)goToGroupView
{
    GroupListViewController *view = [[GroupListViewController alloc] init];
    view.backView = backView;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}


- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//增加底部
- (void)addBottomView {
    BottonView *bottonView = (BottonView *)[self.view viewWithTag:BottonViewTag];
    if(!bottonView){
        bottonView = [[BottonView alloc] initWithFrame:CGRectMake(0, self.viewHeight - 50, 320, 0) ID:self];
        bottonView.tag = BottonViewTag;
        [self.view addSubview:bottonView];
        [self animationBottonView];
    }
}

//底部的动态效果
- (void)animationBottonView{
    BottonView *bottonView = (BottonView *)[self.view viewWithTag:BottonViewTag];
    [UIView beginAnimations:@"View" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (bottonView.frame.origin.y == self.viewHeight - 50) {
        bottonView.frame = CGRectMake(0, self.viewHeight - 44 - 50, 320, 50);
    }else{
        bottonView.frame = CGRectMake(0, self.viewHeight - 50 , 320, 0);
    }
    
    [UIView commitAnimations];
}

//获取被选择的人数
- (NSInteger)getStudentListSelectCount{
    NSInteger count = 0;
    NSMutableString *nameStr = [[NSMutableString alloc] init];
    for (NSDictionary *oneStudentDic in studentList) {
        if ([[oneStudentDic objectForKey:@"Select"] boolValue]) {
            if (count == 0) {
                [nameStr appendString:[oneStudentDic objectJudgeFullForKey:@"sname"]];
            }else if(count < 3) {
                [nameStr appendString:[NSString stringWithFormat:@"、%@",[oneStudentDic objectJudgeFullForKey:@"sname"]]];
            }
            count ++;
        }
    }
    self.groupIDName = nameStr;
    [nameStr release];
    return count;
}

//获取被选择的数组
- (NSMutableArray *)getStudentListSelect{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *oneStudentDic in studentList) {
        if ([[oneStudentDic objectForKey:@"Select"] boolValue]) {
            [array addObject:oneStudentDic];
        }
    }
    return array;
}

//判断是否全选
- (BOOL) judgeAllselect{
    BOOL b = YES;
    for (NSDictionary *oneStudentDic in studentList) {
        if (![[oneStudentDic objectForKey:@"Select"] boolValue]) {
            return NO;
        }
    }
    if (b) {
        isAllSelect = YES;
    }
    
    return b;
}

//三角行的点击事件
- (void)trianglePressedBtn{
    
    triangle180 = !triangle180;
    if (triangle180) {
        //弹框
        if (popup == nil) {
            if ([classList count] > 0) {
                [self initContenViewWithMode:SNPopupViewBarLeftItem];
                popup = [[SNPopupView alloc] initWithPopupViewModel:SNPopupViewBarLeftItem ContentView:popupTableView Rect:CGRectMake(0, 0, 150, popupHeight ) stretCapWidth: 58 View:self.view];
                popup.delegate = self;
            }
        }
        [popup presentModal];
        
    }else {
        [popup dismissModal];
    }
    
    //三角行旋转
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(endAnimation)];
        titleView.mBtn.transform = CGAffineTransformMakeRotation(M_PI * (triangle180? -1:0) );
        //        btn.layer.transform = CATransform3DMakeRotation (M_PI , 0, 0, 1);  //顺时针旋转
        [UIView commitAnimations];
    }
    
}

- (void)showNoneNumberView{
    UILabel *l = (UILabel *)[self.view viewWithTag:NoneNumberViewTag];
    if (!l) {
        l = [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 200.0f, 300.0f, 25.0f)] autorelease];
        l.text = @"此班级暂无学生";
        [self.view addSubview:l];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor blackColor];
        l.tag = NoneNumberViewTag;
        l.backgroundColor = [UIColor clearColor];
    }
    l.hidden = NO;
    [self.view bringSubviewToFront:l];
}

- (void)hiddenNoneNumberView{
    UILabel *l = (UILabel *)[self.view viewWithTag:NoneNumberViewTag];
    if (l) {
        l.hidden = YES;
    }
}

#pragma mark 底部按钮 （提交）
- (void)bottonViewPressedBtn{
    if ([studentList count] > 0) {
         NSInteger count = [self getStudentListSelectCount];
        
        if (count == 0) {
            [self  popPromptViewWithMsg:@"请选择学生或班级" AndFrame:CGRectMake(0, 160, 320, 30)];
            return;
        }
        
        [self addClearColorPartView];
        //如果是一个人单聊
        if (count == 1) {
            
            [self networkOfAccountInfo];
            
        }
        //多人群聊
        else {
            [self addClearColorPartView];
            
            //全选情况下
            if ([self judgeAllselect]) {
                
                [self networkOfCreateGroupName];
                
            }else {
                
                //创建群名 群步骤3
                [DELEGATE.modeEngineVoip createGroupWithName:groupIDName andType:@"0" andDeclared:nil andPermission:0];
            }
        }
    }
}

#pragma mark 头部的右边按钮
-(void)rightAction{
    isAllSelect = !isAllSelect;
    for (NSMutableDictionary *dic in studentList) {
        [dic setObject:[NSNumber numberWithBool:isAllSelect] forKey:@"Select"];
    }
    
    [mainTableView reloadData];
    if (triangle180) {
        [self trianglePressedBtn];
    }

}

//- (void)save:(NSDictionary *)dic{
//    @try {
//        InfoStudent *info = [[InfoStudent alloc] init];
//        info.schoolid = [[dic objectForKey:@"schoolid"] integerValue];
//        info.classid = [[dic objectForKey:@"classid"] integerValue];
//        info.gradeid = [[dic objectForKey:@"gradeid"] integerValue];
//        info.groupVoipAccount = self.groupId ;
//        NSArray *array = [self.modelEngineVoip.imDBAccess searchInfoName:info.sname] ;
//        if ( array != nil && [array count] == 0) {
//            [self.modelEngineVoip.imDBAccess insertInfoTable:info];
//        }
//        [info release];
//        
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Exception name=%@",exception.name);
//        NSLog(@"Exception reason=%@",exception.reason);
//    }
//    @finally {
//    }
//}

#pragma mark 网张请求
//    步骤1 获取班级
- (void)netWorkgOfGradeClass{
    
    NSString *tempURL = [ConfigManager getGradeClass];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:tempURL];
    [request setURL:url];
    
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *temdata, NSError *error) {
                               
                               if (error)
                               {
                                   self.activityView.hidden = YES;
                                   [self.activityView stopAnimating];
//                                   [super showError];
                                    [self  popPromptViewWithMsg:@"网络数据获取出错，请查看网络连接" AndFrame:CGRectMake(0, 160, 320, 30)];
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
                                   
                                   if ([classList count] > 0) {
                                       NSDictionary *tmpDic = [classList objectAtIndex:0];
                                       
                                       //                                           中间文字
                                       //字体适配高度
                                       UIFont *fon = [UIFont systemFontOfSize:NavTriangleTitle];
                                       NSString *contentStr = [tmpDic objectJudgeFullForKey:@"gradeClass"];
                                       CGSize size=[contentStr sizeWithFont:fon constrainedToSize:CGSizeMake(240, 240)];
                                       
                                       //gcg延迟几秒
                                       double delayInSeconds = 0.2;
                                       dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                       dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                           NavTriangleTitleView *view = [[NavTriangleTitleView alloc] initWithFrame:CGRectMake(0, 0, size.width + 40 + 20, 37) Delegate:self];
                                           [view addTarget:self action:@selector(trianglePressedBtn) forControlEvents:UIControlEventTouchUpInside];
                                           view.title.text = contentStr;
                                           self.titleView = view;
                                           self.navigationItem.titleView = view;
                                           [view release];
                                           popupHeight = [classList count] * 44 + 11;
                                           if (popupHeight > 210) {
                                               popupHeight = 210;
                                           }
                                           
                                           [self netWorkOfGetStudent];
                                       });
                                       
                                   }else {
                                      
                                       self.activityView.hidden = YES;
                                       [self.activityView stopAnimating];
                                       
                                   }
                                   
                               }
                           }];

}

//调用（班主任用班级id去查学生列表的）接口  步骤 2
- (void)netWorkOfGetStudent{
    [self hiddenNoneNumberView];
    NSDictionary *tmpDic = nil;
    for (NSDictionary *dic in classList) {
        NSString *tmpStr = [dic objectForKey:@"gradeClass"];
        if ([tmpStr isEqualToString:titleView.title.text]) {
            tmpDic = dic;
            break;
        }
    }
    
    id classID = [tmpDic objectForKey:@"classID"];
    id gradeID = [tmpDic objectForKey:@"gradeID"];
    if (classID && gradeID) {
        NSString *tempURL = [ConfigManager getStudentsWithGradeID:gradeID classID:classID];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        NSURL *url = [NSURL URLWithString:tempURL];
        [request setURL:url];
        
        self.activityView.hidden = NO;
        [self.view bringSubviewToFront:self.activityView];
        [self.activityView startAnimating];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *temdata, NSError *error) {
                                   
                                   if (error)
                                   {
                                       [super showError];
                                   } else {
                                       self.activityView.hidden = YES;
                                       [self.activityView stopAnimating];
                                       
                                       NSError *parseError = nil;
                                       NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:temdata options:NSJSONReadingAllowFragments error:&parseError];
                                       
                                       NSArray *array = [jsonObject objectForKey:@"content"];
                                       [studentList removeAllObjects];
                                       if ([array isKindOfClass:[NSArray class]]) {
                                           if ([array isKindOfClass:[NSArray class]]) {
                                               for (NSDictionary *dic in array) {
                                                   NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
                                                   //设置按钮的选择全为NO
                                                   [tmpDic setObject:[NSNumber numberWithBool:NO] forKey:@"Select"];
                                                   [studentList addObject:tmpDic];
                                                   [tmpDic release];
                                               }
                                               //                                           NSLog(@"%d",studentList.count);
                                               //                                           NSLog(@"%@",studentList);
                                               cellBtnCount = studentList.count + 1;
                                               [self.mainTableView reloadData];
                                               
                                               [self addBottomView];
                                           }
                                       }
                                      
                                       if ([studentList count] == 0) {
                                            [self showNoneNumberView];
                                       }
                                   }
                               }];
    }
}


//获取语音通讯的子账号(都是学生) 群步骤5
- (void)networkOfAccountInfo {
    NSString *loginKey = [ConfigManager sharedConfigManager].loginKey;
    NSMutableArray *postArray = [[NSMutableArray alloc] init];
    
    NSString *tempURL = [ConfigManager getAccountInfo];
    NSDictionary *userInfo = nil;
    
    for (NSDictionary *oneStudentDic in studentList) {
         NSMutableDictionary *postDic = nil;
        if (!isWholeClass) {
           if ([[oneStudentDic objectForKey:@"Select"] boolValue]) {
                postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"xuehao"],@"xuehao",[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"sname"],@"sname", nil];
               
            }
        }else {
            postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"xuehao"],@"xuehao",[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"sname"],@"sname", nil];
        }
        if (postDic) {
            NSError *error = nil;
            
            NSData *registerData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
            
            //json 数据
            NSString *jsonStr = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
            [postArray addObject:jsonStr];
            
            [jsonStr release];
            [postDic release];
        }
    }
    
//    if ([keys count] > 0) {
//        NSDictionary *oneStudentDic = [dic objectForKey:[keys objectAtIndex:0]];
//        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[oneStudentDic objectForKey:@"schoolid"],@"schoolid",[oneStudentDic objectForKey:@"classid"],@"classid",[oneStudentDic objectForKey:@"gradeid"],@"gradeid", nil];
//        [self save:tmpDic];
//        [tmpDic release];
//    }
    
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationContactPeople,NotificationKey, nil];
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
    //应用apikey type 老师2，学生 1
    [self formDataRequestWithURL:tempURL UserInfo:userInfo DataArray:postArray Header:headerDic Key:loginKey Type:@"1"];
    [postArray release];
}

//创建群名  群步骤3
- (void)networkOfCreateGroupName{
    self.groupIDName = [NSString stringWithFormat:@"%@(%@)",titleView.title.text,[DELEGATE getLoginName]];
    //创建群名 群步骤3
    [DELEGATE.modeEngineVoip createGroupWithName:groupIDName andType:@"0" andDeclared:nil andPermission:0];
}

#pragma mark popup
- (void)initContenViewWithMode:(SNPopupViewModel) popupViewMode {
    if (popupTableView != nil) {
        [popupTableView removeFromSuperview];
        self.popupTableView = nil;
    }
    if (popupTableView == nil) {
        popupTableView = [[UITableView alloc] initWithFrame:CGRectMake(1, 10, 150 - 2, popupHeight - 10) style:UITableViewStylePlain];
        popupTableView.tag = popupTableViewTag;
        popupTableView.backgroundColor = [UIColor clearColor];
        //        mTableView.allowsSelection = NO;
        popupTableView.showsVerticalScrollIndicator = YES;
        popupTableView.showsHorizontalScrollIndicator = YES;
        popupTableView.separatorColor = [UIColor grayColor];
        popupTableView.bounces = NO;
    }
    popupTableView.delegate = self;
    popupTableView.dataSource = self;
    //清除UITableView底部多余的分割线mTableView
    [self setExtraCellLineHidden:popupTableView];
    
}

//清除UITableView底部多余的分割线mTableView
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
    
}

//**************************************************************************************************************
//**************************************************************************************************************
#pragma mark Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (tableView.tag == popupTableViewTag) {
        count = [classList count];
    }else if(tableView.tag == MainTableViewTag){
        count = cellBtnCount%4 == 0?cellBtnCount/4:(cellBtnCount/4 + 1);
    }
	return count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = 0.0;
    if(tableView.tag == MainTableViewTag){
        height = 80;
    }else if (tableView.tag == popupTableViewTag) {
        height = 44;
    }
	return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    static NSString *CellIdentifier1 = @"CellIdentifier1";
    static NSString *CellIdentifier2 = @"CellIdentifier2";
    UITableViewCell *cell = nil;
    if (tableView.tag == popupTableViewTag) {
        cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1] autorelease];
            //背景色设置
            UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_list_middel_bar_sel"]];
            selectedBackgroundView.frame = cell.contentView.frame;
            cell.selectedBackgroundView = selectedBackgroundView;
            [selectedBackgroundView release];
        }
        NSDictionary *dic = [classList objectAtIndex:indexPath.row];
        if (dic) {
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.text = [dic objectJudgeFullForKey:@"gradeClass"];
        }
        
    }else if(tableView.tag == MainTableViewTag){
        
        cell = (CheckWorkCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if(cell == nil)
        {
            cell = [[[CheckWorkCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2 Delegate:self] autorelease ];
        }
        
        //判断cell 满4个btn
        BOOL b = (cellBtnCount % 4 == 0);
        
        int row = b ?cellBtnCount/4:(cellBtnCount/4 + 1) - 1;
        
        int count = indexPath.row  * 4;
        NSDictionary *dic = nil;
        
        //隐藏cell中的四个btn
         [((CheckWorkCell *)cell) setBtnHidden];
        
        //1列1行设置全班按钮
        if (indexPath.row == 0 ) {
            UIButton *btn = (UIButton *)[cell viewWithTag:CheckWorkCellBtnTag + 0];
            UIImage *image = [UIImage imageNamed:@"Main_Btn_Blue.png"];
            image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setTitle:@"全班" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.hidden = NO;
//            if (btn.selected) {
//                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            }else{
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            }
        }
        
        if (indexPath.row == row && !b ) {
           
            int  remainder = cellBtnCount % 4;
            for (int i = 0; i< remainder; i++) {
                
               if (!(indexPath.row == 0 && i == 0)) {
                    dic = [studentList objectAtIndex:count + i - 1];
                    UIButton *btn = (UIButton *)[cell viewWithTag:CheckWorkCellBtnTag + i];
                    [btn setTitle:[dic objectForKey:@"sname"] forState:UIControlStateNormal];
                    btn.hidden = NO;
                    btn.selected = [[dic objectForKey:@"Select"] boolValue];
                    if (btn.selected) {
                        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    }else{
                        [btn setTitleColor:Black66666 forState:UIControlStateNormal];
                    }
                   
                   UIImage *image = [UIImage imageNamed:@"whiteColor.png"];
                   [btn setBackgroundImage:image forState:UIControlStateNormal];
                   UIImage *selectImage = [UIImage imageNamed:@"redColor.png"];
                   [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
                }
               
            }
        }else {
            for (int i = 0; i< 4; i++) {
                 if (!(indexPath.row == 0 && i == 0)) {
                    dic = [studentList objectAtIndex:count + i - 1];
                    UIButton *btn = (UIButton *)[cell viewWithTag:CheckWorkCellBtnTag + i];
                    [btn setTitle:[dic objectForKey:@"sname"] forState:UIControlStateNormal];
                    btn.hidden = NO;
                    btn.selected = [[dic objectForKey:@"Select"] boolValue];
                    if (btn.selected) {
                        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    }else{
                        [btn setTitleColor:Black66666 forState:UIControlStateNormal];
                        
                    }
                     UIImage *image = [UIImage imageNamed:@"whiteColor.png"];
                     [btn setBackgroundImage:image forState:UIControlStateNormal];
                     UIImage *selectImage = [UIImage imageNamed:@"redColor.png"];
                     [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
                }
                
            }
        }
        
    }
    
    return cell;
}

#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    if (atableView.tag == popupTableViewTag) {
        NSDictionary *dic = [classList objectAtIndex:indexPath.row];
        if (dic) {
            titleView.title.text =  [dic objectJudgeFullForKey:@"gradeClass"];
        }
        [studentList removeAllObjects];
        cellBtnCount = 0;
        [self trianglePressedBtn];
        
        [studentList removeAllObjects];
        [mainTableView reloadData];
        [self netWorkOfGetStudent];
        
    }
}

//点击按钮
- (void)pressedButton:(UIButton *)btn forEvent:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchePointion = [touch locationInView:mainTableView];
    NSIndexPath *indexPath = [mainTableView indexPathForRowAtPoint:currentTouchePointion];
    NSInteger count = indexPath.row * 4 + (btn.tag - CheckWorkCellBtnTag);
    
    //点击全班
    if (indexPath.row == 0 && count == 0) {
        [self addClearColorPartView];
        
        isWholeClass = YES;
        [self networkOfCreateGroupName];
    }
    
    else {
        NSMutableDictionary *dic = [studentList objectAtIndex:count - 1];
        [dic setObject:[NSNumber numberWithBool:!btn.selected] forKey:@"Select"];
        
        [mainTableView reloadData];
        if (triangle180) {
            [self trianglePressedBtn];
        }
        
        [self judgeAllselect];
    
    }
    
}

- (void)didDismissModal:(SNPopupView*)popupview {
	if (popupview == popup) {
        // [contentView removeFromSuperview];
        [popupTableView release];
        popupTableView = nil;
        [popup release];
		popup = nil;
	}
}

#pragma mark -
#pragma mark 提交返回
- (void)notificationContactPeople:(NSNotification*) notification{
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    @try{
        if (notification.userInfo) {
            if ([[notification.userInfo objectJudgeFullForKey:@"status"] isEqualToString:@"ok"] || [[notification.userInfo objectJudgeFullForKey:@"status"] isEqualToString:@"1"] ) {
                NSMutableArray *voipIdArray = [[NSMutableArray alloc] init];
                NSArray *array = [notification.userInfo objectForKey:@"account"];
                self.accountsArray = array;
                for (NSDictionary *subaccountInfo in array) {
                    [voipIdArray addObject:[subaccountInfo objectForKey:@"voipAccount"]];
                }
                
                //        如果== 1则单聊，>1群聊
                if ([voipIdArray count] == 1) {
                    NSMutableArray *studentListSelect = [self getStudentListSelect];
                    
                    //查看是否是1个
                    if ([studentListSelect count] == 1 || isWholeClass == YES) {
                        if (isWholeClass == YES) {
                            self.connectInfo = [studentList objectAtIndex:0];
                        }else {
                            self.connectInfo = [studentListSelect objectAtIndex:0];
                        }
                        
                        NSDictionary *subaccountInfo = [accountsArray objectAtIndex:0];
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
                            
                            imdetailView.backView = backView;
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
                    isWholeClass = NO;
                }
                //        群聊
                else if ([voipIdArray count] > 1) {
                    //群组添加子账号 群步骤6
                    [self.modelEngineVoip inviteJoinGroupWithGroupId:groupId andMembers:voipIdArray andDeclared: nil andConfirm:1];
                    isWholeClass = NO;
                }
                [voipIdArray release];
            }
        }else {
            [self  popPromptViewWithMsg:@"网络数据获取出错，请查看网络连接" AndFrame:CGRectMake(0, 160, 320, 30)];
            [self removeClearColorPartView];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
 
}

//创建群名成功返回
-(void)onGroupCreateGroupWithReason:(NSInteger)reason andGroupId:(NSString *)aGroupId
{
    [self dismissProgressingView];
    if (reason == 0)
    {
        self.groupId = aGroupId;
        [self goToSelectMembersViewWithGroupId:aGroupId];
        
        [self networkOfAccountInfo];
    }
    else
    {
        [self  popPromptViewWithMsg:@"创建群组失败，请稍后再试！" AndFrame:CGRectMake(0, 160, 320, 30)];
         [self removeClearColorPartView];
    }
}
//创建群组成功跳转选择联系人页面 群步骤4
- (void)goToSelectMembersViewWithGroupId:(NSString*)aGroupId
{
    //成功后修改名片
    IMGruopCard* groupCard = [[IMGruopCard alloc] init];
    groupCard.belong = aGroupId;
    groupCard.display = [DELEGATE getLoginName];
    [self.modelEngineVoip modifyGroupCard:groupCard];
    [groupCard release];
}

//添加成员子账号成功返回 群步骤7
- (void) onGroupInviteJoinGroupWithReason:(NSInteger)reason
{
    if (reason == 0) {
        if (self.accountsArray) {
            for (NSDictionary *dic in self.accountsArray) {
                //成功后修改名片 群成员的名片
                IMGruopCard* groupCard = [[IMGruopCard alloc] init];
                groupCard.belong = self.groupId;
                groupCard.display =  [dic objectForKey:@"sname"];
//                NSLog(@"groupCard.display = %@",groupCard.display);
                
                id voipAccount = [dic objectForKey:@"voipAccount"];
                if ([voipAccount isKindOfClass:[NSString class]]) {
                    groupCard.voipAccount =  voipAccount;
                }else if ([voipAccount isKindOfClass:[NSArray class]]) {
                    if ([voipAccount count] > 0) {
                        groupCard.voipAccount =  [voipAccount objectAtIndex:0];
                    }
                }
//                NSLog(@"groupCard.voipAccount = %@,leng = %d",groupCard.voipAccount,groupCard.voipAccount.length);
                [self.modelEngineVoip modifyGroupCard:groupCard];
                [groupCard release];
            }
            
        }
        
        [self removeClearColorPartView];
        
//        跳转页面
        [self goToSendIMViewWithGroupId:groupId];
        
        [self dismissProgressingView];
    }else {
        [self  popPromptViewWithMsg:@"网络数据获取出错，请查看网络连接" AndFrame:CGRectMake(0, 160, 320, 30)];
        [self removeClearColorPartView];
    }
}

- (void)goToSendIMViewWithGroupId:(NSString*)groupid
{
    SendIMViewController *imdetailView = [[SendIMViewController alloc] initWithReceiver:groupid];
    
    if (groupIDName) {
        NSString *strVoipAccount = [DELEGATE getLoginName];
        imdetailView.loginName = [NSString stringWithFormat:@"%@,%@",groupIDName,strVoipAccount];
        imdetailView.userdata = groupIDName;

    }
    imdetailView.backView = backView;
    [self.navigationController pushViewController:imdetailView animated:YES];
    [imdetailView release];
}

@end
