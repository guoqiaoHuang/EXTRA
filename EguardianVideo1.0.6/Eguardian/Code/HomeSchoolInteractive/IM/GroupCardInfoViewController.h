//
//  GroupCardInfoViewController.h
//  CCPVoipDemo
//
//  Created by wang ming on 13-8-20.
//  Copyright (c) 2013年 hisun. All rights reserved.
//

#import "UIBaseViewController.h"

@interface GroupCardInfoViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isOwnerGroup;
}

@property(nonatomic, retain) IMGruopCard* groupCard;
@property(nonatomic, retain) NSString* voipAccount;
@property(nonatomic, retain) NSString* belong;
- (id)initWithVoip:(NSString*)voip andGroupId:(NSString*) groupId andIsOwner:(BOOL)isOwnGroup;

@end
