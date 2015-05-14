//
//  SHButton.m
//  GUOSE_PROJECT
//
//  Created by S.C.S on 13-9-17.
//  Copyright (c) 2013年 shiyuntian. All rights reserved.
//

#import "SHButton.h"

@implementation SHButton
@synthesize contentLb;

- (void)dealloc{
    [contentLb release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        contentLb = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 30, frame.size.height)];
        contentLb.font = [UIFont systemFontOfSize:16];
        contentLb.textColor = [UIColor whiteColor];
        contentLb.textAlignment = NSTextAlignmentRight;
        contentLb.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLb];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
