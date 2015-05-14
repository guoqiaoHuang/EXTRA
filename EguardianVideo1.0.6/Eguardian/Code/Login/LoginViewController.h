//
//  LoginViewController.h
//  ChildrenKeeper
//
//  Created by Deathman on 13-4-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolPickedController.h"
#import "LoginedUsersHistoryController.h"

#define User_CheckAutoLogin          @"CheckAutoLogin"

#define User_LoginedUsers            @"LoginedUsers"

#define User_UserNumber              @"UserNumber"
#define User_SchoolID                @"SchoolID"
#define User_SchoolName              @"SchoolName"

@interface LoginViewController : UIViewController<UITextFieldDelegate,SchoolPickedDelegate> {
    
    IBOutlet UILabel        *numberLabel_;
    IBOutlet UIButton       *autoLoginCheckbox_;
    
    IBOutlet UIButton       *loginButton_;
    
    SchoolPickedController  *schoolPickedController_;
    LoginedUsersHistoryController *loginedUsersController_;
}

@property (nonatomic,retain) NSDictionary   *selectedUser;
@property (nonatomic,retain) NSMutableArray *loginedUsers;
@property (nonatomic,retain) IBOutlet UITextField *numberTextfield;
@property (nonatomic,retain) IBOutlet UITextField *schoolTextfield;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)checkboxClicked:(id)sender;

- (IBAction)showSchoolPiker;
- (IBAction)showLoginedUsersHistory;
- (void)selectedUser:(NSDictionary *)user;
@end
