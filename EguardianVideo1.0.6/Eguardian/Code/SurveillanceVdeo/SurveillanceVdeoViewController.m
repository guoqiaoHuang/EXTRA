//
//  SurveillanceVdeoViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-8-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SurveillanceVdeoViewController.h"
#import "SurveillanceVdeoPlayViewController.h"
#import "Global.h"
#import "ConfigManager.h"
#import "ProCityDataManager.h"
//#import "UINavigationController+Autorotate.h"

#define FlagImvTag 1000
#define TextLbTag 1001
#define TableViewTag 2000

@interface SurveillanceVdeoViewController ()

@end

@implementation SurveillanceVdeoViewController
@synthesize list;
@synthesize cmspInfo;
@synthesize vdeoIPAddress;
@synthesize vdeoUserName;
@synthesize vdeoPsw;

- (void)dealloc{
    self.list = nil;
    self.cmspInfo = nil;
    [titleArray release]; titleArray = nil;
    if(aQueue){
        dispatch_suspend(aQueue);
        dispatch_release(aQueue);
        aQueue = nil;
    }
    self.vdeoIPAddress = nil;
    self.vdeoUserName = nil;
    self.vdeoPsw = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self loginVdeo];
    
    //    [ProCityDataManager sharedProCityDataManager].schoolName
}

- (void)initData {
    //视频ip地址
    self.vdeoIPAddress = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_addr"];
    
    //获取视频登录账号
    //老师
    if ([DELEGATE.loginType isEqualToString:User_LoginedUsers_Teachers]) {
        self.vdeoUserName = [ProCityDataManager sharedProCityDataManager].schoolName;
    }
    //学生
    else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Parents]){
        self.vdeoUserName = [ProCityDataManager sharedProCityDataManager].schoolName;
    }
    //领导
    else if([DELEGATE.loginType isEqualToString:User_LoginedUsers_Leaders]){
        self.vdeoUserName = [DELEGATE getLoginName];
    }
    
    //获取视频登录密码
    self.vdeoPsw = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_pwd"];
    titleArray = [[NSMutableArray alloc] init];
    list = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)homeButtonPressed{
    
    if ([list count] > 1) {
        [list removeObjectAtIndex:[list count] - 1];
        [titleArray removeObjectAtIndex:[titleArray count] - 1];
        UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
        [tableview reloadData];
        self.title = [titleArray objectAtIndex:[titleArray count] -1 ];
    }else {
        [super homeButtonPressed];
    }
    
}

- (void)rightHomeButtonPressed {
    [super homeButtonPressed];
}

- (void)loginVdeo{
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [self.activityView startAnimating];
    //    aQueue = dispatch_queue_create("com.iphonedevblog.post", NULL);
    aQueue = dispatch_get_global_queue(0,0);
    dispatch_async(aQueue, ^{
        
        NSMutableArray *subList = [[NSMutableArray alloc] init];
        
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        //获取路线
        NSMutableArray *lineInfoList = [[NSMutableArray alloc] init];
        BOOL b = [vmsNetSDK getLineList:vdeoIPAddress toLineInfoList:lineInfoList];
        
        //控制中心
        NSMutableArray *controlUnitList = [[NSMutableArray alloc] init];
        
        if ([lineInfoList count] > 0) {
            
            //cms waiwang
            CLineInfo *lineInfo = [lineInfoList objectAtIndex:1];
            
            CMSPInfo *tmpcmspInfo = [[CMSPInfo alloc] init];
            b = [vmsNetSDK login:vdeoIPAddress toUserName:vdeoUserName toPassword:vdeoPsw toLineID:lineInfo.lineID toServInfo:tmpcmspInfo];
            self.cmspInfo = tmpcmspInfo;
            [tmpcmspInfo release];
            
            //控制中心 0
            b = [vmsNetSDK getControlUnitList:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:0 toNumPerOnce:10 toCurPage:1 toControlUnitList:controlUnitList];
            
        }
        [lineInfoList release]; lineInfoList = nil;
        
        if (b == YES && [controlUnitList count] > 0) {
            
            CControlUnitInfo *controlUnitInfo = [controlUnitList objectAtIndex:0];
            int controlUnitID = controlUnitInfo.controlUnitID;
            
            [controlUnitList release]; controlUnitList = nil;
            controlUnitList = [[NSMutableArray alloc] init];
            
            //控制中心
            b = [vmsNetSDK getControlUnitList:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:controlUnitID toNumPerOnce:10 toCurPage:1 toControlUnitList:controlUnitList];
            
            if (b == YES &&[controlUnitList count] > 0) {
                [subList addObjectsFromArray:controlUnitList];
            }
            
            NSMutableArray *regionList = [[NSMutableArray alloc] init];
            
            //区域
            b = [vmsNetSDK getRegionListFromCtrlUnit:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:controlUnitID toNumPerOnce:10 toCurPage:1 toRegionList:regionList];
            
            if (b == YES &&[regionList count] > 0) {
                [subList addObjectsFromArray:regionList];
            }
            [regionList release]; regionList = nil;
            [subList addObjectsFromArray:regionList];
            if ([subList count] > 0) {
                [list addObject:subList];
            }
            
        }
        
        [controlUnitList release]; controlUnitList = nil;
        [subList release]; subList = nil;
        
        NSLog(@"OK");
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            if ([list count] == 0) {
                [self  popPromptViewWithMsg:@"数据获取失败,请稍后再试" AndFrame:CGRectMake(0, 160, self.view.bounds.size.width, 30)];
            }
            UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
            [tableview reloadData];
            [titleArray addObject:self.title];
        });
    });
    
}

