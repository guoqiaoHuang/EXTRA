//
//  UIButtonEx.m
//  RDOA
//
//  Created by apple on 13-3-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UIButtonEx.h"

@implementation UIButtonEx
@synthesize phoneView;
@synthesize defualtImg;
@synthesize selectImg;
@synthesize bgButton;
@synthesize bgLight;
@synthesize label;
- (void)dealloc
{
    [bgButton release];
    [label release];
    [bgLight release];
    [phoneView release];
    [defualtImg release];
    [selectImg release];
    [super dealloc];
}



- (id)initWithFrame:(CGRect)aframe text:(NSString *)atext defualtImgName:(NSString *)dname  selectImgName:(NSString *)sname
{
    self = [super initWithFrame:aframe];
    if (self)
    {
     

        self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bgButton.frame = CGRectMake(0, 0, aframe.size.width, aframe.size.height);
        self.bgButton.backgroundColor = [UIColor clearColor];
        
        bgLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FootHighLight.png"]];
        bgLight.frame = CGRectMake( (aframe.size.width - bgLight.frame.size.width) /2.0,
                                   (aframe.size.height - bgLight.frame.size.height) /2.0, bgLight.frame.size.width, bgLight.frame.size.height);
        bgLight.hidden = YES;
        
        defualtImg = [[UIImage imageNamed:dname] retain];
        selectImg = [[UIImage imageNamed:sname] retain];
        phoneView = [[UIImageView alloc] initWithImage:defualtImg];
        phoneView.frame = CGRectMake( (aframe.size.width-phoneView.frame.size.width)/2, 5, phoneView.frame.size.width, phoneView.frame.size.height);
        phoneView.userInteractionEnabled = NO;

        label = [[UILabel alloc] initWithFrame:CGRectMake(0, phoneView.frame.size.height + 8, aframe.size.width, 15)];
        label.text = atext;
        label.textColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"Arial" size:13];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;

        [self.bgButton addSubview:phoneView];
        [self.bgButton addSubview:label];
        
        
        
        [self addSubview:bgLight];
        [self addSubview:self.bgButton];
        
    }
    return self;
    
    
}


-(void) highLight:(BOOL)afalg
{
    if (afalg)
    {
        self.phoneView.image = self.selectImg;
        self.bgLight.hidden = NO;
    }
    else
    {
        self.phoneView.image = self.defualtImg;
        self.bgLight.hidden = YES;
    }
}






@end

































































