//
//  CommentData.m
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CommentData.h"

@implementation CommentData
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



































