//
//  EditGroupCardViewController.h
//  CCPVoipDemo
//
//  Created by wang ming on 13-8-20.
//  Copyright (c) 2013年 hisun. All rights reserved.
//

#import "UIBaseViewController.h"
#import "HPGrowingTextView.h"

@interface EditGroupCardViewController : UIBaseViewController<UITextFieldDelegate,HPGrowingTextViewDelegate>
{
    NSInteger type;
    NSInteger count;
    HPGrowingTextView   *textView;
    IMGruopCard* myGroupCard;
    UILabel* label;
}
@property (nonatomic, retain)    UITextField* textField;
- (id)initWithType:(NSInteger)   editType andGroupCard:(IMGruopCard*) groupCard;
@end
