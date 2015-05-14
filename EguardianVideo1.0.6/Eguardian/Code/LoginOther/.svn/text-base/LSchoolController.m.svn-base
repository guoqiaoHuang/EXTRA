//
//  HomeWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LSchoolController.h"

#import "LoginBaseViewController.h"

#import "Global.h"

#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "ADScrollView.h"
#import "ProCityDataManager.h"
#import "CityController.h"

@interface LSchoolController ()

@end

@implementation LSchoolController
@synthesize mainTableView;
@synthesize info;
@synthesize delegate = delegate_;

- (void)dealloc
{
    [info release];
    [mainTableView release];
    [super dealloc];
}



-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 1;
        self.title = @"选择学校";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

//定制返回函数
-(void)backAction
{
    
    LoginBaseViewController *controller = [self.navigationController.viewControllers objectAtIndex:0];
    self.delegate = controller;
    [self.delegate schoolController:self
                   selectedSchoolID:[ProCityDataManager sharedProCityDataManager].schoolID
                         schoolName:[ProCityDataManager sharedProCityDataManager].schoolName];
    [self.navigationController popToViewController:controller animated:NO];
//    UINavigationController *nav = rootNav;
//    int tempCount = [nav.viewControllers count];
//    for (; tempCount>1; tempCount--)
//    {
//        [nav popViewControllerAnimated:NO];
//    }
    
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
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"L选择框.png"]];
        arrow.frame = CGRectMake(256, (cellBg.frame.size.height-arrow.frame.size.height)/2.0, arrow.frame.size.width, arrow.frame.size.height);
        
        
        UIImageView *selectImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"L勾选.png"]];
        selectImg.frame = CGRectMake( (arrow.frame.size.width - selectImg.frame.size.width)/2.0,
                                     (arrow.frame.size.height - selectImg.frame.size.height)/2.0,
                                     selectImg.frame.size.width, selectImg.frame.size.height);
        selectImg.tag = 91;
        
        [arrow addSubview:selectImg];
        selectImg.hidden = YES;
        [selectImg release];
        
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
    NSString *tempStr = [[self.info objectAtIndex:indexPath.row] objectForKey:@"school"];
    ptable.text = tempStr;
    
   
    
    
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [atableView cellForRowAtIndexPath:indexPath];
    UIImageView *tempView = (UIImageView *)[cell viewWithTag:91];
    tempView.hidden = NO;
//    学校id
    [ProCityDataManager sharedProCityDataManager].schoolID = [[self.info objectAtIndex:indexPath.row] objectForKey:@"id"];
    
//    学校名称
    [ProCityDataManager sharedProCityDataManager].schoolName = [[self.info objectAtIndex:indexPath.row] objectForKey:@"school"];
    
    [self backAction];
}


-(void) tableView:(UITableView *)atableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [atableView cellForRowAtIndexPath:indexPath];
    UIImageView *tempView = (UIImageView *)[cell viewWithTag:91];
    tempView.hidden = YES;
}





//**************************************************************************************************************
//**************************************************************************************************************
//**************************************************************************************************************
//网络和修改


#pragma mark 加载数据
-(void)loadData
{
    
    
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@?action=school&prov=%@&city=%@&area=%@",baseURL,
                           [ProCityDataManager sharedProCityDataManager].provinceName,
                           [ProCityDataManager sharedProCityDataManager].cityName,
                           [ProCityDataManager sharedProCityDataManager].zoneName];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
        self.info = [obj objectForKey:@"content"];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self loadTableView];
                           self.activityView.hidden = YES;
                           [self.activityView stopAnimating];
                       });
    }
    
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self showError];
                   });
}










@end






































