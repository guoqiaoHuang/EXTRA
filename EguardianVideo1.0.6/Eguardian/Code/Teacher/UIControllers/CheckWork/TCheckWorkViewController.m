//
//  HomeWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TCheckWorkViewController.h"



#import "Global.h"

#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "ADScrollView.h"
#import "TDetailController.h"
#import "TCommentProcessController.h"
#import "TCommentDetailController.h"

@interface TCheckWorkViewController ()

@end

@implementation TCheckWorkViewController
@synthesize mainTableView;
@synthesize userMessageLabel;
@synthesize dateLable;
@synthesize date;
@synthesize infoArray;
@synthesize dataDatePicker;

- (void)dealloc
{
    [dataDatePicker release];
    [infoArray release];
    [date release];
    [userMessageLabel release];
    [dateLable release];
    [mainTableView release];
    [super dealloc];
}




#pragma mark 头部的右边按钮
-(void)rightAction
{
    UINavigationController *nav = rootNav;
    TCommentProcessController *vc = [[TCommentProcessController alloc] initWithTitle:@"新建"];
    [nav pushViewController:vc animated:YES];
    [vc release];
}




-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 3;
        self.title = @"考 勤";
        currentH = 0;
    }
    return self;
}



//*******************************************************************************************************************************************
//*******************************************************************************************************************************************
//strat 共用头部

//滚轮委托
-(void)selectDateFinish
{
    self.date = self.dataDatePicker.datePicker.date;
    NSString *tempTimeStr = [NSString stringWithFormat:@"%@",[NSString stringWithDate:self.date]];
    dateLable.text = tempTimeStr;
    
    NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:self.date]];
    NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
    [tools download];
    [tools release];
}

-(void)openDatePicker
{
    if (nil == dataDatePicker)
    {
        dataDatePicker = [[DatePickerView alloc] initWithDelegate:self];
        [self.view addSubview:dataDatePicker];
    }
    self.dataDatePicker.hidden = NO;
    
    [self.view bringSubviewToFront:self.dataDatePicker];
}


-(void) yesterdayAction
{
    self.date = GetYesterday(self.date);
    NSString *tempTimeStr = [NSString stringWithFormat:@"%@",[NSString stringWithDate:self.date]];
    dateLable.text = tempTimeStr;
    
    
    NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:self.date]];
    NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
    [tools download];
    [tools release];
}


-(void) tomorrowAction
{
    self.date = GetTomorrow(self.date);
    NSString *tempTimeStr = [NSString stringWithFormat:@"%@",[NSString stringWithDate:self.date]];
    dateLable.text = tempTimeStr;
    
    NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:self.date]];
    NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
    [tools download];
    [tools release];
}





-(void) loadTopView
{
    
    UIImage *tempBGImg = [UIImage imageNamed:@"CHCTop.png"];
    UIImageView *tempBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, tempBGImg.size.height)];
    tempBGView.image = tempBGImg;
    tempBGView.userInteractionEnabled = YES;
    
    
    {
        UILabel *tempLable = [[UILabel alloc] initWithFrame:CGRectMake(25, 17, 38, 15)];
        tempLable.textColor = [UIColor colorWithRed:45.0/255.0 green:101.0/255.0 blue:126.0/255.0 alpha:1.0];
        UIFont *tempFont = [UIFont fontWithName:@"Arial" size:12];
        tempLable.font = tempFont;
        tempLable.text = @"前一天";
        tempLable.backgroundColor = [UIColor clearColor];
        [tempBGView addSubview:tempLable]; [tempLable release];
    }
    
    {
        UILabel *tempLable = [[UILabel alloc] initWithFrame:CGRectMake(261, 17, 38, 15)];
        tempLable.textColor = [UIColor colorWithRed:45.0/255.0 green:101.0/255.0 blue:126.0/255.0 alpha:1.0];
        UIFont *tempFont = [UIFont fontWithName:@"Arial" size:12];
        tempLable.font = tempFont;
        tempLable.text = @"后一天";
        tempLable.backgroundColor = [UIColor clearColor];
        [tempBGView addSubview:tempLable]; [tempLable release];
    }
    
    
    
    
    {
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tempButton.frame = CGRectMake(0, 0, 60, tempBGView.frame.size.height);
        [tempButton addTarget:self action:@selector(yesterdayAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *tempBTImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Yesterday.png"]];
        tempBTImgView.userInteractionEnabled = YES;
        tempBTImgView.frame = CGRectMake(12, 16, tempBTImgView.frame.size.width, tempBTImgView.frame.size.height);
        [tempButton addSubview:tempBTImgView]; [tempBTImgView release];
        [tempBGView addSubview:tempButton];
    }
    
    {
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tempButton.frame = CGRectMake(260, 0, 60, tempBGView.frame.size.height);
        [tempButton addTarget:self action:@selector(tomorrowAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *tempBTImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tomorrow.png"]];
        tempBTImgView.userInteractionEnabled = YES;
        tempBTImgView.frame = CGRectMake(40, 16, tempBTImgView.frame.size.width, tempBTImgView.frame.size.height);
        [tempButton addSubview:tempBTImgView]; [tempBTImgView release];
        [tempBGView addSubview:tempButton];
    }
    
    
    {
        userMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-140)/2.0, 9, 140, 17)];
        userMessageLabel.textColor = [UIColor colorWithRed:88/255.0 green:79/255.0 blue:74.0/255.0 alpha:1.0f];
        userMessageLabel.backgroundColor = [UIColor clearColor];
        userMessageLabel.textAlignment = UITextAlignmentCenter;
        UIFont *tempFont = [UIFont fontWithName:@"Arial" size:15];
        userMessageLabel.font = tempFont;
        userMessageLabel.text = [[ConfigManager sharedConfigManager].userMessage objectForKey:@"teacher"];
        [tempBGView addSubview:userMessageLabel];
    }
    
    {
        dateLable = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-140)/2.0, 27, 140, 17)];
        dateLable.textColor = [UIColor colorWithRed:45.0/255.0 green:101.0/255.0 blue:126.0/255.0 alpha:1.0];
        dateLable.backgroundColor = [UIColor clearColor];
        dateLable.textAlignment = UITextAlignmentCenter;
        UIFont *tempFont = [UIFont fontWithName:@"Arial" size:15];
        dateLable.font = tempFont;
        self.date = [NSDate date];
        NSString *tempTimeStr = [NSString stringWithDate:self.date];
        dateLable.text = tempTimeStr;
        [tempBGView addSubview:dateLable];
    }
    
    
    {
        //滚轮选日期
        UIImage *tempImg = [UIImage imageNamed:@"滚轮选日期.png"] ;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(110, 0, 120, tempBGImg.size.height);
        button.backgroundColor = [UIColor clearColor];
        
        UIImageView *btImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"滚轮选日期.png"]];
        btImgView.frame = CGRectMake(100, 20, tempImg.size.width, tempImg.size.height);
        [button addSubview:btImgView];
        [btImgView release];
        
        [button addTarget:self action:@selector(openDatePicker) forControlEvents:UIControlEventTouchDown];
        [tempBGView addSubview:button];
    }
    
    [self.view addSubview:tempBGView];
    [tempBGView release];
    
    currentH += 49;
}