//控子中心
- (void)addSubControlUnitListWithID:(int) controlUnitID{
    dispatch_async(aQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        });
    });
    dispatch_async(aQueue, ^{
        
        NSMutableArray *subList = [[NSMutableArray alloc] init];
        //控制中心
        NSMutableArray *controlUnitList = [[NSMutableArray alloc] init];
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        BOOL b = [vmsNetSDK getControlUnitList:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:controlUnitID toNumPerOnce:10 toCurPage:1 toControlUnitList:controlUnitList];
        if (b == YES && [controlUnitList count] > 0) {
            [subList addObject:controlUnitList];
        }else if(b == NO){
            [self addSubregionListWithControlUnitID:controlUnitID];
        }
        NSMutableArray *regionList = [[NSMutableArray alloc] init];
        
        //区域
        b = [vmsNetSDK getRegionListFromCtrlUnit:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:controlUnitID toNumPerOnce:10 toCurPage:1 toRegionList:regionList];
        
        if (b == YES &&[regionList count] > 0) {
            [subList addObjectsFromArray:regionList];
        }
        [regionList release]; regionList = nil;
        if ([regionList count] > 0) {
            [list addObject:subList];
        }
        
        [controlUnitList release]; controlUnitList = nil;
        [subList release]; subList = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
            [tableview reloadData];
        });
    });
}

//获取区域
- (void)addSubregionListWithControlUnitID:(int)controlUnitID {
    
    dispatch_async(aQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        });
    });
    dispatch_async(aQueue, ^{
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        NSMutableArray *regionList = [[NSMutableArray alloc] init];
        BOOL b = [vmsNetSDK getRegionListFromCtrlUnit:vdeoIPAddress toSessionID:cmspInfo.sessionID toControlUnitID:controlUnitID toNumPerOnce:10 toCurPage:1 toRegionList:regionList];
        
        if (b == YES && [regionList count] > 0) {
            [list addObject:regionList];
        }
        [regionList release]; regionList = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
            [tableview reloadData];
        });
    });
}

//获取区域
- (void)addSubregionListRegionID:(int)regionID  {
    dispatch_async(aQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        });
    });
    
    
    dispatch_async(aQueue, ^{
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        NSMutableArray *regionList = [[NSMutableArray alloc] init];
        BOOL b = [vmsNetSDK getRegionListFromRegion:vdeoIPAddress toSessionID:cmspInfo.sessionID toRegionID:regionID toNumPerOnce:10  toCurPage:1 toRegionList:regionList];
        if (b == YES && [regionList count] > 0) {
            [list addObject:regionList];
        }else {
            [self addSubCameraListWithID:regionID];
        }
        [regionList release]; regionList = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
            [tableview reloadData];
        });
    });
}

