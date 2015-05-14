//
//  LocationTableViewController.h
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

enum LocationType {
    LocationTypeProvince = 1,
    LocationTypeCity,
    LocationTypeDistrict,
    };

@class LoginBaseViewController;


@interface LocationTableViewController : UITableViewController {

}

@property (nonatomic,assign) LoginBaseViewController    *loginViewController;
@property (nonatomic,retain) NSDictionary               *allLocationData;
@property (nonatomic,retain) NSArray                    *locationArray;

- (id)initWithLocationType:(enum LocationType)type;

@end
