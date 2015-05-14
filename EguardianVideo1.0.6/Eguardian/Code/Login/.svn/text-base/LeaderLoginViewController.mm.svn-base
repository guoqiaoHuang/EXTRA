//
//  LeaderLoginViewController.m
//  Eguardian
//
//  Created by Deathman on 13-5-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LeaderLoginViewController.h"
#import "ProCityDataManager.h"
#import "LHomeViewController.h"
#import "Global.h"
#import "AppDelegate.h"
#import "LoginBaseViewController.h"
#import "ConfigManager.h"

@implementation LeaderLoginViewController

@synthesize passwordTextField = passwordTextField_;

@synthesize uname;
@synthesize pwd;

- (void)dealloc
{
    [loginActivity release];
    [uname release];
    [pwd release];
    [passwordTextField_ release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        self.loginedKey = User_LoginedUsers_Leaders;
        DELEGATE.loginType = self.loginedKey;
        [LoginBaseViewController setWasSwitchRole:YES];  //自动登录请求
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



-(void) loginWithUserName
{
    NSString *strUsername = self.uname;
    NSString *strPassword = self.pwd;
    NSString *strEPID = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_epid"];
    NSString *strIPAddress = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_addr"];
    
    int state = 0;

//    CUControlWrapper *tempWrapper = [[CUControlWrapper alloc] init];
//    [ConfigManager sharedConfigManager].wrapper = tempWrapper;
//    [tempWrapper release];
//    state = [[ConfigManager sharedConfigManager].wrapper login:strIPAddress port:28866 user:strUsername psd:strPassword epid:strEPID];
    if (state == 0)
    {
        [self storageLoginData];    //自动登录
        [ConfigManager sharedConfigManager].isLeader = YES;
        LHomeViewController *hv = [[LHomeViewController alloc] init];
        [self.navigationController pushViewController:hv animated:YES];
        [hv release];
    }
    else
    {
        [loginActivity stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉，密码或者用户名有误"
                                                       message:@"请您重新输入"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确认",nil];
        [alert show];
        [alert release];
    }
    
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    loginActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loginActivity.hidesWhenStopped = YES;
    loginActivity.center = self.view.center;
    [self.view addSubview:loginActivity];
    
    
    
    if ([self.loginedUsers count] > 0) {
        NSDictionary *user = [self.loginedUsers objectAtIndex:0];
        [self selectedUser:user];
        
        //        if (![LoginBaseViewController wasSwitchRole])
        //        {
        if (user)
        {
            [loginActivity startAnimating];
            //#warning        自动登录写在这里
            self.uname = [user objectForKey:@"UserNumber"];
            self.pwd = [user objectForKey:@"Password"];
            [self performSelector:@selector(loginWithUserName) withObject:nil afterDelay:0.5];
            //                [self loginWithUserName:[user objectForKey:@"UserNumber"] password:[user objectForKey:@"Password"]];
            
        }
        //        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)loginButtonClicked:(id)sender
{
    [loginActivity startAnimating];
    self.uname = self.userNameTextfield.text;
    self.pwd = self.passwordTextField.text;
    [self performSelector:@selector(loginWithUserName) withObject:nil afterDelay:0.5];
//    #warning 登录完成后执行方法：[self storageLoginData];
//    [self loginWithUserName:self.userNameTextfield.text password:self.passwordTextField.text];
}


- (NSDictionary *)userFromText {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.userNameTextfield.text,User_UserNumber,
            self.passwordTextField.text,User_Password,
            nil];
}

- (void)selectedUser:(NSDictionary *)user {    
    self.userNameTextfield.text = [user objectForKey:User_UserNumber];
    self.passwordTextField.text = [user objectForKey:User_Password];
    
    self.selectedUser = user;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [loginActivity stopAnimating];
}

@end
