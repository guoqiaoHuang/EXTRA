//
//  CheckWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FamilyEducationController.h"

#import "Global.h"



#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "DisplayPanel.h"
#import "ADScrollView.h"


@interface FamilyEducationController ()

@end

@implementation FamilyEducationController


- (void)dealloc
{

    [super dealloc];
}






//*******************************************************************************************************************************************
//*******************************************************************************************************************************************
//strar






-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 5;
        self.title = @"家校互动";
    }
    return self;
}


//end
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************






-(void)viewWillAppear:(BOOL)animated
{
    
    if (!self.isFirst) return;
    self.isFirst = FALSE;
    
    
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
    
    

        UIView *tempBG = [[UIView alloc] initWithFrame:self.view.frame];
        tempBG.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [self.view addSubview:tempBG];
    
    
    {
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"T家教互动效果图.jpg"]];
        [tempBG addSubview:tempImageView];
        [tempImageView release];
    }
    
    
    
    
    {
        UIImage *tempImg = [UIImage imageNamed:@"T家教互动底部图片.jpg"];
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:tempImg];
        tempImageView.frame = CGRectMake(0, (tempBG.frame.size.height-tempImg.size.height-navh), tempImg.size.width, tempImg.size.height);
        [tempBG addSubview:tempImageView];
        [tempImageView release];
    }
    

    
    

    [tempBG release];
    

    
}























@end































































