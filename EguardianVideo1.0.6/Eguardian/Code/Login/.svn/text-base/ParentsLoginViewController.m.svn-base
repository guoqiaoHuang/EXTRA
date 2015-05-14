//
//  ParentsLoginViewController.m
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ParentsLoginViewController.h"
#import "ConfigManager.h"
#import "ProCityDataManager.h"
#import "Global.h"

@implementation ParentsLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loginedKey = User_LoginedUsers_Parents;
        DELEGATE.loginType = self.loginedKey;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (NSString *)loginRequestURL
{
//    self.schoolID = [ProCityDataManager sharedProCityDataManager].schoolID ;
    self.loginedKey = User_LoginedUsers_Parents;
    DELEGATE.loginType = self.loginedKey;
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    return  [NSString stringWithFormat:@"%@?action=login&school=%@&idcard=%@",
            baseURL,
            self.schoolID,
            self.userNameTextfield.text];
}

- (NSDictionary *)userFromText {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.schoolID,User_SchoolID,
            self.userNameTextfield.text,User_UserNumber,
            self.schoolTextfield.text,User_SchoolName,
            nil];
}

- (void)selectedUser:(NSDictionary *)user {    
    self.schoolTextfield.text = [user objectForKey:User_SchoolName];
    self.schoolID = [user objectForKey:User_SchoolID];
    self.userNameTextfield.text = [user objectForKey:User_UserNumber];
    
    self.selectedUser = user;
}


@end
