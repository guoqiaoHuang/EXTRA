//
//  NameViewController.m
//  Eguardian
//
//  Created by apple on 13-5-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NameViewController.h"
#import "Global.h"
#import "NetTools.h"
#import "ConfigManager.h"
#import "JSONProcess.h"




@interface NameViewController ()

@end

@implementation NameViewController
@synthesize namesTable;
@synthesize message;
@synthesize studentArray;
@synthesize selectDic;
@synthesize delegate;


@synthesize filteredArray;
@synthesize nameManager;
@synthesize sectionRow;
@synthesize isOneSelect;

-(void) selectAllNames
{
    
    if (self.nameManager.pinyinArray.count <= 0 )
        return;
    
    
    UIImage* image = nil;
    if (selectFlag)
    {
        image= [UIImage imageNamed:@"T不全选.png"];
    }
    else
    {
        image= [UIImage imageNamed:@"T全选.png"];
    }
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* RButton= [[UIButton alloc] initWithFrame:frame_1];
    [RButton setBackgroundImage:image forState:UIControlStateNormal];
    [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [RButton addTarget:self action:@selector(selectAllNames) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:RButton];
    [self.navigationItem setRightBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    [RButton release];

    
    
    
    for ( int i=0; i<self.nameManager.pinyinArray.count; i++)
    {
        int indexPathCount = [self.nameManager nameCountWithSection:i];
        
        
        for (int j=0; j<indexPathCount; j++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UITableViewCell *cell = (UITableViewCell*)[self.namesTable cellForRowAtIndexPath:indexPath];
            UIImageView *tempView = (UIImageView *)[cell viewWithTag:91];
            
            NSString *sectionAndRow = [[NSString alloc] initWithFormat:@"%d#%d",indexPath.section,indexPath.row];
            NSNumber *numberBool;
            
            if (selectFlag)
            {
                tempView.hidden = NO;
                numberBool = [NSNumber numberWithBool:YES];
            }
            else
            {
                tempView.hidden = YES;
                numberBool = [NSNumber numberWithBool:NO];
            }
            
            [self.sectionRow setObject:numberBool forKey:sectionAndRow];
            [sectionAndRow release];
        }
    }
    
    
    
    
    
    
    
    
    
    if ( selectFlag )
    {
        [selectDic removeAllObjects];
        for ( int i=0; i<self.nameManager.pinyinArray.count; i++)
        {
            NSArray *sectionArray = [self.nameManager.namesDictionary objectForKey: [self.nameManager.pinyinArray objectAtIndex:i] ];
            for (int i=0; i<sectionArray.count; i++)
            {
                NSDictionary *tempUserMessage = [sectionArray objectAtIndex:i];
                [selectDic setObject:tempUserMessage forKey:[tempUserMessage objectForKey:@"id"]];
            }
        }
    }
    else
        [selectDic removeAllObjects];
    
    selectFlag = !selectFlag;
    
    
}


- (void)dealloc
{

    [sectionRow release];
    [delegate release];
    [selectDic release];
    [studentArray release];
    [message release];
    [namesTable release];
    [nameManager release];
    [super dealloc];
}

-(id) initWithTitle:(NSString *)title data:(NSDictionary *)amessage delegate:(id)adelegate
{
    self = [super init];
    if (self)
    {
        self.message = amessage;
        self.title = title;
        selectFlag = TRUE;
        selectDic = [[NSMutableDictionary alloc] init];
        self.delegate = adelegate;
        nameManager = [[NameManager alloc] init];
        sectionRow = [[NSMutableDictionary alloc] init];

    }
    return self;
}

//确定按钮
- (void)surePressedBtn{
    
    [self backAction];
}

-(void)backAction
{
    [self.delegate selectNamesFinsh:self.selectDic];
    UINavigationController *nav = rootNav;
    for (int i=0; i<2; i++)
    {
        [nav popViewControllerAnimated:NO];
    }
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
    if (isOneSelect == NO) {
        //右边按钮
        {
            UIImage* image= [UIImage imageNamed:@"T全选.png"];
            CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
            UIButton* RButton= [[UIButton alloc] initWithFrame:frame_1];
            [RButton setBackgroundImage:image forState:UIControlStateNormal];
            [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [RButton addTarget:self action:@selector(selectAllNames) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:RButton];
            [self.navigationItem setRightBarButtonItem:someBarButtonItem];
            [someBarButtonItem release];
            [RButton release];
        }
    }
       
    
    self.navigationController.navigationBarHidden = NO;
    float navh = self.navigationController.navigationBar.frame.size.height;
    
    float tempBGImgH = 0;
    {
        UIImage *tempBGImg = [UIImage imageNamed:@"T选择学生背景.png"];
        tempBGImgH = tempBGImg.size.height;
        UIImageView *tempBGView = [[UIImageView alloc] initWithImage:tempBGImg];
        tempBGView.frame = CGRectMake(0,self.view.frame.size.height-tempBGImg.size.height-navh,
                                      ScreenW, tempBGImg.size.height);
        tempBGView.userInteractionEnabled = YES;
        
        UIImage *btImg = [UIImage imageNamed:@"T选择确定.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake( (tempBGView.frame.size.width - btImg.size.width)/2.0,
                                  (tempBGView.frame.size.height - btImg.size.height)/2.0,
                                  btImg.size.width, btImg.size.height);
        
        UIImageView *btImgView = [[UIImageView alloc] initWithImage:btImg];
        btImgView.frame = CGRectMake(0, 0, btImg.size.width, btImg.size.height);
        [button addSubview:btImgView];
        [btImgView release];
        
//        button.backgroundColor = [UIColor clearColor];
        [tempBGView addSubview:button];
        [button addTarget:self action:@selector(surePressedBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempBGView];
        [tempBGView release];
        
    }
    
    

    
    {
//        CGRect tempRect = CGRectMake(0, searchBar.frame.size.height, ScreenW, (ScreenH - navh - searchBar.frame.size.height- tempBGImgH));
        CGRect tempRect = CGRectMake(0, 0, ScreenW, (ScreenH - navh - tempBGImgH));
        namesTable = [[UITableView alloc] initWithFrame:tempRect  style:UITableViewStylePlain];
        namesTable.rowHeight = 48;
        self.namesTable.delegate = self;
        self.namesTable.dataSource = self;
        namesTable.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.namesTable];
	}


    
    
}







-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;    
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH );
    
    if ( nil == self.studentArray) 
    {
        //下载数据
        NSString *tempURL = [ConfigManager getStudentsWithGradeID:[message objectForKey:@"gradeID"] classID:[message objectForKey:@"classID"]];
        NetTools *tools = [[NetTools alloc] initWithURL:tempURL delegate:self];
        [tools download];
        [tools release];
        
        self.activityView.hidden = NO;
        [self.view bringSubviewToFront:self.activityView];
        [self.activityView startAnimating];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}














-(void)initCustomCell:(UITableViewCell *)cell
{
    
    UIColor *tempColor = [UIColor colorWithRed:143/255.0 green:136/255.0 blue:130/255.0 alpha:1.0];
    UIImageView *cellBg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"CellBG.png"] ];
    cellBg.frame = CGRectMake(0, 0, ScreenW, self.namesTable.rowHeight);
    
    
    
    {
        //内容
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 0, 260, cell.frame.size.height)];
        label.textColor = tempColor;
        label.tag = 90;
        label.backgroundColor = [UIColor clearColor];
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


