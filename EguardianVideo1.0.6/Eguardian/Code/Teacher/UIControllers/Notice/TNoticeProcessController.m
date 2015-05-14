//
//  THWorkProcessViewController.m
//  Eguardian
//
//  Created by apple on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TNoticeProcessController.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "NetTools.h"
#import "ConfigManager.h"
#import "JSONProcess.h"
#import "CommonTools.h"
#import "TNoticeViewController.h"

@interface TNoticeProcessController ()

@end

@implementation TNoticeProcessController
@synthesize searchBar;
@synthesize contentView;
@synthesize subjectField;
@synthesize subjectData;
@synthesize sendSubjectObj;
@synthesize students;
@synthesize subjectID;

- (void)dealloc
{
    [subjectID release];
    [sendSubjectObj release];
    [subjectData release];
    [subjectField release];
    [contentView release];
    [searchBar release];
    [super dealloc];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super backAction];
}

#pragma mark 发送作业
-(void) sendAction
{
    
    if (self.students.count <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"请选择人名",nil];
        [alert show];
        [alert release];
        return;
    }
    
    if (  nil == subjectField.text || [@"" isEqualToString:subjectField.text ] || nil == contentView.text || [@"" isEqualToString:contentView.text ]  )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"请输入标题和内容",nil];
        [alert show];
        [alert release];
        return;
    }
    
    
    
    NSString *gradeID =  [self.students objectForKey:@"classID"];
    NSString *classID =  [self.students objectForKey:@"gradeID"];
    
    
    //平凑发送作业地址
    NSString *sendURL = [ConfigManager getSendTNotice:subjectField.text content:contentView.text gradeID:gradeID classID:classID];
    
    
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:sendURL]];
        NSURLResponse *response;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"发送失败",nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            NSError *parseError = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            NSString *status = [jsonObject objectForKey:@"status"];
            if ([status isEqualToString:@"ok"])
            {
//                [self backAction];
                TNoticeViewController *vc = [[TNoticeViewController alloc] init];
                vc.isPopToRoot = YES;
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];

            } else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                               message:nil
                                                              delegate:nil
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"发送失败",nil];
                [alert show];
                [alert release];
            }
        }        
    }
    
    
    

}




#pragma mark 搜索
-(void) searchAction
{
    GradeClassViewController *nc = [[GradeClassViewController alloc] initWithDelegate:self flag:TRUE];
    [self.navigationController pushViewController:nc animated:YES];
    [nc release];
}






