//
//  ProCityDataManager.m
//  Eguardian
//
//  Created by apple on 13-5-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ProCityDataManager.h"
#import "SynthesizeSingleton.h"
@implementation ProCityDataManager
@synthesize proCitys;
@synthesize provinceName;
@synthesize cityName;
@synthesize zoneName;
@synthesize schoolID;
@synthesize schoolName;

- (void)dealloc
{
    [schoolName release];
    [schoolID release];
    [provinceName release];
    [cityName release];
    [zoneName release];
    
    [proCitys release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        proCitys = nil;
    }
    return self;
}


SYNTHESIZE_SINGLETON_FOR_CLASS(ProCityDataManager);




@end
