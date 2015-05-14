//
//  SchoolChoosedController.h
//  ChildrenKeeper
//
//  Created by Deathman on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JSONKey_Provname    @"provname"
#define JSONKey_City        @"city"
#define JSONKey_School      @"school"
#define JSONKey_SchoolID    @"id"

@class LoginViewController;

@protocol SchoolPickedDelegate <NSObject>
- (void)schoolPickedSelectedSchool:(NSDictionary *)school;
@end

@interface SchoolPickedController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>{
    
    IBOutlet UIPickerView *pickerView_;
    
    IBOutlet UIActivityIndicatorView *activityView_;
    
}

@property (nonatomic,assign) id<SchoolPickedDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;



@end
