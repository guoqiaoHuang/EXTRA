//
//  MyHUD.m
//  NewYearText2
//
//  Created by 林明智 on 13-7-28.
//  Copyright (c) 2013年 林明智. All rights reserved.
//

#import "MyHUD.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyHUD
@synthesize indicator;
@synthesize label;
@synthesize detailsLabel;
@synthesize labelText;
@synthesize width;
@synthesize height;
@synthesize xOffset;
@synthesize yOffset;
@synthesize margin;
@synthesize labelFont;
@synthesize detailsLabelText;
@synthesize detailsLabelFont;
@synthesize opacity;
@synthesize hud;
@synthesize frameModel;

- (void)dealloc{
    [indicator release];
    [label release];
    [detailsLabel release];
    [labelText release];
    [labelFont release];
    [detailsLabelText release];
    [detailsLabelFont release];
    [hud release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame Model:(FrameModel) aModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameModel = aModel;
        self.labelText = nil;
        self.detailsLabelText = nil;
        self.opacity = 0.8f;
        self.labelFont = [UIFont boldSystemFontOfSize:LABELFONTSIZE];
        self.detailsLabelFont = [UIFont boldSystemFontOfSize:LABELDETAILSFONTSIZE];
        self.xOffset = 0.0f;
        self.yOffset = 0.0f;
		self.margin = 20.0f;
        
        hud = [[UIView alloc] init];
        hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        [self addSubview:hud];
		
		self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		
        // Transparent background
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
		
        // Make invisible for now
        self.alpha = 1.0f;
		
        // Add label
        label = [[UILabel alloc] initWithFrame:self.bounds];
		
        // Add details label
        detailsLabel = [[UILabel alloc] initWithFrame:self.bounds];
		
        self.indicator = [[[UIActivityIndicatorView alloc]
						   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        [(UIActivityIndicatorView *)indicator startAnimating];
        [hud addSubview:indicator];

    }
    return self;
}

- (void)setFitView:(NSString *) alabelText {
    self.labelText = alabelText;
    CGRect frame = self.bounds;
	
    // Compute HUD dimensions based on indicator size (add margin to HUD border)
    CGRect indFrame = indicator.bounds;
    self.width = indFrame.size.width + 2 * margin;
    self.height = indFrame.size.height + 2 * margin;
	
    // Position the indicator
    indFrame.origin.x = floorf((frame.size.width - indFrame.size.width) / 2) + self.xOffset;
    indFrame.origin.y = floorf((frame.size.height - indFrame.size.height) / 2) + self.yOffset;
    indicator.frame = indFrame;
	
    // Add label if label text was set
    if (nil != self.labelText) {
        // Get size of label text
        CGSize dims = [self.labelText sizeWithFont:self.labelFont];
		
        // Compute label dimensions based on font metrics if size is larger than max then clip the label width
        float lHeight = dims.height;
        float lWidth;
        if (dims.width <= (frame.size.width - 2 * margin)) {
            lWidth = dims.width;
        }
        else {
            lWidth = frame.size.width - 4 * margin;
        }
		
        // Set label properties
        label.font = self.labelFont;
        label.adjustsFontSizeToFitWidth = NO;
        label.textAlignment = UITextAlignmentCenter;
        label.opaque = NO;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.text = self.labelText;
		
        // Update HUD size
        if (self.width < (lWidth + 2 * margin)) {
            self.width = lWidth + 2 * margin;
        }
        self.height = self.height + lHeight + PADDING;
		
        // Move indicator to make room for the label
        indFrame.origin.y -= (floorf(lHeight / 2 + PADDING / 2));
        indicator.frame = indFrame;
		
        // Set the label position and dimensions
        CGRect lFrame = CGRectMake(floorf((frame.size.width - lWidth) / 2) + xOffset,
                                   floorf(indFrame.origin.y + indFrame.size.height + PADDING),
                                   lWidth, lHeight);
        label.frame = lFrame;
		
        [hud addSubview:label];
		
        // Add details label delatils text was set
        if (nil != self.detailsLabelText) {
            // Get size of label text
            dims = [self.detailsLabelText sizeWithFont:self.detailsLabelFont];
			
            // Compute label dimensions based on font metrics if size is larger than max then clip the label width
            lHeight = dims.height;
            if (dims.width <= (frame.size.width - 2 * margin)) {
                lWidth = dims.width;
            }
            else {
                lWidth = frame.size.width - 4 * margin;
            }
			
            // Set label properties
            detailsLabel.font = self.detailsLabelFont;
            detailsLabel.adjustsFontSizeToFitWidth = NO;
            detailsLabel.textAlignment = UITextAlignmentCenter;
            detailsLabel.opaque = NO;
            detailsLabel.backgroundColor = [UIColor clearColor];
            detailsLabel.textColor = [UIColor whiteColor];
            detailsLabel.text = self.detailsLabelText;
			
            // Update HUD size
            if (self.width < lWidth) {
                self.width = lWidth + 2 * margin;
            }
            self.height = self.height + lHeight + PADDING;
			
            // Move indicator to make room for the new label
            indFrame.origin.y -= (floorf(lHeight / 2 + PADDING / 2));
            indicator.frame = indFrame;
			
            // Move first label to make room for the new label
            lFrame.origin.y -= (floorf(lHeight / 2 + PADDING / 2));
            label.frame = lFrame;
			
            // Set label position and dimensions
            CGRect lFrameD = CGRectMake(floorf((frame.size.width - lWidth) / 2) + xOffset,
                                        lFrame.origin.y + lFrame.size.height + PADDING, lWidth, lHeight);
            detailsLabel.frame = lFrameD;
			
            [hud addSubview:detailsLabel];
        }
    }
    CGRect allRect = self.bounds;
    // Draw rounded HUD bacgroud rect
    CGRect boxRect = CGRectMake(roundf((allRect.size.width - self.width) / 2) + self.xOffset,
                                roundf((allRect.size.height - self.height) / 2) + self.yOffset, self.width, self.height);
//    self.frame = boxRect;
    
    [hud.layer setMasksToBounds:YES];
    [hud.layer setCornerRadius:10.0];
    
    //只填冲一部分
    if (frameModel == PartViewModel) {
        self.frame = boxRect;
        hud.frame = CGRectMake(0, 0, boxRect.size.width, boxRect.size.height);
    }else {
        hud.frame = boxRect;
    }

    indicator.frame = CGRectMake(roundf((boxRect.size.width - indicator.frame.size.width) / 2) + self.xOffset,
                                 roundf(margin) + self.yOffset, indicator.frame.size.width, indicator.frame.size.height);
    
    label.frame = CGRectMake(roundf((boxRect.size.width - label.frame.size.width) / 2) + self.xOffset,
                                 roundf(margin) + self.yOffset + indFrame.size.height + PADDING, label.frame.size.width, label.frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    
        
}

#pragma mark BG Drawing

//- (void)drawRect:(CGRect)rect {
//	
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//	float radius = 10.0f;
//    CGRect boxRect = self.bounds;
//    CGContextBeginPath(context);
//    CGContextSetGrayFillColor(context, 0.0f, self.opacity);
//    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
//    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
//    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
//    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
//    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//}

@end
