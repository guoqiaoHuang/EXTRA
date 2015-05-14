//
//  HomeWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ProvinceController.h"

#import "CheckWorkViewController.h"
#import "CommentViewController.h"
//#import "VideoViewController.h"
#import "THWorkProcessController.h"
#import "SurveillanceVdeoViewController.h"


#import "Global.h"

#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "ADScrollView.h"
#import "ProCityDataManager.h"
#import "CityController.h"

@interface ProvinceController ()

@end

@implementation ProvinceController
@synthesize mainTableView;
@synthesize info;

- (void)dealloc
{
    [info release];
    [mainTableView release];
    [super dealloc];
}


//*******************************************************************************************************************************************
//*******************************************************************************************************************************************
//strar

#pragma mark 头部的右边按钮
-(void)rightAction
{
    UINavigationController *nav = rootNav;
    THWorkProcessController *vc = [[THWorkProcessController alloc] init];
    [nav pushViewController:vc animated:YES];
    [vc release];
}


-(void) selectControllerWithTag:(int)atag
{
    UINavigationController *nav = rootNav;
    
    if ( atag == 2 )        //email
    {
        CommentViewController *vc = [[CommentViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
    else if ( atag == 3 )   //schedule
    {
        CheckWorkViewController *vc = [[CheckWorkViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
    else if ( atag == 4 )   //schedule
    {
//        VideoViewController *vc = [[VideoViewController alloc] init];
//        [nav pushViewController:vc animated:YES];
//        [vc release];
        SurveillanceVdeoViewController *vc = [[SurveillanceVdeoViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
}

-(void) footButtonAction:(UIButton *)sender
{
    
    //自己点自己没有相应
    if ( sender.tag == self.controllerTag )
        return;
    
//    UINavigationController *nav = rootNav;
//    [nav popToRootViewControllerAnimated:NO];
    //点击首页的情况
    if ( 0 == sender.tag)
    {
        [self goBackHome];
//        [nav popViewControllerAnimated:YES];
//        [nav popToRootViewControllerAnimated:YES];
        return;
    }
    [self selectControllerWithTag:sender.tag];
}













-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 1;
        self.title = @"选择省";
    }
    return self;
}


//end
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************


//*******************************************************************************************************************************************
//*******************************************************************************************************************************************
//strat 共用头部










//end 共用头部
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    if (!self.isFirst) return;
    self.isFirst = FALSE;
    
    currentH = 0;
    self.navigationController.navigationBarHidden = NO;
//    float navh = self.navigationController.navigationBar.frame.size.height;
    
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
    
}





#pragma makr cell自定义
-(void)initCustomCell:(UITableViewCell *)cell
{

    UIColor *tempColor = [UIColor colorWithRed:143/255.0 green:136/255.0 blue:130/255.0 alpha:1.0];    
    UIImageView *cellBg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"CellBG.png"] ];
    cellBg.frame = CGRectMake(0, 0, ScreenW-14, mainTableView.rowHeight);
    
    
    
    {
        //内容
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 0, 260, cell.frame.size.height)];
        label.textColor = tempColor;
        label.tag = 90;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"勾股定理课堂练习";
        [cellBg addSubview:label]; [label release];

    }
    
    {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow.png"]];
        arrow.frame = CGRectMake(276, 17, arrow.frame.size.width, arrow.frame.size.height);
        [cellBg addSubview:arrow];
        [arrow release];
    }
    

    
    [cell.contentView addSubview:cellBg]; [cellBg release];
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
	return [self.info count];
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
    
   
    if ([self.info count] >0 && indexPath.row == [self.info count]-1 )
    {
        CusstomCellRounde(cell, CellCornerRadius, NO);
    }
    
    
    
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    NSString *tempStr = [self.info objectAtIndex:indexPath.row];
    ptable.text = tempStr;
    
   
    
    
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [atableView cellForRowAtIndexPath:indexPath];
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    
    [ProCityDataManager sharedProCityDataManager].provinceName = ptable.text;
    CityController *cc = [[CityController alloc] initWithKey:ptable.text];
    [self.navigationController pushViewController:cc animated:YES];
    [cc release];
    
    
}







//**************************************************************************************************************
//**************************************************************************************************************
//**************************************************************************************************************
//网络和修改


#pragma mark 加载数据
-(void)loadData
{
    
    
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@?action=prov_city",baseURL];
    
    
    NetTools *tools = [[NetTools alloc] initWithURL:urlString delegate:self];
    [tools download];
    [tools release];

    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];
}




#pragma mark 生成 table
-(void) loadTableView
{
    

    if(self.info == nil)
    {
        [self.mainTableView reloadData];
        return;
    }
    
    if (mainTableView)
    {
        [mainTableView removeFromSuperview];
        self.mainTableView = nil;
    }
    
    
 
    
    
    float tempH = self.view.frame.size.height - self.adScrollView.frame.size.height - currentH - 32;
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(7, currentH+12, ScreenW-14, tempH) style:UITableViewStylePlain];
    
    mainTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:247/255.0 alpha:1.0];
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.rowHeight = 48;
    mainTableView.layer.cornerRadius = CellCornerRadius;
    mainTableView.layer.masksToBounds = YES;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    
    
    
    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:app.displayPanel];
    
    
}


//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    

    
    
    
    NSDictionary *obj = [JSONProcess JSONProcess:tempData];
    if ( [@"ok" isEqualToString:[obj objectForKey:@"status"]]   )
    {
        [ProCityDataManager sharedProCityDataManager].proCitys = [obj objectForKey:@"content"];
        
        NSDictionary *content = [ProCityDataManager sharedProCityDataManager].proCitys;
        self.info = [content allKeys];
    }
    

    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self loadTableView];
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






