-(id) initWithTitle:(NSString *)title 
{
    self = [super init];
    if (self)
    {
        self.title = title;
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    //右边按钮
    {
        UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"已发送" target:self action:@selector(rightAction)]];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        [rightBarItem release];
    }
    
    currentH = 0;
    {
        UIImageView *searchBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选择人员搜索框背景.png"]];
        searchBG.frame = CGRectMake( (self.view.frame.size.width - searchBG.frame.size.width)/2, currentH + 7,
                                    searchBG.frame.size.width, searchBG.frame.size.height);
        searchBG.userInteractionEnabled = YES;
        
        searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10, ( searchBG.frame.size.height - 20 )/2, 240, 20)];
        [searchBG addSubview:searchBar];
        
       
        searchBar.backgroundColor = [UIColor clearColor];
        searchBar.textColor = [UIColor colorWithRed:144/255.0 green:137/255.0 blue:129/255.0 alpha:1.0];
        currentH = searchBG.frame.origin.y + searchBG.frame.size.height;     //计算位置
        searchBar.userInteractionEnabled = NO;
        
        
        UIButton* searchButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, searchBG.frame.size.width, searchBG.frame.size.height)];
        [searchButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [searchBG addSubview:searchButton];
        [self.view addSubview:searchBG];
        [searchBG release];
    }
    
    
    
    {
    
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"T标题输入框背景.png"]];
        tempImageView.frame = CGRectMake( (self.view.frame.size.width - tempImageView.frame.size.width)/2.0 ,
                                         currentH + 14, tempImageView.frame.size.width, tempImageView.frame.size.height);
        
        tempImageView.userInteractionEnabled = YES;
        
        {
            subjectField = [[UITextField alloc] initWithFrame:CGRectMake(100, (tempImageView.frame.size.height -20)/2.0, 150, 20)];
            subjectField.backgroundColor = [UIColor clearColor];
            [tempImageView addSubview:subjectField];
            
            
            
            UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
            [topView setBarStyle:UIBarStyleBlack];
            UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
            NSArray * buttonsArray = [NSArray arrayWithObjects:doneButton,nil];
            [doneButton release];
            [topView setItems:buttonsArray];
            [subjectField setInputAccessoryView:topView];
            [topView release];
            
        }
        
        
        

        
        
        
        currentH = tempImageView.frame.origin.y + tempImageView.frame.size.height;
        tempImageView.userInteractionEnabled = YES;
        [self.view addSubview:tempImageView]; [tempImageView release];
        

    }
    
    
    {
        contentView = [[UITextView alloc] initWithFrame:CGRectMake( (self.view.frame.size.width - 300)/2.0 , currentH+7, 300, 140)];
        contentView.layer.cornerRadius = 10;
        contentView.font = [UIFont fontWithName:@"Arial" size:15];
        contentView.delegate = self;
        
        
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
        [topView setBarStyle:UIBarStyleBlack];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:doneButton,nil];
        [doneButton release];
        [topView setItems:buttonsArray];
        [contentView setInputAccessoryView:topView];
        [topView release];
        
        
        [self.view addSubview:contentView];
        currentH = contentView.frame.origin.y + contentView.frame.size.height;
        
        
    }
    
    
    {
        UIImageView *sendBTBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"T发送通知.png"]];
        sendBTBG.frame = CGRectMake( (self.view.frame.size.width - sendBTBG.frame.size.width)/2.0 ,
                                    currentH+30, sendBTBG.frame.size.width, sendBTBG.frame.size.height);
        sendBTBG.userInteractionEnabled = YES;
        currentH = sendBTBG.frame.origin.y + sendBTBG.frame.size.height;
        
        
        UIButton *sendBT = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBT.frame = CGRectMake(0, 0, sendBTBG.frame.size.width, sendBTBG.frame.size.height);
        [sendBT addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchDown];
        [sendBTBG addSubview:sendBT];
        
        [self.view addSubview:sendBTBG];
        [sendBTBG release];
        
        
    }
    
    

    {
        //下载科目信息
        NSString *tempURL = [ConfigManager getSubject];
        NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
        [tools download];
        [tools release];
        
        self.activityView.hidden = NO;
        [self.view bringSubviewToFront:self.activityView];
        [self.activityView startAnimating];
    }
    
	
}

- (void)rightAction{
    TNoticeViewController *vc = [[TNoticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}







#pragma mark 关闭键盘
-(void)dismissKeyBoard
{
    [self.contentView resignFirstResponder];
    [self.subjectField resignFirstResponder];
}









//**************************************************************************************************************
//**************************************************************************************************************
//获取班级delegate
- (void) gradeClassData:(NSDictionary *)tempData
{
//    {
//        classID = 7;
//        cls = "07\U73ed";
//        grade = "\U4e00\U5e74\U7ea7";
//        gradeID = 1;
//    }

    self.searchBar.text = [NSString stringWithFormat:@"%@%@",[tempData objectForKey:@"grade"],[tempData objectForKey:@"cls"]];
    self.students = tempData;
}




//**************************************************************************************************************
//**************************************************************************************************************
//Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return self.subjectData.count;
}



-(UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaseCell";
    UITableViewCell *cell = (UITableViewCell*)[atableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *array = [self.subjectData allKeys];
    NSString *key = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.subjectData objectForKey:key];
    return cell;
}




#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allkeys = [self.subjectData allKeys];
    
    self.sendSubjectObj = [NSDictionary dictionaryWithObject:[self.subjectData objectForKey: [allkeys objectAtIndex:indexPath.row]] forKey:[allkeys objectAtIndex:indexPath.row]];
    
    NSArray *subKey = [self.sendSubjectObj allKeys];
    self.subjectField.text = [self.sendSubjectObj objectForKey:[subKey objectAtIndex:0]];
    
    
    self.subjectID = [subKey objectAtIndex:0];  //记录选中的科目ID

    
}




//**************************************************************************************************************
//**************************************************************************************************************
//net delegate


- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    
    
    
    
    NSDictionary *obj = [JSONProcess JSONProcess:tempData];
    if ( [@"ok" isEqualToString:[obj objectForKey:@"status"]]   )
    {
        self.subjectData = [obj objectForKey:@"content"];
    }
//    else
//    {
//        dispatch_async(dispatch_get_main_queue(),
//                       ^{
//                           [self showError];
//                       });
//    }
    
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       self.activityView.hidden = YES;
                       [self.activityView stopAnimating];
                   });
    
    
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self showError];
                   });
}





























@end
















































































