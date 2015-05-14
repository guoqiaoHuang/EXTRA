//
//  TeacherLoginViewController.m
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TeacherLoginViewController.h"
#import "ProCityDataManager.h"
#import "Global.h"

@implementation TeacherLoginViewController

@synthesize passwordTextField = passwordTextField_;

- (void)dealloc {
    [passwordTextField_ release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loginedKey = User_LoginedUsers_Teachers;
        DELEGATE.loginType = self.loginedKey;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    passwordTextField_.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.passwordTextField = nil;
}

- (NSString *)loginRequestURL {
    
//    self.schoolID = [ProCityDataManager sharedProCityDataManager].schoolID;
    self.loginedKey = User_LoginedUsers_Teachers;
    DELEGATE.loginType = self.loginedKey;
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    return [NSString stringWithFormat:@"%@?app=teacher&action=login&school=%@&name=%@&pwd=%@",
            baseURL,
            self.schoolID,
            self.userNameTextfield.text,
            self.passwordTextField.text];
}

- (NSDictionary *)userFromText {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.schoolID,User_SchoolID,
            self.userNameTextfield.text,User_UserNumber,
            self.schoolTextfield.text,User_SchoolName,
            self.passwordTextField.text,User_Password,
            nil];
}

- (void)selectedUser:(NSDictionary *)user {    
    self.schoolTextfield.text = [user objectForKey:User_SchoolName];
    self.schoolID = [user objectForKey:User_SchoolID];
    self.userNameTextfield.text = [user objectForKey:User_UserNumber];
    self.passwordTextField.text = [user objectForKey:User_Password];
    
    self.selectedUser = user;
}

@end