#pragma mark 设置区域
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return [[self.nameManager.namesDictionary allKeys] count];
}




#pragma mark 对应区域的 列表大小
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nameManager nameCountWithSection:section];
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

    
    NSString *crayon;	
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    
    //这个有Bug
    crayon = [self.nameManager findNameWithSection:indexPath.section index:indexPath.row];
    ptable.text = crayon;
    
    
    
    
    NSString *sectionAndRow = [[NSString alloc] initWithFormat:@"%d#%d",indexPath.section,indexPath.row];
    NSNumber *numberBool = [self.sectionRow objectForKey:sectionAndRow];
    [sectionAndRow release];
    BOOL showFlag = ![numberBool boolValue];
    
    UIImageView *tempView = (UIImageView *)[cell viewWithTag:91];
    tempView.hidden = showFlag;
    
    return cell;
}


#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [atableView cellForRowAtIndexPath:indexPath];
    UIImageView *tempView = (UIImageView *)[cell viewWithTag:91];
    
    NSDictionary *userMessage;
    userMessage = [self.nameManager findUserMessageWithSection:indexPath.section index:indexPath.row];
    
    NSString *sectionAndRow = [[NSString alloc] initWithFormat:@"%d#%d",indexPath.section,indexPath.row];
    NSNumber *numberBool;
    
    //如果只能选择一个的，先把记录删除，再添加一个记录
    if (isOneSelect == YES) {
        [selectDic removeAllObjects];
        [sectionRow removeAllObjects];
    }
    if (tempView.hidden)
    {
        [selectDic setObject:userMessage forKey:[userMessage objectForKey:@"id"]];
        tempView.hidden = NO;
        numberBool = [NSNumber numberWithBool:YES];
        
    }
    else
    {
        [selectDic removeObjectForKey:[userMessage objectForKey:@"id"]];
        tempView.hidden = YES;
        numberBool = [NSNumber numberWithBool:NO];
        
    }
    [self.sectionRow setObject:numberBool forKey:sectionAndRow];
    [sectionAndRow release];
    
    
    
    
    if ( self.selectDic.count == self.studentArray.count)
    {

        UIImage* image= [UIImage imageNamed:@"T不全选.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* RButton= [[UIButton alloc] initWithFrame:frame_1];
        [RButton setBackgroundImage:image forState:UIControlStateNormal];
        [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [RButton addTarget:self action:@selector(selectAllNames) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:RButton];
        [self.navigationItem setRightBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [RButton release];
        selectFlag = FALSE;
    }
    
    [atableView reloadData];
}


#pragma mark 设置区域标题名称
- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{

    return [self.nameManager.pinyinArray objectAtIndex:section];

}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    
    return self.nameManager.pinyinArray;
}




//**************************************************************************************************************
//**************************************************************************************************************
//Net delegate
- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    NSDictionary *jsonData = [JSONProcess JSONProcess:tempData];
    if ( [@"ok" isEqualToString:[jsonData objectForKey:@"status"]]   )
    {        
        self.studentArray = [jsonData objectForKey:@"content"];
        if (self.studentArray.count >0 )
        {
            [nameManager processWithNames:self.studentArray];
            [nameManager sortWithChar];
            [nameManager insertNamesArray];
        }
        
        
    }
    
    
    
    
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self.namesTable reloadData];
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































































