//
//  WebViewController.m
//  Eguardian
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "WebViewController.h"
#import "Global.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize url;
@synthesize webView;


- (void)dealloc
{
    [url release];
    [webView release];
    [super dealloc];
}

-(id) initWithURL:(NSString *)aurl
{
    self = [super init];
    
    if (self)
    {
        self.url = aurl;
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
    
    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH );
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






















































