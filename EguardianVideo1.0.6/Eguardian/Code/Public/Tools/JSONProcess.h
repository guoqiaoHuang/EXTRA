//
//  JSONProcess.h
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONProcess : NSObject


+ (void) configProcess:(NSData *)tempData;



+ (void) checkWorkProcess:(NSData *)tempData;


+ (NSDictionary *) JSONProcess:(NSData *)tempData;


@end
