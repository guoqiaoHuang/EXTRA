//
//  LoginViewController.m
//  ChildrenKeeper
//
//  Created by Deathman on 13-4-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  

#import "LoginViewController.h"
#import "SchoolPickedController.h"
#import "HomeViewController.h"
#import "ConfigManager.h"


#define GrayViewTag 0x32

@interface LoginViewController()

@property (nonatomic,copy) NSString         *schoolID;


- (void)updateCheckbox:(UIButton *)button byState:(NSInteger)state needStorage:(BOOL)needStorage;
- (void)storageLoginData;
- (void)sendRequest;

- (void)alertTitile:(NSString *)title message:(NSString *)message;

@end

@implementation LoginViewController

@synthesize schoolID = schoolID_;
@synthesize loginedUsers = loginedUsers_;
@synthesize selectedUser = selectedUser_;
@synthesize schoolTextfield = schoolTextfield_;
@synthesize numberTextfield = numberTextfield_;

- (void)alertTitile:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}

- (void)showLoginedUsersHistory {
    if (!loginedUsersController_.view.superview) {
        [self.view addSubview:loginedUsersController_.view];
    } else {
        [loginedUsersController_.view removeFromSuperview];
    }
}

- (void)showSchoolPiker {
    UIView *grayView = [[UIView alloc] initWithFrame:self.view.bounds];
    grayView.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.8f];
    grayView.tag = GrayViewTag;
    [self.view addSubview:grayView];
    [grayView release];
    
    CGRect rect = schoolPickedController_.view.frame;
    rect.origin = CGPointMake(0, 150);
    schoolPickedController_.view.frame = rect;
    [self.view addSubview:schoolPickedController_.view];
    
}

- (void)sendRequest {
    //make request
  
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
//    217001，217003，217004，217005
        
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@?action=login&school=%@&idcard=%@",
                           baseURL,
                           self.schoolID,
                           numberTextfield_.text];;
    
    
    [request setURL:[NSURL URLWithString:urlString]];
        
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.hidesWhenStopped = YES;
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    [activityView startAnimating];

    loginButton_.enabled = NO;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                              
                               if (error) {
                                   [self alertTitile:@"网络问题" message:@"网络连接错误"];
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                                   NSString *status = [jsonObject objectForKey:@"status"];
                                   
                                   if ([status isEqualToString:@"ok"]) {
//                                       NSLog(@"登录成功");
                                       [ConfigManager sharedConfigManager].loginKey = [jsonObject objectForKey:@"content"];
                                       
                                       HomeViewController *hv = [[HomeViewController alloc] init];
                                       [self.navigationController pushViewController:hv animated:YES];
                                       [hv release];
                                       [self storageLoginData];
                                   } else {
                                       [self alertTitile:@"登录失败"
                                                 message:[jsonObject objectForKey:@"content"]];
                                   }
                               }
                               
                               [activityView stopAnimating];
                               [activityView removeFromSuperview];
                               [activityView release];
                               
                               loginButton_.enabled = YES;
                           }];
}

- (void)updateCheckbox:(UIButton *)checkbox byState:(NSInteger)state needStorage:(BOOL)needStorage {
    checkbox.tag = state;
    if (state == 0) {
        [checkbox setImage:[UIImage imageNamed:@"uncheck.png"]
                  forState:UIControlStateNormal];
    } else {
        [checkbox setImage:[UIImage imageNamed:@"check.png"]
                  forState:UIControlStateNormal];
    }
    
    if (needStorage) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:state forKey:User_CheckAutoLogin];
        [userDefaults synchronize];
    }
}

- (void)selectedUser:(NSDictionary *)user {    
    schoolTextfield_.text = [user objectForKey:User_SchoolName];
    self.schoolID = [user objectForKey:User_SchoolID];
    numberTextfield_.text = [user objectForKey:User_UserNumber];
    
    self.selectedUser = user;
}

- (void)storageLoginData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.schoolID,User_SchoolID,
                          numberTextfield_.text,User_UserNumber,
                          schoolTextfield_.text,User_SchoolName,
                          nil];
    
    for (int i=0; i<[loginedUsers_ count]; i++) {
        if ([[loginedUsers_ objectAtIndex:i] isEqualToDictionary:user]) {
            [loginedUsers_ removeObject:user];
        }
    }
    [self.loginedUsers insertObject:user atIndex:0];
    while ([loginedUsers_ count]>3) {
        [loginedUsers_ removeLastObject];
    }
    
    [userDefaults setObject:loginedUsers_ forKey:User_LoginedUsers];
    [userDefaults synchronize];
    
    [self selectedUser:user];
}

#pragma mark - iOS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        schoolPickedController_ = [[SchoolPickedController alloc] init];
        schoolPickedController_.delegate = self;
        
//        loginedUsersController_ = [[LoginedUsersHistoryController alloc] init];
//        loginedUsersController_.loginViewController = self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [numberLabel_ release];
    [numberTextfield_ release];
    [autoLoginCheckbox_ release];
    [schoolPickedController_ release];
    [schoolTextfield_ release];
    [schoolID_ release];
    [loginedUsers_ release];
    [loginedUsersController_ release];
    [selectedUser_ release];
    [loginButton_ release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL autoLogin = [userDefaults boolForKey:User_CheckAutoLogin];
    [self updateCheckbox:autoLoginCheckbox_ byState:autoLogin needStorage:NO];
    
    self.loginedUsers = [NSMutableArray arrayWithArray:[userDefaults objectForKey:User_LoginedUsers]];
    
    if ([loginedUsers_ count] > 0) {
        NSDictionary *user = [loginedUsers_ objectAtIndex:0];
        [self selectedUser:user];
        if (autoLogin) {
            if (numberTextfield_.text.length>0 && schoolTextfield_.text.length>0 && self.schoolID.length>0) {
                [self sendRequest];
            }
        }
    }
    schoolTextfield_.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - IBAction

- (IBAction)loginButtonClicked:(id)sender {
    if (schoolTextfield_.text.length == 0) {
        [self alertTitile:@"提示" message:@"请选择学校"];
        return;
    } else if (numberTextfield_.text.length == 0) {
        [self alertTitile:@"提示" message:@"请填写学号"];
        return;
    }

    [self sendRequest];
    
    if (loginedUsersController_.view.superview) {
        [loginedUsersController_.view removeFromSuperview];
    }
}

- (IBAction)checkboxClicked:(id)sender {
    UIButton *checkbox = (UIButton *)sender;
    NSInteger state = checkbox.tag==0?1:0;
    [self updateCheckbox:checkbox byState:state needStorage:YES];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (loginedUsersController_.view.superview) {
        [loginedUsersController_.view removeFromSuperview];
    }
}

#pragma mark - SchoolPickedController delegate

- (void)schoolPickedSelectedSchool:(NSDictionary *)school {
    if (school) {
        self.schoolID = [school objectForKey:JSONKey_SchoolID];
        schoolTextfield_.text = [school objectForKey:JSONKey_School];
    }
        
    UIView *view = [self.view viewWithTag:GrayViewTag];
    [view removeFromSuperview];
}


@end
