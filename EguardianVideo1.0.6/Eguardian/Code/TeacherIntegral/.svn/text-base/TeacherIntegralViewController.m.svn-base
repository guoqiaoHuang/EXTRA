//
//  TeacherIntegralViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-8-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TeacherIntegralViewController.h"
#import "ConfigManager.h"
#import "ADScrollView.h"
#import "NSDictionary+Extemsions.h"
#import "CommonTools.h"
#import "IntegralRulesViewController.h"

#define TableViewTag 1000
#define SchoolnameLbtag 2000
#define CardidLbTag 2001
#define TscoreLbTag   2002

@interface TeacherIntegralViewController ()

@end

@implementation TeacherIntegralViewController
@synthesize integralDic;
@synthesize leftBtn;
@synthesize rightBtn;

- (void)dealloc{
    self.integralDic = nil;
    self.leftBtn = nil;
    self.rightBtn = nil;
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

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self netWork];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTeacherIntegralViewController:) name:NotificationTeacherIntegralViewController object:nil];
}

- (void)initView{
     [self addNavBack];
    
//    UIBarButtonItem *clearMessage=[[UIBarButtonItem alloc] initWithCustomView:[CommonTools navigationItemBtnInitWithTitle:@"积分规则" target:self action:@selector(rightBarButtonPressed)]];
//    self.navigationItem.rightBarButtonItem = clearMessage;
//    [clearMessage release];
    
    for ( int i = 0; i< 2; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image = nil;
        UIImage *selectImage = nil;
        [bt addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag = i;
        selectImage = [UIImage imageNamed:@"Main_Top_Bt.png"];
        image = [UIImage imageNamed:@"Main_Top_Bt_S.png"];
        if (i == 0) {
            bt.selected = YES;
            bt.frame = CGRectMake(0, 0  , 160, 44);
            [bt setTitle:@"老师排名" forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.leftBtn = bt;
        }else if(i == 1){
            bt.selected = NO;
            bt.frame = CGRectMake(160, 0  , 160, 44);
            [bt setTitle:@"我的积分" forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn = bt;
        }
        [bt setBackgroundImage: [image stretchableImageWithLeftCapWidth:21 topCapHeight:7] forState:UIControlStateNormal];
        [bt setBackgroundImage: [selectImage stretchableImageWithLeftCapWidth:21 topCapHeight:7] forState:UIControlStateSelected];
        
       
        [self.view addSubview:bt];
    }
    
    {
        adScrollView = [[ADScrollView alloc] initWithName:@"notice" delegate:self];
        [self.view addSubview:self.adScrollView];
    }
    
    //设置adScrollView 宽高
    float tempW = (self.view.frame.size.width - self.adScrollView.frame.size.width)/2.0;
    float tempH = self.view.frame.size.height-44 - self.adScrollView.frame.size.height;
    self.adScrollView.frame = CGRectMake(tempW, tempH, self.adScrollView.frame.size.width, self.adScrollView.frame.size.height);
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"积 分";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0, 320.0f, self.viewHeight - 88.0 - self.adScrollView.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = TableViewTag;
    [self.view addSubview:tableView];
    [tableView release];
}

//网络请求
- (void)netWork{
    NSString *tempURL = [ConfigManager getCheckTeacherIntegral];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NotificationTeacherIntegralViewController,NotificationKey, nil];
    [self requestWithURL:tempURL UserInfo:userInfo Model:PartViewModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)rightBarButtonPressed{
    IntegralRulesViewController *next = [[IntegralRulesViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

#pragma mark -
#pragma mark  按钮事件
//上面的两个左右按钮
- (void)pressedButton:(UIButton *)bt {
    NSInteger tag = bt.tag;
    UITableView  *table = (UITableView  *)[self.view viewWithTag:TableViewTag];
    //服务列表
    if (tag == 0) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    //我的服务
    else if(tag == 1){
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    [table reloadData];
}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (leftBtn.selected == YES) {
        NSArray *array = [integralDic objectForKey:@"list"];
        if (array) {
            count = [array count];
        }
    }else if(rightBtn.selected == YES){
        count = 2;
    }
    return count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TeacherIntegralViewControllerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier] autorelease];
        [self initCustomCell:cell];
        
    }
    UILabel *titleNameLb = (UILabel *)[cell.contentView viewWithTag:SchoolnameLbtag];
    UILabel *cardidLb = (UILabel *)[cell.contentView viewWithTag:CardidLbTag];
    UILabel *tscoreLb = (UILabel *)[cell.contentView viewWithTag:TscoreLbTag];
    
    if (leftBtn.selected == YES) {
        NSArray *listArray = [integralDic objectForKey:@"list"];
        NSDictionary *dic = [listArray objectAtIndex:indexPath.row];
        if (titleNameLb) {
            titleNameLb.text = [dic objectJudgeFullForKey:@"schoolname"];
        }
        cardidLb.hidden = NO;
        if (cardidLb) {
            cardidLb.text = [dic objectJudgeFullForKey:@"cardid"];
            
        }
        if (tscoreLb) {
            tscoreLb.text = [dic objectJudgeFullForKey:@"tscore"];
        }
    }else if(rightBtn.selected == YES)  {
        if (titleNameLb) {
            if (indexPath.row == 0) {
                 titleNameLb.text = @"我的本学期积分";
            }else if(indexPath.row == 1){
                 titleNameLb.text = @"我的总积分";
            }
           
        }
        cardidLb.hidden = YES;
        if (tscoreLb) {
            if (indexPath.row == 0) {
                tscoreLb.text = [integralDic objectJudgeFullForKey:@"info"];
            }else if(indexPath.row == 1){
                tscoreLb.text = [integralDic objectJudgeFullForKey:@"total"];
            }
        }

    }
    
    return cell;
}

-(void)initCustomCell:(UITableViewCell *)cell
{
    //背景色设置
    UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_list_middel_bar_sel"]];
    selectedBackgroundView.frame = cell.contentView.frame;
    cell.selectedBackgroundView = selectedBackgroundView;
    [selectedBackgroundView release];
    
    float tempY = 12;
    float tempH = 20;
    float leftX = 10;
    
    UIColor *tempColor = [UIColor colorWithRed:143/255.0 green:136/255.0 blue:130/255.0 alpha:1.0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];

    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 130, tempH)];
        label.textColor = tempColor;
        label.tag = SchoolnameLbtag;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        leftX += label.frame.size.width ;
         [label release];
    }
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 120, tempH)];
        label.textColor = tempColor;
        label.tag = CardidLbTag;
        UIFont *afont = [UIFont fontWithName:@"Arial" size:13];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = afont;
        [cell.contentView addSubview:label]; 
        leftX += label.frame.size.width ;
        [label release];
    }
    
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftX, tempY, 45, tempH)];
        label.textColor = tempColor;
        label.tag = TscoreLbTag;
        UIFont *afont = [UIFont fontWithName:@"Arial" size:13];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = afont;
        [cell.contentView addSubview:label]; [label release];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -
#pragma mark 积分请求返回
- (void)notificationTeacherIntegralViewController:(NSNotification*) notification{
    NSDictionary *tmp = [notification.userInfo objectForKey:@"content"];
    if (tmp) {
        self.integralDic = tmp;
        UITableView *tableview = (UITableView *)[self.view viewWithTag:TableViewTag];
        [tableview reloadData];
    }
    
}

@end
