//
//  TExceptionCheckWorkViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-10-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TExceptionCheckWorkViewController.h"
#import "NSDictionary+Extemsions.h"
#import "ConfigManager.h"
#import "CommonTools.h"
#import "CheckWorkCell.h"
#import "StringExpand.h"

#define MainTableViewTag 1000
#define popupTableViewTag 1001
#define BottonViewTag 2000
#define contentLbFont 15
#define NoneNumberViewTag 7000

@interface TExceptionCheckWorkViewController ()

@end

@implementation TExceptionCheckWorkViewController
@synthesize classList;
@synthesize titleView;
@synthesize popupTableView;
@synthesize studentList;
@synthesize mainTableView;
//@synthesize leftBtn;
//@synthesize rightBtn;

- (void)dealloc
{
    [mainTableView release];
    [classList release];
    [titleView release];
    [popupTableView release];
    [studentList release];
//    self.leftBtn = nil;
//    self.rightBtn = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCheckWorksubmit object:nil];
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

- (void)initView{
    //定制返回按钮
    studentList = [[NSMutableArray alloc] init];
    
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
    
//    for ( int i = 0; i< 2; i++) {
//        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        UIImage *image = nil;
//        UIImage *selectImage = nil;
//        [bt addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
//        bt.tag = i;
//        selectImage = [UIImage imageNamed:@"Main_Top_Bt.png"];
//        image = [UIImage imageNamed:@"Main_Top_Bt_S.png"];
//        if (i == 0) {
//            bt.selected = YES;
//            bt.frame = CGRectMake(0, 0  , 160, 44);
//            [bt setTitle:@"异常考勤" forState:UIControlStateNormal];
//            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            self.leftBtn = bt;
//        }else if(i == 1){
//            bt.selected = NO;
//            bt.frame = CGRectMake(160, 0  , 160, 44);
//            [bt setTitle:@"已提交" forState:UIControlStateNormal];
//            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.rightBtn = bt;
//        }
//        [bt setBackgroundImage: [image stretchableImageWithLeftCapWidth:21 topCapHeight:7] forState:UIControlStateNormal];
//        [bt setBackgroundImage: [selectImage stretchableImageWithLeftCapWidth:21 topCapHeight:7] forState:UIControlStateSelected];
//        
//       
//        [self.view addSubview:bt];
//    }
    
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

    [nameStr release];
    return count;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	 self.navigationController.navigationBarHidden = NO;
    
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCheckWorksubmit:) name:NotificationCheckWorksubmit object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    //获取班级
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
                                   [super showError];
                                   
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
                                       NavTriangleTitleView *view = [[NavTriangleTitleView alloc] initWithFrame:CGRectMake(0, 0, size.width + 40 + 20, 37) Delegate:self];
                                       [view addTarget:self action:@selector(trianglePressedBtn) forControlEvents:UIControlEventTouchUpInside];
                                       view.title.text = contentStr;
                                       self.titleView = view;
                                       self.navigationItem.titleView = view;
                                       [view release];
                                       
                                       popupHeight = [classList count] * 44 + 11;
                                       if (popupHeight > 200) {
                                           popupHeight = 200;
                                       }
                                       
                                       [self netWorkForGanger];
                                   }else {
                                       self.activityView.hidden = YES;
                                       [self.activityView stopAnimating];
                                       
                                   }
                                   
                               }
                           }];
    
}

//调用（班主任用班级id去查学生列表的）接口
- (void)netWorkForGanger{
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
    if (classID) {
        //        NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:[NSDate date]] Gradeid:[tmpDic objectForKey:@"gradeID"] Classid:classID];
        NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:[NSDate date]] Gradeid:[tmpDic objectForKey:@"gradeID"] Classid:classID];
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
                                           for (NSDictionary *dic in array) {
                                               NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
                                               //设置按钮的选择全为NO
                                               [tmpDic setObject:[NSNumber numberWithBool:NO] forKey:@"Select"];
                                               [studentList addObject:tmpDic];
                                               [tmpDic release];
                                           }
                                       }
                                       
//                                       NSLog(@"%d",studentList.count);
//                                       NSLog(@"%@",studentList);
                                       [self.mainTableView reloadData];
                                       
                                       if ([studentList count] == 0) {
                                           [self showNoneNumberView];
                                       }
                                       
                                       //右边按钮
                                       UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"全选" target:self action:@selector(rightAction)]];
                                       self.navigationItem.rightBarButtonItem = rightBarItem;
                                       [rightBarItem release];
                                       
                                       [self addBottomView];
                                   }
                               }];
    }
}

