//
//  LoginBaseViewController.m
//  CampusManager
//
//  Created by Deathman on 13-4-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginBaseViewController.h"
#import "HomeViewController.h"
#import "LocationTableViewController.h"
#import "THomeViewController.h"
#import "ProvinceController.h"
#import "ProCityDataManager.h"
#import "Global.h"


#define GrayViewTag 0x32

static BOOL wasSwitchRole = NO;

@interface LoginBaseViewController ()

- (void)updateCheckbox:(UIButton *)button byState:(NSInteger)state needStorage:(BOOL)needStorage;
- (void)alertTitile:(NSString *)title message:(NSString *)message;
- (void)gotoRolesHome;
@end

@implementation LoginBaseViewController

@synthesize schoolID = schoolID_;
@synthesize loginedUsers = loginedUsers_;
@synthesize selectedUser = selectedUser_;
@synthesize schoolTextfield = schoolTextfield_;
@synthesize userNameTextfield = userNameTextfield_;
@synthesize delegate = delegate_;
@synthesize loginedKey = loginedKey_;


+ (BOOL)wasSwitchRole {
    return wasSwitchRole;
}


+ (void)setWasSwitchRole:(BOOL)flag
{
    wasSwitchRole = flag;
}


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

- (void)gotoRolesHome
{
    NSString *urlString = nil;
    if ([self.loginedKey isEqualToString:User_LoginedUsers_Parents])
        urlString = [[ConfigManager getParantMessage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    else if ([self.loginedKey isEqualToString:User_LoginedUsers_Teachers])
        urlString = [[ConfigManager getTeacherMessage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    {
        NSDictionary *user = [self userFromText];
        [ProCityDataManager sharedProCityDataManager].schoolName = [user objectForKey:@"SchoolName"];
//        NSLog(@"学校名称 测试 ---  %@",[user objectForKey:@"SchoolName"]);
    }
    
    
    {
        //用户绑定和记录绑定后的信息
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSURLResponse *response;
        NSError *error = nil;
        NSData *message = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil
                                                 otherButtonTitles:@"获取登录信息失败",nil];
            [alert show];
            [alert release];
            return;
        }
        
        NSError *parseError = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:message options:NSJSONReadingAllowFragments error:&parseError];
        if (parseError)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil
                                                 otherButtonTitles:@"获取登录信息失败",nil];
            [alert show];
            [alert release];
            return;
        }
        
        NSString *status = [jsonObject objectForKey:@"status"];
        if ([@"ok" isEqualToString:status])
        {
            [ConfigManager sharedConfigManager].userMessage = [jsonObject objectForKey:@"content"];
        } else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil
                                                 otherButtonTitles:@"获取登录信息失败",nil];
            [alert show];
            [alert release];
            return;
        }
    }
    
    
    if ([self.loginedKey isEqualToString:User_LoginedUsers_Parents])
    {
        {
            // 发送touken
            NSDictionary *user = [self userFromText];
            NSString *tempSchoolID = [user objectForKey:@"SchoolID"];
            NSString *tempUserNumber = [user objectForKey:@"UserNumber"];
            NSString *tempUserNmae = [[ConfigManager sharedConfigManager].userMessage objectForKey:@"sname"];
            
            NSString *registerUrl = [[ConfigManager sharedConfigManager].configData objectForKey:@"register_path"];
            NSString *result = [NSString stringWithFormat:@"%@?type=student&schoolid=%@&userid=%@&username=%@&deviceToken=%@",
                                    registerUrl,tempSchoolID,tempUserNumber,tempUserNmae,[ConfigManager sharedConfigManager].deviceToken];
                
            
//            NSLog(@"初始化信息 %@",[ConfigManager sharedConfigManager].configData);
            
            NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
            [request addValue: [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"]
           forHTTPHeaderField:[[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_name"]];
            NSString *urlString =  [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            [request setURL:url];

            NSError *error;
            [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//        NSData *rsData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//        NSError *parseError = nil;
//        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:rsData options:NSJSONReadingAllowFragments error:&parseError];
//            NSLog(@" jsonObject is %@",jsonObject);
            
        }
        
        

        HomeViewController *hv = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:hv animated:YES];
        [hv release];
    } else if ([self.loginedKey isEqualToString:User_LoginedUsers_Teachers])
    {
        THomeViewController *hv = [[THomeViewController alloc] init];
        [self.navigationController pushViewController:hv animated:YES];
        [hv release];
    }
    
}

- (void)sendLoginRequest {
    //make request
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSString *urlString =  [[self loginRequestURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    [request setURL:url];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.hidesWhenStopped = YES;
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    [activityView startAnimating];
    
    loginButton_.enabled = NO;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (error)
                               {
                                   [self alertTitile:@"网络问题" message:@"网络连接错误"];
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                                   NSString *status = [jsonObject objectForKey:@"status"];
                                   
                                   if ([status isEqualToString:@"ok"]) {
                                       //                                       NSLog(@"登录成功 %@",jsonObject);
                                       [ConfigManager sharedConfigManager].loginKey = [jsonObject objectForKey:@"content"];
                                       
                                       [self gotoRolesHome];
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
    
    state = YES;
    checkbox.selected = state;
    
    if (needStorage) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:state],
                              User_AutoLoginCheck,
                              NSStringFromClass(self.class),
                              User_AutoLoginRole,
                              nil];
        
        [userDefaults setObject:dict forKey:User_AutoLogin];
        [userDefaults synchronize];
    }
}

- (NSDictionary *)userFromText {
    return nil;
}

- (void)selectedUser:(NSDictionary *)user {
    
}

- (void)storageLoginData
{
    NSDictionary *user = [self userFromText];
    for (int i=0; i<[loginedUsers_ count]; i++) {
        if ([[loginedUsers_ objectAtIndex:i] isEqualToDictionary:user]) {
            [loginedUsers_ removeObject:user];
        }
    }
    [self.loginedUsers insertObject:user atIndex:0];
    while ([loginedUsers_ count]>3) {
        [loginedUsers_ removeLastObject];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:loginedUsers_ forKey:loginedKey_];
    [userDefaults synchronize];
    [self updateCheckbox:autoLoginCheckbox_ byState:autoLoginCheckbox_.selected needStorage:YES];
    [self selectedUser:user];
}

#pragma mark - iOS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        loginedUsersController_ = [[LoginedUsersHistoryController alloc] init];
        loginedUsersController_.loginViewController = self;
        
        schoolPickedController_ = [[SchoolPickedController alloc] init];
        schoolPickedController_.delegate = self;
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [userNameTextfield_ release];
    [autoLoginCheckbox_ release];
    [schoolTextfield_ release];
    [schoolID_ release];
    [loginedUsers_ release];
    [loginedUsersController_ release];
    [selectedUser_ release];
    [loginButton_ release];
    [schoolPickedController_ release];
    [loginedKey_ release];
    self.delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults dictionaryForKey:User_AutoLogin];
    BOOL autoLogin = [[dict objectForKey:User_AutoLoginCheck] boolValue];
    [self updateCheckbox:autoLoginCheckbox_ byState:autoLogin needStorage:NO];
    
    autoLogin = YES;
    
    NSArray *loginedArray = [userDefaults objectForKey:loginedKey_];
    if (loginedArray) {
        self.loginedUsers = [NSMutableArray arrayWithArray:loginedArray];
    } else {
        self.loginedUsers = [NSMutableArray arrayWithCapacity:3];
    }
    
    if ([loginedUsers_ count] > 0) {
        NSDictionary *user = [loginedUsers_ objectAtIndex:0];
        [self selectedUser:user];
        
        if (autoLogin && !wasSwitchRole)
        {
            if (user) {
                [self sendLoginRequest];
            }
        }
    }
    schoolTextfield_.enabled = NO;
    userNameTextfield_.delegate = self;
    
    //键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    self.schoolTextfield.text = [ProCityDataManager sharedProCityDataManager].schoolName;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.schoolTextfield = nil;
    self.userNameTextfield = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - IBAction

- (IBAction)switchRole:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    enum LoginRole role;
    switch (button.tag) {
        case 1:
            role = LoginRoleParents;
            break;
        case 2:
            role = LoginRoleTeacher;
            break;
        case 3:
            role = LoginRoleLeader;
            break;
        default:
            role = LoginRoleParents;
            break;
    }
    if (delegate_ && [delegate_ respondsToSelector:@selector(loginViewController:switchRole:)]) {
        [self.delegate loginViewController:self switchRole:role];
    }
    
    wasSwitchRole = YES;
    
}

- (IBAction)chooseSchool:(id)sender {
    //    LocationTableViewController *locationController = [[LocationTableViewController alloc] initWithLocationType:LocationTypeProvince];
    //    [self.navigationController pushViewController:locationController animated:YES];
    //    [locationController release];
    
    //    UIView *grayView = [[UIView alloc] initWithFrame:self.view.bounds];
    //    grayView.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.8f];
    //    grayView.tag = GrayViewTag;
    //    [self.view addSubview:grayView];
    //    [grayView release];
    //
    //    CGRect rect = schoolPickedController_.view.frame;
    //    rect.origin = CGPointMake(0, 150);
    //    schoolPickedController_.view.frame = rect;
    //    [self.view addSubview:schoolPickedController_.view];
    
    //    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    
    ProvinceController *pro = [[ProvinceController alloc] init];
    [self.navigationController pushViewController:pro animated:YES];
    //    NSLog(@"%@",self.navigationController.viewControllers);
    [pro release];
    
    
    
    //    http://api.shouhubao365.com/index.php?action=prov_city
    
    
    
    
    
    
}

- (IBAction)loginButtonClicked:(id)sender {
    if (schoolTextfield_.text.length == 0) {
        [self alertTitile:@"提示" message:@"请选择学校"];
        return;
    } else if (userNameTextfield_.text.length == 0) {
        [self alertTitile:@"提示" message:@"请填写学号"];
        return;
    }
    
    [self sendLoginRequest];
    
    if (loginedUsersController_.view.superview) {
        [loginedUsersController_.view removeFromSuperview];
    }
}

- (IBAction)checkboxClicked:(id)sender {
    UIButton *checkbox = (UIButton *)sender;
    [self updateCheckbox:checkbox byState:!checkbox.selected needStorage:YES];
}

- (void)keyboardWillHide:(NSNotification*)Notification {
    CGPoint center = CGPointMake(self.view.frame.size.width/2,
                                 self.view.frame.size.height/2);
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.view.center = center;
                     }];
    
}

- (void)keyboardWillShow:(NSNotification*)Notification {
    CGPoint center = CGPointMake(self.view.frame.size.width/2,
                                 self.view.frame.size.height/2);
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.view.center = CGPointMake(center.x, center.y - 100);
                     }];
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

- (NSString *)loginRequestURL {
    return nil;
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

- (void)schoolController:(LSchoolController *)controller selectedSchoolID:(NSString *)schoolID schoolName:(NSString *)name {
    self.schoolID = schoolID;
    schoolTextfield_.text = name;
}

@end
