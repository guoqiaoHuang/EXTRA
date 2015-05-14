//
//  DisplayPanel.m
//  CampusManager
//
//  Created by apple on 13-4-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DisplayPanel.h"

@implementation DisplayPanel
@synthesize imageView;
@synthesize panel;
@synthesize closeButton;

- (void)dealloc
{
    [closeButton release];
    [panel release];
    [imageView release];
    [super dealloc];
}

-(void) closeView
{
    self.hidden = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:0.2];
        
        float width = 299;
        float height = 222;
        UIImage *tempImg = [UIImage imageNamed:@"DisplayPanel.png"];
         tempImg = [tempImg stretchableImageWithLeftCapWidth:tempImg.size.width/2 topCapHeight:tempImg.size.height/2];
        imageView = [[UIImageView alloc] initWithImage:tempImg];
        imageView.frame = CGRectMake( (self.frame.size.width - width)/2.0,
                                     (self.frame.size.height - height)/2.0,
                                     width, height);
        
        imageView.userInteractionEnabled = YES;
        
        UIFont *tempFont = [UIFont fontWithName:@"Arial" size:17];
        
        panel = [[UITextView alloc] initWithFrame:CGRectMake((imageView.frame.size.width - 270)/2.0,
                                                             (imageView.frame.size.height - 130)/2.0,
                                                             270, 130)];
        panel.font = tempFont;
        panel.backgroundColor = [UIColor clearColor];
        panel.scrollEnabled = YES;
        panel.editable = NO;
        
        
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btImg = [UIImage imageNamed:@"DisplayPanelClose.png"];
        self.closeButton.frame = CGRectMake(0, 0, btImg.size.width, btImg.size.height);
        self.closeButton.frame = CGRectMake(imageView.frame.size.width - (btImg.size.width/2.0), imageView.frame.origin.y-4, btImg.size.width, btImg.size.height);
        UIImageView *tempbtBG = [[UIImageView alloc] initWithImage:btImg];
        [self.closeButton addSubview:tempbtBG]; [tempbtBG release];
        [self.closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchDown];
        
        
        [imageView addSubview:panel];
        [self addSubview:imageView];
        [self addSubview:closeButton];
        [self bringSubviewToFront:closeButton];
        
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
