//
//  NSDateFormatter+help.h
//  Genero
//
//  Created by S.C.S on 13-7-23.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (help)

+ (NSDateFormatter *) getYyyyMmDd ;

+ (NSDateFormatter *) getYyyyMm;

+ (NSDateFormatter *) getYyyy_Mm_Dd;

+ (NSDateFormatter *) getYyyy_Mm;

+ (NSDateFormatter *) getYyyy_Mm_DdHMS;

+ (NSDateFormatter *) getYyyyMmDdHMS;

+ (NSDateFormatter *) getCNYyyy_Mm_Dd;

@end
