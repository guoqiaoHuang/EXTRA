//
//  NoticeData.m
//  CampusManager
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NoticeData.h"

@implementation NoticeData
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
        if (adata)
        {
//            if( [NSDictionary isKindOfClass:[[adata objectForKey:@"content"] class]] )
             if( [[adata objectForKey:@"content"] isKindOfClass:[NSArray class]] )
            {
//                NSDictionary *temp =  [adata objectForKey:@"content"];
                list = [[NSMutableArray alloc] init];
//                for (NSString *key in temp  )
//                {
//                    [self.list addObject:[temp objectForKey:key]];
//                }
                [list addObjectsFromArray:[adata objectForKey:@"content"]];

            }
        }
    }
    return self;
}

@end
