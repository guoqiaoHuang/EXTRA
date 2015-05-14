//
//  HomeWorkViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class LSchoolController;

@protocol SchoolControllerDelegate <NSObject>

- (void)schoolController:(LSchoolController *)controller selectedSchoolID:(NSString *)schoolID schoolName:(NSString *)name;

@end

@interface LSchoolController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *mainTableView;
        
    float                   currentH ;
    
    NSArray                 *info;
    
}

@property(nonatomic, retain)UITableView *mainTableView;
@property(nonatomic, retain)NSArray *info;

@property (nonatomic,assign) id<SchoolControllerDelegate> delegate;

-(void) loadTableView;

@end
