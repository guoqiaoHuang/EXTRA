//
//  THWorkProcessViewController.m
//  Eguardian
//
//  Created by apple on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TNoticeDetailController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ConfigManager.h"

@interface TNoticeDetailController ()

@end

@implementation TNoticeDetailController
@synthesize inputView;
@synthesize info;

- (void)dealloc
{
    [info release];
    [inputView release];
    [super dealloc];
}

-(void)rightAction
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                   message:@"你确定删除这条记录吗"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确认",nil];
    
    
    [alert show];
    [alert release];
}

#pragma mark 删除判断
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( 1 == buttonIndex)
    {
        //删除记录信息
        NSString *tempURL = [ConfigManager getDeleteTNoticeWithID: [info objectForKey:@"id"] ];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:tempURL]];
        NSURLResponse *response;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                           message:@""
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"删除出错",nil];
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
                [self backAction];
            } else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                               message:@""
                                                              delegate:nil
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"删除出错",nil];
                [alert show];
                [alert release];
            }
        }
        
    }
    
}









-(id) initWithTitle:(NSString *)title data:(NSDictionary *)adata
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.info = adata;
    }
    return self;
}





-(void) searchAction
{
    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:app.displayPanel];
    app.displayPanel.hidden = NO;
    

    app.displayPanel.panel.text = [info objectForKey:@"title"];
    
    app.displayPanel.panel.textColor = [UIColor blackColor];
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
        UIImage* image= [UIImage imageNamed:@"删除.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* RButton= [[UIButton alloc] initWithFrame:frame_1];
        [RButton setBackgroundImage:image forState:UIControlStateNormal];
        [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [RButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:RButton];
        [self.navigationItem setRightBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [RButton release];
    }
    
    currentH = 0;

    
    
    
    {
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"T标题输入框背景.png"]];
        tempImageView.userInteractionEnabled = YES;
        tempImageView.frame = CGRectMake( (self.view.frame.size.width - tempImageView.frame.size.width)/2.0 ,
                                         currentH + 14, tempImageView.frame.size.width, tempImageView.frame.size.height);
        UILabel *testLable = [[UILabel alloc] initWithFrame:CGRectMake(100, (tempImageView.frame.size.height -15)/2.0, 200, 15)];
        testLable.backgroundColor = [UIColor clearColor];
        testLable.text = [info objectForKey:@"title"];
        [tempImageView addSubview:testLable];
        [testLable release];
        
        currentH = tempImageView.frame.origin.y + tempImageView.frame.size.height;
        
        
        
        UIButton* searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.frame = CGRectMake(0, 0, tempImageView.frame.size.width, tempImageView.frame.size.height);
        [searchButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [tempImageView addSubview:searchButton];
        [self.view addSubview:tempImageView]; [tempImageView release];
        
    }
    
    {
        inputView = [[UITextView alloc] initWithFrame:CGRectMake( (self.view.frame.size.width - 300)/2.0 , currentH+7, 300, 140)];
        inputView.layer.cornerRadius = 10;
        inputView.editable = NO;
        inputView.font = [UIFont fontWithName:@"Arial" size:15];
        inputView.text = [info objectForKey:@"content"];
        [self.view addSubview:inputView];
        currentH = inputView.frame.origin.y + inputView.frame.size.height;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end