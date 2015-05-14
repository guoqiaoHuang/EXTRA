//
//  SNPopupView.m
//  360LBS
//
//  Created by linmingzhi987 on 12-9-29.
//  Copyright (c) 2012年 linmingzhi987. All rights reserved.
//

#import "SNPopupView.h"
#import <QuartzCore/QuartzCore.h>


#define ViewToWindow 20
#define BarLeftSharpPoint 289
#define POPUP_ANIMATION_DURATION 0.3
#define DISMISS_ANIMATION_DURATION 0.3

@interface TouchPeekView : UIView {
	SNPopupView *delegate;
}
@property (nonatomic, assign) SNPopupView *delegate;
@end

@interface SNPopupView(Private)
- (void)popup;
@end

@implementation TouchPeekView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([delegate shouldBeDismissedFor:touches withEvent:event])
		[delegate dismissModal];
}

@end

@implementation SNPopupView
@synthesize fatherView;

- (void)dealloc {
	
	[peekView release];
	[contentView release];
    [fatherView release];
    [super dealloc];
}

- (id) initWithPopupViewModel:(SNPopupViewModel) model ContentView:view Rect:(CGRect)frame stretCapWidth:(float) width View:(UIView *) tmpview{
	self = [super init];
	if (self != nil) {
        {
            UIImageView *imv = [[UIImageView alloc] initWithFrame:frame];
            UIImage *image = [UIImage imageNamed:@"PopupUserName.png"];
            imv.image =  [image stretchableImageWithLeftCapWidth:width topCapHeight:image.size.height/2];
            [self addSubview:imv];
            [imv release];
        }
        contentView = [view retain];
		popupViewMode = model;
        self.fatherView = tmpview;
        
		[self setBackgroundColor:[UIColor clearColor]];
        if (popupViewMode == SNPopupViewBarLeftItem) {
            viewRect = CGRectMake(130,4, 153, frame.size.height);
        }else if (popupViewMode == SNPopupViewButton) {
            viewRect = CGRectMake(48, 281 + ViewToWindow, 263, 123);
        }
       
	}
	return self;
}

- (void)presentModal{
	//animatedWhenAppering = animated;
//	[self createAndAttachTouchPeekView];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow] ;
    [fatherView addSubview:self];
    self.frame = viewRect;

    if (contentView) {
        [self addSubview:contentView];
    }
    [self popup];
}

- (void)createAndAttachTouchPeekView {
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	[peekView removeFromSuperview];
	[peekView release];
	peekView = nil;
	peekView = [[TouchPeekView alloc] initWithFrame:window.frame];
	[peekView setDelegate:self];
	
	[window addSubview:peekView];
}


#pragma mark - Core Animation call back

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    [contentView removeFromSuperview];
	[self removeFromSuperview];
}

#pragma mark - Make CoreAnimation object

- (CAKeyframeAnimation*)getAlphaAnimationForPopup {
	
	CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation	animationWithKeyPath:@"opacity"];
	alphaAnimation.removedOnCompletion = NO;
	alphaAnimation.values = [NSArray arrayWithObjects:
							 [NSNumber numberWithFloat:0],
							 [NSNumber numberWithFloat:0.7],
							 [NSNumber numberWithFloat:1],
							 nil];
	alphaAnimation.keyTimes = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0],
							   [NSNumber numberWithFloat:0.1],
							   [NSNumber numberWithFloat:1],
							   nil];
	return alphaAnimation;
}

- (CAKeyframeAnimation*)getPositionAnimationForPopup {
	
	float r1 = 0.1;
	float r2 = 1.4;
	float r3 = 1;
	float r4 = 0.8;
	float r5 = 1;
    
    float horizontalOffset = 0.0;
    float portraitOffset = 0.0;
    if (popupViewMode == SNPopupViewBarLeftItem) {
        horizontalOffset= (BarLeftSharpPoint - 158) / 2;
        portraitOffset = (viewRect.size.height - 44) / 2;
    }else if (popupViewMode == SNPopupViewButton){
        horizontalOffset = - (1 + 0.1) * viewRect.size.width/2 ;
        portraitOffset = -   viewRect.size.height  / 2 + 25 ;
    }
	
	
	CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	CATransform3D tm1, tm2, tm3, tm4, tm5;
	
	
    horizontalOffset = -horizontalOffset;
    tm1 = CATransform3DMakeTranslation(horizontalOffset* (1 - r1), -portraitOffset * (1 - r1), 0);
    tm2 = CATransform3DMakeTranslation(horizontalOffset * (1 - r2), -portraitOffset * (1 - r2), 0);
    tm3 = CATransform3DMakeTranslation(horizontalOffset * (1 - r3), -portraitOffset * (1 - r3), 0);
    tm4 = CATransform3DMakeTranslation(horizontalOffset * (1 - r4), -portraitOffset * (1 - r4), 0);
    tm5 = CATransform3DMakeTranslation(horizontalOffset * (1 - r5), -portraitOffset * (1 - r5), 0);
	
	tm1 = CATransform3DScale(tm1, r1, r1, 1);
	tm2 = CATransform3DScale(tm2, r2, r2, 1);
	tm3 = CATransform3DScale(tm3, r3, r3, 1);
	tm4 = CATransform3DScale(tm4, r4, r4, 1);
	tm5 = CATransform3DScale(tm5, r5, r5, 1);
	
	positionAnimation.values = [NSArray arrayWithObjects:
								[NSValue valueWithCATransform3D:tm1],
								[NSValue valueWithCATransform3D:tm2],
								[NSValue valueWithCATransform3D:tm3],
								[NSValue valueWithCATransform3D:tm4],
								[NSValue valueWithCATransform3D:tm5],
								nil];
	positionAnimation.keyTimes = [NSArray arrayWithObjects:
								  [NSNumber numberWithFloat:0.0],
								  [NSNumber numberWithFloat:0.2],
								  [NSNumber numberWithFloat:0.4],
								  [NSNumber numberWithFloat:0.7],
								  [NSNumber numberWithFloat:1.0],
								  nil];
	return positionAnimation;
}

