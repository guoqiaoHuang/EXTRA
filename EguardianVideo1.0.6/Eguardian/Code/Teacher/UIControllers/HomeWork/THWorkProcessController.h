//
//  THWorkProcessViewController.h
//  Eguardian
//
//  Created by apple on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

//新建作业
@interface THWorkProcessController : BaseViewController<UITextViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    UITextField                     *searchBar;
    UITextView                      *contentView;
    UITextField                     *subjectField;
    float                           currentH;
    
    UITableView                     *subjectTable;
    NSDictionary                    *subjectData;
    
    NSDictionary                    *sendSubjectObj;            //要发送的选中的对象
    
    NSDictionary                    *students;                //学生信息
    
    NSString                        *subjectID;             //选中的科目ID
    
}




@property(nonatomic,retain)UITextField      *searchBar;
@property(nonatomic,retain)UITextView       *contentView;
@property(nonatomic,retain)UITextField      *subjectField;
@property(nonatomic,retain)UITableView      *subjectTable;
@property(nonatomic,retain)NSDictionary      *subjectData;
@property(nonatomic,retain)NSDictionary      *sendSubjectObj;
@property(nonatomic,retain)NSDictionary          *students;
@property(nonatomic,retain)NSString          *subjectID;



-(id) initWithTitle:(NSString *)title ;



@end












