//班主任考勤提交
- (void)netWorkSubmit{
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];

    NSString *loginKey = [ConfigManager sharedConfigManager].loginKey;
    NSMutableArray *postArray = [[NSMutableArray alloc] init];
    
    NSString *tempURL = [ConfigManager getcheckWorksubmit];
    NSDictionary *userInfo = nil;
    
    id schoolID = nil;
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        NSArray *array = (NSArray *)[[NSUserDefaults standardUserDefaults]objectForKey:User_LoginedUsers_Teachers];
        if ([array count] > 0 ) {
            schoolID = [[array objectAtIndex:0] objectForKey:@"SchoolID"];
        }
    }
    
    //    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in studentList) {
        BOOL b = [[dic objectForKey:@"Select"] boolValue];
        if (b) {
            NSMutableDictionary *postDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[dic objectForKey:@"xuehao"],@"xuehao",[dic objectForKey:@"sname"],@"name", nil];
            NSError *error = nil;
            
            NSData *registerData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
            
            //json 数据
            NSString *jsonStr = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
            [postArray addObject:jsonStr];
            
            [jsonStr release];
            [postDic release];
        }
    }
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:schoolID,@"school_id",
                             loginKey,@"key",
                             nil];
    
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationCheckWorksubmit,NotificationKey, nil];
    
    NSString *apikey = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:apikey,@"X-API-KEY",@"application/x-www-form-urlencoded" ,@"Content-Type",nil];
    
    //应用apikey type 老师2，学生 1
    [self formDataRequestWithURL:tempURL UserInfo:userInfo PostArray:postArray PostDic:postDic Header:headerDic];
    [postArray release];
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

- (void)bottonViewPressedBtn{
    NSInteger count = [self getStudentListSelectCount];
    if (count == 0) {
        [DELEGATE  popPromptViewWithMsg:@"请选择学生" AndFrame:CGRectMake(0, 240, 320, 30) andDuration:2];
        return;
    }
    [self netWorkSubmit];
}

- (void)showNoneNumberView{
    UILabel *l = (UILabel *)[self.view viewWithTag:NoneNumberViewTag];
    if (!l) {
        l = [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 200.0f, 300.0f, 25.0f)] autorelease];
        l.text = @"暂无异常考勤";
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

#pragma mark -
#pragma mark  按钮事件
////上面的两个左右按钮
//- (void)pressedButton:(UIButton *)bt {
//    NSInteger tag = bt.tag;
//    //服务列表
//    if (tag == 0) {
//        self.leftBtn.selected = YES;
//        self.rightBtn.selected = NO;
//         [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    //我的服务
//    else if(tag == 1){
//        self.leftBtn.selected = NO;
//        self.rightBtn.selected = YES;
//        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
//    [mainTableView reloadData];
//}


#pragma mark 头部的右边按钮
-(void)rightAction{
    isAllSelect = !isAllSelect;
    for (NSMutableDictionary *dic in studentList) {
        [dic setObject:[NSNumber numberWithBool:isAllSelect] forKey:@"Select"];
    }
    
    [mainTableView reloadData];
}

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
        popupTableView.showsVerticalScrollIndicator = NO;
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
//Table delegate

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
        count = studentList.count%4 == 0?studentList.count/4:(studentList.count/4 + 1);
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
        BOOL b = (studentList.count % 4 == 0);
        int row = b ?studentList.count/4:(studentList.count/4 + 1) - 1;
        
        int count = indexPath.row  * 4;
        
        if (indexPath.row == row && !b ) {
            [((CheckWorkCell *)cell) setBtnHidden];
            int  remainder = studentList.count % 4;
            for (int i = 0; i< remainder; i++) {
               [self resetBtn:cell Tag:i Count:count];
            }
        }else {
            for (int i = 0; i< 4; i++) {
                [self resetBtn:cell Tag:i Count:count];
            }
        }
        
    }
    
    return cell;
}

//重置btn
- (void)resetBtn:(UITableViewCell *)cell Tag:(NSInteger) i Count:(NSInteger) count{
    NSDictionary *dic = nil;
    dic = [studentList objectAtIndex:count + i];
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
        [self trianglePressedBtn];
        
        [studentList removeAllObjects];
        [mainTableView reloadData];
        [self netWorkForGanger];
        
    }  
}

//点击按钮
- (void)pressedButton:(UIButton *)btn forEvent:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchePointion = [touch locationInView:mainTableView];
    NSIndexPath *indexPath = [mainTableView indexPathForRowAtPoint:currentTouchePointion];
    NSInteger count = indexPath.row * 4 + (btn.tag - CheckWorkCellBtnTag);
    
    NSMutableDictionary *dic = [studentList objectAtIndex:count];
    [dic setObject:[NSNumber numberWithBool:!btn.selected] forKey:@"Select"];
    [mainTableView reloadData];
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
- (void)notificationCheckWorksubmit:(NSNotification*) notification{
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    @try
    {
        id OKID = [notification.userInfo objectForKey:@"status"];
        if ([OKID isEqualToString:@"ok"] || [OKID isEqualToString:@"1" ] ) {
            [DELEGATE  popPromptViewWithMsg:@"提交成功" AndFrame:CGRectMake(0, 300, 320, 30) andDuration:3];
            [self.navigationController popViewControllerAnimated:NO];
        }else {
             [DELEGATE  popPromptViewWithMsg:@"提交失败" AndFrame:CGRectMake(0, 300, 320, 30) andDuration:3];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


@end
