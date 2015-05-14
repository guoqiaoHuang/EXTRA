//
//  DefaultCreateCroupInstance.h
//  Eguardian
//
//  Created by S.C.S on 13-10-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//默认创建群
@interface DefaultCreateCroupInstance : NSObject<ASIHTTPRequestDelegate>{
    
    
}
@property (nonatomic, retain) NSArray *myJoinGroupArr;
@property (nonatomic, retain) NSMutableArray *classList;
@property (nonatomic, assign) NSInteger defautCount ;

//当前创建的群ID
@property (nonatomic, retain) NSString *currentGroupId;
@property (nonatomic, retain) NSArray *currentAcountArray;

//单例
+ (DefaultCreateCroupInstance *)sharedInstance;

//查询群列表
- (void)searchGroupList;

//获取班级
- (void)getGradeClassList;


@end
