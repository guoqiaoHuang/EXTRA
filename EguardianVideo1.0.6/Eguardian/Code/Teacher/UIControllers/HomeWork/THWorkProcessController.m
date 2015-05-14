//
//  THWorkProcessViewController.m
//  Eguardian
//
//  Created by apple on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "THWorkProcessController.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "GradeClassViewController.h"
#import "NetTools.h"
#import "ConfigManager.h"
#import "JSONProcess.h"
#import "CommonTools.h"
#import "THomeWorkViewController.h"

@interface THWorkProcessController ()

@end

@implementation THWorkProcessController
@synthesize searchBar;
@synthesize contentView;
@synthesize subjectField;
@synthesize subjectTable;
@synthesize subjectData;
@synthesize sendSubjectObj;
@synthesize students;
@synthesize subjectID;

- (void)dealloc
{
    [subjectID release];
    [sendSubjectObj release];
    [subjectData release];
    [subjectTable release];
    [subjectField release];
    [contentView release];
    [searchBar release];
    [super dealloc];
}


//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    [super backAction];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    
    
    if ( nil == subjectID || [@"" isEqualToString:subjectID] || nil == contentView.text || [@"" isEqualToString:contentView.text ]  )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"请选中科目和输入内容",nil];
        [alert show];
        [alert release];
        return;
    }

    
    NSArray *studentKeys = [self.students allKeys];
    
    NSDictionary *firstObj = [self.students objectForKey:[studentKeys objectAtIndex:0]];
    NSString *gradeID =  [firstObj objectForKey:@"gradeid"];
    NSString *classID =  [firstObj objectForKey:@"classid"];
    
    NSMutableString *studentIDS = [[NSMutableString alloc] init];
    
    for ( int i=0; i<studentKeys.count; i++ )
    {
        NSString *tempKey = [studentKeys objectAtIndex:i];
        NSDictionary *tempObj = [self.students objectForKey:tempKey];
        NSString *stuID = [tempObj objectForKey:@"id"];
        
        if (self.students.count == 1)
        {
            [studentIDS appendString:stuID];
        }
        else if( i<studentKeys.count -1)
        {
            [studentIDS appendFormat:@"%@,",stuID];
        }
        else
        {
            [studentIDS appendString:stuID];
        }
    }
    
    //平凑发送作业地址
    NSString *sendURL = [ConfigManager getSendHomeWorkWithGradeID:gradeID classID:classID ids:studentIDS subjectID:self.subjectID content:self.contentView.text];
    [studentIDS release];
    
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
                                                 cancelButtonTitle:@"发送失败"
                                                 otherButtonTitles:nil,nil];
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
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
//                                                               message:nil
//                                                              delegate:self
//                                                     cancelButtonTitle:nil
//                                                     otherButtonTitles:@"发送成功",nil];
//                [alert show];
//                [alert release];
                 [DELEGATE popPromptViewWithMsg:@"发送成功" AndFrame:CGRectMake(0, 380, 320, 30) andDuration:3];
                
                THomeWorkViewController *vc = [[THomeWorkViewController alloc] init];
                vc.isPopToRoot = YES;
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];

                
            } else
            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
//                                                               message:nil
//                                                              delegate:nil
//                                                     cancelButtonTitle:@"发送失败"
//                                                     otherButtonTitles:nil,nil];
//                [alert show];
//                [alert release];
                 [DELEGATE popPromptViewWithMsg:@"发送失败" AndFrame:CGRectMake(0, 380, 320, 30) andDuration:3];
            }
        }        
    }
    
    
    

}


#pragma mark 选中科目
-(void) selectSubjectAction
{
    self.subjectTable.hidden = NO;
}



#pragma mark 搜索
-(void) searchAction
{
    GradeClassViewController *nc = [[GradeClassViewController alloc] initWithDelegate:self];
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
        
        
        UIButton* searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.frame = CGRectMake(0, 0, searchBG.frame.size.width, searchBG.frame.size.height);
        [searchButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [searchBG addSubview:searchButton];
        [self.view addSubview:searchBG];
        [searchBG release];
    }
    
    
    
    {
    
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"T新建输入科目.png"]];
        tempImageView.frame = CGRectMake( (self.view.frame.size.width - tempImageView.frame.size.width)/2.0 ,
                                         currentH + 14, tempImageView.frame.size.width, tempImageView.frame.size.height);
        
        tempImageView.userInteractionEnabled = YES;
        
        {
            subjectField = [[UITextField alloc] initWithFrame:CGRectMake(100, (tempImageView.frame.size.height -20)/2.0, 150, 20)];
            subjectField.backgroundColor = [UIColor clearColor];
            subjectField.enabled = NO;
            [tempImageView addSubview:subjectField];
        }
        
        
        
        {
            subjectTable = [[UITableView alloc] initWithFrame:CGRectMake(tempImageView.frame.origin.x,
                                                                     tempImageView.frame.origin.y + tempImageView.frame.size.height,
                                                                     tempImageView.frame.size.width, 300) style:UITableViewStyleGrouped ];
            self.subjectTable.delegate = self;
            self.subjectTable.dataSource = self;
            self.subjectTable.rowHeight = tempImageView.frame.size.height;
            [self.view addSubview:subjectTable];
            self.subjectTable.hidden = YES;
        }
        
        
        
        UIButton* tempButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tempImageView.frame.size.width, tempImageView.frame.size.height)];
        [tempButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [tempButton addTarget:self action:@selector(selectSubjectAction) forControlEvents:UIControlEventTouchUpInside];
        [tempImageView addSubview:tempButton];

        
        
        
        
        
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
        UIImageView *sendBTBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"发送作业.png"]];
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

//推到已完成的作业
- (void)rightAction{
    THomeWorkViewController *vc = [[THomeWorkViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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






#pragma mark 生成 table
-(void) refreshSubjectTableView
{
    [self.subjectTable reloadData];
    [self.view bringSubviewToFront:subjectTable];
    
    
}





//**************************************************************************************************************
//**************************************************************************************************************
//选中名称委托
- (void) selectNamesFinsh:(id)tempData
{
    self.students = tempData;
    NSMutableString *names = [[NSMutableString alloc] init];
    for ( NSString *key in self.students  )
    {
        [names appendFormat:@"%@ ",[[self.students objectForKey:key] objectForKey:@"sname"]];
    }
    self.searchBar.text = names;
    [names release];
    
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

    
    self.subjectTable.hidden = YES;
    
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
    else
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self showErrorMessage: [obj objectForKey:@"content"]];
                       });
    }
    
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self refreshSubjectTableView];
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