#pragma mark - Popup and dismiss

- (void)popup {
	
	CAKeyframeAnimation *positionAnimation = [self getPositionAnimationForPopup];
	CAKeyframeAnimation *alphaAnimation = [self getAlphaAnimationForPopup];
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.animations = [NSArray arrayWithObjects:positionAnimation, alphaAnimation, nil];
	group.duration = POPUP_ANIMATION_DURATION;
	group.removedOnCompletion = YES;
	group.fillMode = kCAFillModeForwards;
	
	[self.layer addAnimation:group forKey:@"hoge"];
}

- (BOOL)shouldBeDismissedFor:(NSSet *)touches withEvent:(UIEvent *)event {
	/*UITouch *touch = [touches anyObject];
	
	CGPoint p = [touch locationInView:self];
	return !CGRectContainsPoint(viewRect, p);*/
    return YES;
}

- (void)dismissModal {
	if ([peekView superview])
		[_delegate didDismissModal:self];
	[peekView removeFromSuperview];
	
	[self dismiss:YES];
}

- (void)dismiss:(BOOL)animtaed {
	if (animtaed)
		[self dismiss];
	else {
		[self removeFromSuperview];
	}
}

- (void)dismiss {
	CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	
	float r1 = 1.0;
	float r2 = 0.1;
	
	float horizontalOffset = 0.0;
	float portraitOffset = 0.0;
	
    if (popupViewMode == SNPopupViewBarLeftItem) {
        horizontalOffset = BarLeftSharpPoint - 158 - viewRect.size.width/ 2;
        portraitOffset = viewRect.size.height  / 2;
    }else if (popupViewMode == SNPopupViewButton){
        horizontalOffset = -  viewRect.size.width/2 ;
        portraitOffset = -   viewRect.size.height  / 2 + 25 ;
    }
	CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation	animationWithKeyPath:@"opacity"];
	alphaAnimation.removedOnCompletion = NO;
	alphaAnimation.values = [NSArray arrayWithObjects:
							 [NSNumber numberWithFloat:1],
							 [NSNumber numberWithFloat:0],
							 nil];
	alphaAnimation.keyTimes = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0],
							   [NSNumber numberWithFloat:1],
							   nil];
	
	CATransform3D tm1, tm2;

    tm1 = CATransform3DMakeTranslation(-horizontalOffset * (1 - r1), -portraitOffset * (1 - r1), 0);
    tm2 = CATransform3DMakeTranslation(-horizontalOffset * (1 - r2), -portraitOffset * (1 - r2), 0);
		
	
	tm1 = CATransform3DScale(tm1, r1, r1, 1);
	tm2 = CATransform3DScale(tm2, r2, r2, 1);
	
	positionAnimation.values = [NSArray arrayWithObjects:
								[NSValue valueWithCATransform3D:tm1],
								[NSValue valueWithCATransform3D:tm2],
								nil];
	positionAnimation.keyTimes = [NSArray arrayWithObjects:
								  [NSNumber numberWithFloat:0],
								  [NSNumber numberWithFloat:1.0],
								  nil];
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.animations = [NSArray arrayWithObjects:positionAnimation, alphaAnimation, nil];
	group.duration = DISMISS_ANIMATION_DURATION;
	group.removedOnCompletion = NO;
	group.fillMode = kCAFillModeForwards;
	group.delegate = self;
	
	[self.layer addAnimation:group forKey:@"hoge"];
}

- (void)drawRect:(CGRect)rect {
//    UIImage *image = nil;
//    if (popupViewMode == SNPopupViewBarLeftItem) {
//        image = [UIImage imageNamed:@"PopupUserName.png"];
//    }else if (popupViewMode == SNPopupViewButton) {
//        image = [UIImage imageNamed:@"PopupLocation.png"];
//    }
//	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
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
