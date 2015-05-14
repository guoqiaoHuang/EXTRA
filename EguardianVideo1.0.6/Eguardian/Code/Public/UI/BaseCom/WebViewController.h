//
//  WebViewController.h
//  Eguardian
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface WebViewController : BaseViewController
{
    NSString            *url;
    UIWebView           *webView;
}

@property(nonatomic,retain)NSString *url;
@property(nonatomic,retain)UIWebView *webView;

-(id) initWithURL:(NSString *)aurl;




@end
