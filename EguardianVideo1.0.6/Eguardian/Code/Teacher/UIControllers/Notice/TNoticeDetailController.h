//
//  TDetailController.h
//  Eguardian
//
//  Created by apple on 13-5-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface TNoticeDetailController : BaseViewController
{
    UITextView                      *inputView;
    float                           currentH;
    
    NSDictionary                    *info;
}




@property(nonatomic,retain)UITextView           *inputView;
@property(nonatomic,retain)NSDictionary         *info;


-(id) initWithTitle:(NSString *)title data:(NSDictionary *)adata;

@end
