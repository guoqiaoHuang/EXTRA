//
//  CheckWork.m
//  CampusManager
//
//  Created by apple on 13-4-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckWorkData.h"

@implementation CheckWorkData
@synthesize list;
@synthesize sname;

- (void)dealloc
{
    [list release];
    [sname release];
    [super dealloc];
}

 



-(id) initWithDictionary:(NSDictionary *)adata
{
    self = [super init];
    if (self)
    {
        if ([@"ok" isEqualToString:[adata objectForKey:@"status"]] )
        {
            NSLog(@"%@",adata);
            
            self.sname = [[[adata objectForKey:@"content"] objectForKey:@"rs"] objectForKey:@"sname"];
            if ([ [[adata objectForKey:@"content"] objectForKey:@"list"] isKindOfClass:[NSArray class]])
            {
                self.list = [[adata objectForKey:@"content"] objectForKey:@"list"];
            }
            
        }
    }
    return self;
}


@end
