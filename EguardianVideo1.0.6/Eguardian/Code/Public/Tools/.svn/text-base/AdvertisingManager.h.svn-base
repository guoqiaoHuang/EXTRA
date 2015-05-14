//
//  AdvertisingManager.h
//  Eguardian
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdvertisingDelegate <NSObject>
@optional
- (void) AdvertisingFinsh:(id)tempData dataMessage:(id) msg;
@end


@interface AdvertisingManager : NSObject
{
    NSDictionary                *data;          //广告的数据信息
    
}


@property(nonatomic, retain)NSDictionary      *data;


+ (AdvertisingManager *)sharedAdvertisingManager;



-(void)request;


@end
