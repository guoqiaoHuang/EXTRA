//
//  SeatsData.m
//  Eguardian
//
//  Created by apple on 13-6-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SeatsData.h"

@implementation SeatsData
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
        NSLog(@"数据 %@",adata);
        
        if ([@"ok" isEqualToString:[adata objectForKey:@"status"]] )
        {
            
            
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
