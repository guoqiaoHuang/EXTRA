//
//  HomeWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "GradeClassViewController.h"




#import "Global.h"

#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "ADScrollView.h"
#import "ProCityDataManager.h"
#import "ZoneController.h"
#import "NameViewController.h"

@interface GradeClassViewController ()

@end

@implementation GradeClassViewController
@synthesize mainTableView;
@synthesize info;
@synthesize data;
@synthesize delegate;

- (void)dealloc
{
    [delegate release];
    [data release];
    [info release];
    [mainTableView release];
    [super dealloc];
}

-(id) initWithDelegate:(id)adelegate
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 1;
        self.title = @"选择班级";
        self.delegate = adelegate;
        currentH = 0;
        retrunFlag = FALSE;
    }
    return self;
}


-(id) initWithDelegate:(id)adelegate flag:(BOOL)aretrunFlag
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 1;
        self.title = @"选择班级";
        self.delegate = adelegate;
        currentH = 0;
        retrunFlag = aretrunFlag;
    }
    return self;
}

-(id) initWithDelegate:(id)adelegate Select:(BOOL)aIsOneSelect {
    self = [super init];
    if (self)
    {
        self.controllerTag = 1;
        self.title = @"选择班级";
        self.delegate = adelegate;
        currentH = 0;
        isOneSelect = aIsOneSelect;
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
    
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    if (nil == info)
    {
        {
            //下载数据
            NSString *tempURL = [ConfigManager getGradeClass];
            NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
            [tools download];
            [tools release];
            
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        }
    }
    
    
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
    
    
    float tempH = self.view.frame.size.height - self.adScrollView.frame.size.height  - currentH - 32;
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(7, currentH+12, ScreenW-14, tempH) style:UITableViewStylePlain];
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
    NSDictionary *message = [self.info objectAtIndex:indexPath.row];
    NSString *showMsg = [NSString stringWithFormat:@"%@%@", [message objectForKey:@"grade"], [message objectForKey:@"cls"]];
    ptable.text = showMsg;
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //整个班级的选择
    if (retrunFlag)
    {
        [self.delegate gradeClassData:[self.info objectAtIndex:indexPath.row]];
        [self backAction];
    }
    
    //一个一个的选择
    else
    {
        NameViewController *nc = [[NameViewController alloc] initWithTitle:@"选择名称" data:[self.info objectAtIndex:indexPath.row] delegate:self.delegate];
        nc.isOneSelect = isOneSelect;
        
        [self.navigationController pushViewController:nc animated:YES];
        [nc release];
    }

}









//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    NSDictionary *obj = [JSONProcess JSONProcess:tempData];
    self.data = [obj objectForKey:@"content"];
    
    if ( [@"ok" isEqualToString:[obj objectForKey:@"status"]]   )
    {
        self.data = [obj objectForKey:@"content"];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for ( NSString *gradeID in self.data)
        {
            NSDictionary *gradeMessage = [self.data objectForKey:gradeID];
            NSDictionary *classMessage = [gradeMessage objectForKey:@"cls"];
            
            NSString *gradeName = [gradeMessage objectForKey:@"grade"];
            
            for (NSString *classID in classMessage)
            {
                NSMutableDictionary *tempObj = [[NSMutableDictionary alloc] init];
                [tempObj setObject:gradeID forKey:@"gradeID"];  //年级ID
                [tempObj setObject:gradeName forKey:@"grade"];  //年级名称
                [tempObj setObject:classID forKey:@"classID"];  //班级ID
                [tempObj setObject:[classMessage objectForKey:classID] forKey:@"cls"];          //班级名称
                [tempArray addObject:tempObj];
                [tempObj release];
            }
        }
        self.info = tempArray;
        [tempArray release];
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






































