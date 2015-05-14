//
//  NSDictionary+Extemsions.m
//  Genero
//
//  Created by S.C.S on 13-8-13.
//  Copyright (c) 2013年 S.C.S. All rights reserved.
//

#import "NSDictionary+Extemsions.h"

@implementation NSDictionary (Extemsions)

//判断是否为null 如果是返回NIL不是返回数据
- (id)objectJudgeFullForKey:(id)aKey{
    
    if ([[self objectForKey:aKey] isEqual: [NSNull null ]]) {
        return nil;
    }
    return [self objectForKey:aKey];
}

@end
