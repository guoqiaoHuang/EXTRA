//
//  LeaderLoginViewController.h
//  Eguardian
//
//  Created by Deathman on 13-5-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginBaseViewController.h"

@interface LeaderLoginViewController : LoginBaseViewController
{
    UIActivityIndicatorView *loginActivity;
    NSString        *uname;
    NSString        *pwd;
}

@property (nonatomic,retain) IBOutlet UITextField *passwordTextField;

@property (nonatomic,retain) NSString *uname;
@property (nonatomic,retain) NSString *pwd;
@end
