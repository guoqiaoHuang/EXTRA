//
//  NoticeData.h
//  CampusManager
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeData : NSObject
{
    NSMutableArray                 *list;
    NSString                *sname;
}


@property(nonatomic,retain)NSMutableArray  *list;
@property(nonatomic,retain)NSString *sname;


-(id) initWithDictionary:(NSDictionary *)adata;
@end
