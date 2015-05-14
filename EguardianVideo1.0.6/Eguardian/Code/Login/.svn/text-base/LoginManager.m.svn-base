//
//  LoginManager.m
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginManager.h"
#import "ParentsLoginViewController.h"
#import "TeacherLoginViewController.h"
#import "LeaderLoginViewController.h"
#import "Global.h"
#import "SynthesizeSingleton.h"

@interface LoginManager () {

}

@property (nonatomic,retain) ParentsLoginViewController *parentsController;
@property (nonatomic,retain) TeacherLoginViewController *teacherController;
@property (nonatomic,retain) LeaderLoginViewController  *leaderController;
@end

@implementation LoginManager

@synthesize loginViewController = loginViewController_;
@synthesize parentsController = parentsController_;
@synthesize teacherController = teacherController_;
@synthesize leaderController = leaderController_;

SYNTHESIZE_SINGLETON_FOR_CLASS(LoginManager);


- (ParentsLoginViewController *)parentsController {
//    return [[[ParentsLoginViewController alloc] init] autorelease];

    if (parentsController_ == nil) {
        parentsController_ = [[ParentsLoginViewController alloc] init];
        parentsController_.delegate = self;
    }
    return parentsController_;
}

- (TeacherLoginViewController *)teacherController {
//    return [[[TeacherLoginViewController alloc] init] autorelease];
    
    if (teacherController_ == nil) {
        teacherController_ = [[TeacherLoginViewController alloc] init];
        teacherController_.delegate = self;
    }
    return teacherController_;
}

- (LeaderLoginViewController *)leaderController {
//    return [[[LeaderLoginViewController alloc] init] autorelease];
    
    if (leaderController_ == nil) {
        leaderController_ = [[LeaderLoginViewController alloc] init];
        leaderController_.delegate = self;
    }
    return leaderController_;
}

- (LoginBaseViewController *)loginViewController {
    if (loginViewController_ == nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [userDefaults dictionaryForKey:User_AutoLogin];
        NSString *className = [dict objectForKey:User_AutoLoginRole];
        
        if ([className isEqualToString:@"ParentsLoginViewController"]) {
            self.loginViewController = self.parentsController;
        }
        
        if ([className isEqualToString:@"TeacherLoginViewController"]) {
            self.loginViewController = self.teacherController;
        }
        
        if ([className isEqualToString:@"LeaderLoginViewController"]) {
            self.loginViewController = self.leaderController;
        }
        
        if (loginViewController_ == nil) {
            self.loginViewController = self.parentsController;
        }
        self.loginViewController.delegate = self;
    }
    
    return loginViewController_;
}

- (void)loginViewController:(LoginBaseViewController *)controller switchRole:(enum LoginRole)role {
    UINavigationController *navigationController = controller.navigationController;
    if (role == LoginRoleParents) {
        self.loginViewController = self.parentsController;
    } else if (role == LoginRoleTeacher) {
        self.loginViewController = self.teacherController;
    } else if (role == LoginRoleLeader) {
        self.loginViewController = self.leaderController;
    }
    self.loginViewController.delegate = self;
    
    [navigationController setViewControllers:[NSArray arrayWithObject:self.loginViewController]];

}

- (void)dealloc {
    [parentsController_ release];
    [teacherController_ release];
    [leaderController_ release];
    [super dealloc];
}


@end