//end 共用头部
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************



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
    
    [self loadTopView];

    {
        mainTableView = [[UITableView alloc] init];
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.rowHeight = 48;
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        [self.view addSubview:mainTableView];
    }
    
    
    {
        adScrollView = [[ADScrollView alloc] initWithName:@"attendance" delegate:self];
        [self.view addSubview:self.adScrollView];
    }
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    float navh = self.navigationController.navigationBar.frame.size.height;
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH );
    //设置adScrollView 宽高
    {
        float tempW = (self.view.frame.size.width - self.adScrollView.frame.size.width)/2.0;
        float tempH = self.view.frame.size.height-navh - self.adScrollView.frame.size.height;
        self.adScrollView.frame = CGRectMake(tempW, tempH, self.adScrollView.frame.size.width, self.adScrollView.frame.size.height);
    }
    
    
    {
        float tempH = self.view.frame.size.height - self.adScrollView.frame.size.height - currentH - navh;
        self.mainTableView.frame = CGRectMake(0, currentH, ScreenW, tempH);
        {
            //下载数据
            NSString *tempURL = [ConfigManager getTCheckWorkWithString:[NSString stringWithDate:self.date]];
            NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
            [tools download];
            [tools release];
            
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
                        
        }
        
    }
    
    
}


#pragma mark 生成 table
-(void) refreshMainTableView
{
    [self.mainTableView reloadData];
    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:app.displayPanel];
}







-(void)initCustomCell:(UITableViewCell *)cell
{

    float tempY = 18;
    float tempH = 17;
    float leftX = 18;
    
    UIColor *tempColor = [UIColor colorWithRed:143/255.0 green:136/255.0 blue:130/255.0 alpha:1.0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    
    UIImageView *leftV = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"C_CellLeftImg.png"] ];
    leftV.frame = CGRectMake(leftX, 20, leftV.frame.size.width, leftV.frame.size.height);
    [cell.contentView addSubview:leftV]; [leftV release];
    leftX += leftV.frame.size.width + 9;
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 175, tempH)];
        label.textColor = tempColor;
        label.tag = 90;
        label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:label]; [label release];
        leftX += label.frame.size.width + 15;
    }
    
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 70, tempH)];
        label.textColor = tempColor;
        label.tag = 91;
        UIFont *afont = [UIFont fontWithName:@"Arial" size:13];
        label.backgroundColor = [UIColor clearColor];
        label.font = afont;
        [cell.contentView addSubview:label]; [label release];
    }
    
    
    
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
	return [self.infoArray count];
}



-(UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaseCell";
    UITableViewCell *cell = (UITableViewCell*)[atableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, atableView.frame.size.width, cell.frame.size.height);
        [self initCustomCell:cell];
    }
    
    NSDictionary *tempDic = [self.infoArray objectAtIndex:indexPath.row];
    UILabel *ConentTable = (UILabel *)[cell viewWithTag:90];
    ConentTable.text = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"times"] ];
    
    UILabel *subjectTable = (UILabel *)[cell viewWithTag:91];
    subjectTable.text = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"teacher"] ];
    
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [atableView cellForRowAtIndexPath:indexPath];
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    
    
    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:app.displayPanel];
    app.displayPanel.hidden = NO;
    app.displayPanel.panel.text = ptable.text;
    app.displayPanel.panel.textColor = [UIColor blackColor];
    
}



//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    NSDictionary *dicData = [JSONProcess JSONProcess:tempData];
    if ( [@"ok" isEqualToString:[dicData objectForKey:@"status"]] )
    {
        self.infoArray = [dicData objectForKey:@"content"];
    }
    else
    {
        self.infoArray = nil;
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self refreshMainTableView];
                       self.activityView.hidden = YES;
                       [self.activityView stopAnimating];
                   });
    
    
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [super showError];
                   });
}










@end






































