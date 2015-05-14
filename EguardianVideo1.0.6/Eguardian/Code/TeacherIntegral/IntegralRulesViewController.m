//
//  IntegralRulesViewController.m
//  Eguardian
//
//  Created by S.C.S on 13-9-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "IntegralRulesViewController.h"

@interface IntegralRulesViewController ()

@end

@implementation IntegralRulesViewController

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
	// Do any additional setup after loading the view.
}

- (void)initView{
    self.title = @"积分规则";
    [self addNavBack];
    UIImageView *imv = [[UIImageView alloc] init];
    UIImage *tempImag = [UIImage imageNamed:@"002积分系统_3积分规则.png"];
    CGRect tempRect = CGRectMake(0, 0, tempImag.size.width, tempImag.size.height);
    imv.image = tempImag;
    imv.frame = tempRect;
    [self.view addSubview:imv];
    [imv release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
