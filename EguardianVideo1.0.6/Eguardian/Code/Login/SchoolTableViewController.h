//
//  SchoolTableViewController.h
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchoolTableViewController;

@protocol SchoolControllerDelegate <NSObject>

- (void)schoolTableViewController:(SchoolTableViewController *)schoolTableViewController selectedSchool:(NSDictionary *)school;

@end

@interface SchoolTableViewController : UITableViewController

@property (nonatomic,assign) id<SchoolControllerDelegate> delegate;
@property (nonatomic,retain) NSArray *schoolArray;

@end
