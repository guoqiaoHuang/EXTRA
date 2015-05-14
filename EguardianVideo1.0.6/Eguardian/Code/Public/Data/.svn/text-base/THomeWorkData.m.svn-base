//
//  THomeWorkData.m
//  Eguardian
//
//  Created by apple on 13-5-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "THomeWorkData.h"

@implementation THomeWorkData
@synthesize list;

- (void)dealloc
{
    [list release];
    [super dealloc];
}





-(id) initWithDictionary:(NSDictionary *)adata
{
    self = [super init];
    if (self)
    {
        if (adata)
        {
            if ( [[adata objectForKey:@"content"]  isKindOfClass:[NSArray class]])
            {
                self.list = [adata objectForKey:@"content"];
            }
        }
    }
    return self;
}










































@end





















































