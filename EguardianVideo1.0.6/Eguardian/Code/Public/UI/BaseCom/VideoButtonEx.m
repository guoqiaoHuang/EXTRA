//
//  VideoButtonEx.m
//  CampusManager
//
//  Created by apple on 13-4-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "VideoButtonEx.h"

@implementation VideoButtonEx
@synthesize name;
@synthesize defaultView;
@synthesize bgButton;
@synthesize carView;
@synthesize photoFlag;


- (void)dealloc
{
    [name release];
    [defaultView release];
    [bgButton release];
    [carView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame flag:(BOOL)aflag
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.photoFlag = aflag;
        name = [[UILabel alloc] init];
        defaultView = [[UIImageView alloc] init];
        self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        carView = [[UIImageView alloc] init];
        
        [self addSubview:name];
        [self addSubview:defaultView];
        [self addSubview:bgButton];
        [self addSubview:carView];
        
        self.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:247.0/255.0 alpha:1.0];
        
        [self layoutView];
    }
    return self;
}


-(void)layoutView
{
    UIImage *defImg = nil;
    if (photoFlag)
        defImg = [UIImage imageNamed:@"线路图标.png"];
    else
        defImg = [UIImage imageNamed:@"没有图片.png"];
    
    
    
    
    UIImage *carImg = [UIImage imageNamed:@"线路小图标.png"];
    self.defaultView.image = defImg;
    self.carView.image = carImg;
    
    self.defaultView.frame = CGRectMake( (self.frame.size.width-defImg.size.width)/2.0 ,24,defImg.size.width, defImg.size.height);
    
    self.carView.frame = CGRectMake((self.frame.size.width-defImg.size.width)/2.0,
                                    (self.defaultView.frame.origin.y + self.defaultView.frame.size.height + 16),
                                    carImg.size.width, carImg.size.height);
    
    name.frame =CGRectMake((self.carView.frame.origin.x+self.carView.frame.size.width + 5),
                           self.carView.frame.origin.y-2,
                           75,
                           self.carView.frame.size.height+5);
    name.textColor = [UIColor colorWithRed:87/255.0 green:79/255.0 blue:77/255.0 alpha:1.0];
    name.text = @"线路1";
    name.backgroundColor = [UIColor clearColor];
    
    self.bgButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bgButton.backgroundColor = [UIColor clearColor];
    
    
    [self bringSubviewToFront:self.bgButton];
}







@end

































