//获取监控点信息
- (void)addSubCameraListWithID:(int) regionID{
    
    dispatch_async(aQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = NO;
            [self.view bringSubviewToFront:self.activityView];
            [self.activityView startAnimating];
        });
    });
    dispatch_async(aQueue, ^{
        VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
        NSMutableArray *cameraList = [[NSMutableArray alloc] init];
        BOOL b = [vmsNetSDK getCameraListFromRegion:vdeoIPAddress toSessionID:cmspInfo.sessionID toRegionID:regionID toNumPerOnce:8 toCurPage:1 toCameraList:cameraList];
        
        if (b == YES && [cameraList count] > 0) {
            [list addObject:cameraList];
        }
        [cameraList release]; cameraList = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
            [tableview reloadData];
        });
    });
}

- (NSArray *)getSubList {
    NSArray *subList = nil;
    NSInteger listCount = [list count];
    if (listCount > 0) {
        subList = [list objectAtIndex:listCount - 1];
    }
    return subList;
}

- (void)initView{
    [self addNavBack];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"首页" target:self action:@selector(rightHomeButtonPressed)]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [rightBarItem release];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"视频监控";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.viewHeight - 44) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = TableViewTag;
    [self.view addSubview:tableView];
    [tableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger listCount = [list count];
    if (listCount > 0) {
        //        NSDictionary *dic = [list objectAtIndex:listCount - 1];
        //        NSArray *keys = [dic allKeys];
        //        if (keys && [keys count] > 0) {
        //            NSString *key = [keys objectAtIndex:0];
        //            NSArray *subList = [dic objectForKey:key];
        //            return [subList count];
        //        }
        NSArray *subList = [list objectAtIndex:listCount - 1];
        return [subList count];
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier] autorelease];
        UIImageView *backImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_list_middel_bar"]];
        backImv.frame = cell.contentView.frame;
        cell.backgroundView = backImv;
        [backImv release];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //背景色设置
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_list_middel_bar_sel"]];
        selectedBackgroundView.frame = cell.contentView.frame;
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        UIImageView *flagImv = [[UIImageView alloc] init];
        flagImv.frame = CGRectMake(15, 7, 30, 30);
        [cell addSubview:flagImv];
        flagImv.tag = FlagImvTag;
        [flagImv release];
        
        UILabel *textLb = [[UILabel alloc] init];
        textLb.frame = CGRectMake(100, 11, 120, 20);
        textLb.tag = TextLbTag;
        textLb.textColor = [UIColor blackColor];
        textLb.textAlignment = NSTextAlignmentCenter;
        textLb.backgroundColor = [UIColor clearColor];
        [cell addSubview:textLb];
        [textLb release];
    }
    
    UIImageView *flagImv = (UIImageView *)[cell viewWithTag:FlagImvTag];
    
    UILabel *textLb = (UILabel *)[cell viewWithTag:TextLbTag];
    NSArray *subList = [self getSubList];
    id object = [subList objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CControlUnitInfo class]]) {
        CControlUnitInfo *info = object;
        textLb.text = info.name;
        flagImv.image = [UIImage imageNamed:@"list_center"];
    }else if([object isKindOfClass:[CRegionInfo class]]){
        CRegionInfo *info = object;
        textLb.text = info.name;
        flagImv.image = [UIImage imageNamed:@"list_region"];
    }else if([object isKindOfClass:[CCameraInfo class]]){
        CCameraInfo *info = object;
        textLb.text = info.name;
        flagImv.image = [UIImage imageNamed:@"video_list_qiangji_dis"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(aQueue){
        dispatch_suspend(aQueue);
        dispatch_release(aQueue);
        aQueue = nil;
        aQueue = aQueue = dispatch_get_global_queue(0,0);
    }
    NSArray *subList = [self getSubList];
    id object = [subList objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CControlUnitInfo class]]) {
        CControlUnitInfo *info = object;
        if (info.controlUnitID != -1) {
            [self addSubControlUnitListWithID:info.controlUnitID];
            self.title = info.name;
            [titleArray addObject:self.title];
        }
    }else if([object isKindOfClass:[CRegionInfo class]]){
        CRegionInfo *info = object;
        [self addSubregionListRegionID:info.regionID];
        self.title = info.name;
        [titleArray addObject:self.title];
    }else if ([object isKindOfClass:[CCameraInfo class]]){
        CCameraInfo *info = object;
        //获取设备信息
        SurveillanceVdeoPlayViewController *next = [[SurveillanceVdeoPlayViewController alloc] initWithCCameraInfo:info SessionID:cmspInfo.sessionID];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
}

@end
