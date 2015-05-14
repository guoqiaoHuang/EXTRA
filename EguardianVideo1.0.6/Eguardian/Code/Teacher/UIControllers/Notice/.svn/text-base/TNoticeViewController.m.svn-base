//
//  HomeWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TNoticeViewController.h"



#import "Global.h"

#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "ADScrollView.h"
#import "TDetailController.h"
#import "TNoticeProcessController.h"
#import "TNoticeDetailController.h"

@interface TNoticeViewController ()

@end

@implementation TNoticeViewController
@synthesize mainTableView;
@synthesize userMessageLabel;
@synthesize dateLable;
@synthesize date;
@synthesize infoArray;
@synthesize isPopToRoot;

- (void)dealloc
{
    [infoArray release];
    [date release];
    [userMessageLabel release];
    [dateLable release];
    [mainTableView release];
    [super dealloc];
}




#pragma mark 头部的右边按钮
//-(void)rightAction
//{
//    UINavigationController *nav = rootNav;
//    TNoticeProcessController *vc = [[TNoticeProcessController alloc] initWithTitle:@"新建"];
//    [nav pushViewController:vc animated:YES];
//    [vc release];
//}

-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 5;
        self.title = @"通 知";
        currentH = 0;
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
//    {
//        UIImage* image= [UIImage imageNamed:@"T发送作业按钮.png"];
//        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
//        UIButton* RButton= [[UIButton alloc] initWithFrame:frame_1];
//        [RButton setBackgroundImage:image forState:UIControlStateNormal];
//        [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [RButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:RButton];
//        [self.navigationItem setRightBarButtonItem:someBarButtonItem];
//        [someBarButtonItem release];
//        [RButton release];
//    }
    
    
    
    {
        mainTableView = [[UITableView alloc] init];
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.rowHeight = 48;
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        [self.view addSubview:mainTableView];
    }
    
    
    {
        adScrollView = [[ADScrollView alloc] initWithName:@"notice" delegate:self];
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
            NSString *tempURL = [ConfigManager getTNotice];
            NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
            [tools download];
            [tools release];
            
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        }
        
    }
    
    
}

- (void)backAction{
    if (isPopToRoot) {
        [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -  3)] animated:NO];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
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
    ConentTable.text = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"title"] ];
    
    UILabel *subjectTable = (UILabel *)[cell viewWithTag:91];
    subjectTable.text = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"sendtime"] ];
    
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNoticeDetailController *dc = [[TNoticeDetailController alloc] initWithTitle:@"详情" data:[self.infoArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:dc animated:YES];
    [dc release];
}



//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    NSDictionary *dicData = [JSONProcess JSONProcess:tempData];    
    if ( [@"ok" isEqualToString:[dicData objectForKey:@"status"]]   )
    {
        self.infoArray = [dicData objectForKey:@"content"];

    }
    else
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self showError];
                       });
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






































