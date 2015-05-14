//
//  CheckWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "NoticeViewController.h"
#import "HomeWorkViewController.h"
#import "CommentViewController.h"
//#import "VideoViewController.h"
#import "CheckWorkViewController.h"
#import "Global.h"



#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "DisplayPanel.h"
#import "ADScrollView.h"
#import "NSDictionary+Extemsions.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController
@synthesize mainTableView;
@synthesize userMessageLabel;
@synthesize dateLable;
@synthesize date;
@synthesize info;
@synthesize readNumberDic;

- (void)dealloc
{
    [info release];
    [date release];
    [userMessageLabel release];
    [dateLable release];
    [mainTableView release];
    [readNumberDic release];
    [super dealloc];
}






-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 5;
        self.title = @"通 知";
    }
    return self;
}







-(void)viewWillAppear:(BOOL)animated
{
    
    if (!self.isFirst) return;
    self.isFirst = FALSE;
    
    
    currentH = 0;
    self.navigationController.navigationBarHidden = NO;
    float navh = self.navigationController.navigationBar.frame.size.height;
    
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    //设置adScrollView 宽高
    {
        adScrollView = [[ADScrollView alloc] initWithName:@"notice" delegate:self];
        float tempW = (self.view.frame.size.width - self.adScrollView.frame.size.width)/2.0;
        float tempH = self.view.frame.size.height-navh - self.adScrollView.frame.size.height;
        self.adScrollView.frame = CGRectMake(tempW, tempH, self.adScrollView.frame.size.width, self.adScrollView.frame.size.height);
        [self.view addSubview:self.adScrollView];
    }
    
    
    float tempH = self.view.frame.size.height - navh - self.adScrollView.frame.size.height - currentH;
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, currentH, ScreenW, tempH) style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.rowHeight = 48;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
}

#pragma makr cell自定义
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 125, tempH)];
        label.textColor = tempColor;
        label.tag = 90;
        label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:label]; [label release];
        leftX += label.frame.size.width + 15;
    }
    
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 140, tempH)];
        label.textColor = tempColor;
        label.tag = 91;
        UIFont *afont = [UIFont fontWithName:@"Arial" size:13];
        label.backgroundColor = [UIColor clearColor];
        label.font = afont;
        [cell.contentView addSubview:label]; [label release];
    }
    
    
}


//更新未读信息状态
- (void)netWorkUpdateReadNumber{
    id typeID = @"TZ";
    id detailID = [readNumberDic objectJudgeFullForKey:@"tz_ids"];
    id countID = [readNumberDic objectJudgeFullForKey:@"tongzhiweidu"];
    if (detailID && countID ) {
        if ( [countID intValue] > 0) {
            NSString *urlStr = [ConfigManager getUpdataReadNumber:typeID ID:detailID];;
            
            NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
            NSURL *url = [NSURL URLWithString:urlStr];
            [request setURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response, NSData *temdata, NSError *error) {
                                       
                                       if (error)
                                       {
                                       } else {
                                           //这里没做判断ok
                                          [readNumberDic setObject:@"0" forKey:@"tongzhiweidu"];
                                       }
                                   }];
        
        }
    }
}

//**************************************************************************************************************
//**************************************************************************************************************
#pragma mark -
#pragma mark  Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return [self.info.list count];
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
    
        
    
    NSDictionary *tempDic = [self.info.list objectAtIndex:indexPath.row];
        
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    NSString *tempStr = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"title"]];
    ptable.text = tempStr;
    
    UILabel *tempTimeLabel = (UILabel *)[cell viewWithTag:91];
    NSString *tempTimeStr = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"sendtime"]];
    tempTimeLabel.text = tempTimeStr;
    
    
    //
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
//**************************************************************************************************************
//网络和修改


#pragma mark 加载数据
-(void)loadData
{
    
    
    //    self.date = [@"2013-03-17" dateWithString];
    self.date = [NSDate date];      //设置当前时间
    NSString *tempURL = [ConfigManager getNoticeWithString:[NSString stringWithDate:self.date]];
    NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
    [tools download];
    [tools release];
    
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];
    
    
}




#pragma mark 生成 table
-(void) loadTableView
{
    
    if(self.info == nil) return;
    
    //设置用户名
    {
        userMessageLabel.text = [[ConfigManager sharedConfigManager].userMessage objectForKey:@"sname"];
    }
    
    [self.mainTableView reloadData];
    
    
    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:app.displayPanel];
    
    
    
}


//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    NoticeData *cdata = [[NoticeData alloc] initWithDictionary: [JSONProcess JSONProcess:tempData]];
    self.info = cdata; [cdata release];
    
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self loadTableView];
                       self.activityView.hidden = YES;
                       [self.activityView stopAnimating];
                       [self netWorkUpdateReadNumber];
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































































