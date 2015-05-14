//
//  RamCacheManager.m
//  RDOA
//
//  Created by apple on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RamCacheManager.h"
#import "SynthesizeSingleton.h"

@implementation RamCacheManager
@synthesize resourcesList;

- (void)dealloc
{
    [resourcesList release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        resourcesList = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

SYNTHESIZE_SINGLETON_FOR_CLASS(RamCacheManager);








@end
