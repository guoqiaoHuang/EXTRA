//
//  NameViewController.h
//  Eguardian
//
//  Created by apple on 13-5-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NameManager.h"


@protocol SelectNameDelegate <NSObject>
@optional

- (void) selectNamesFinsh:(id)tempData;

@end


@interface NameViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    
    id<SelectNameDelegate>      delegate;
    float                       currentH;
    UITableView                 *namesTable;
    NSDictionary                *message;               //外面传进来的信息，包含学生ID和年级ID 主要是通过这些信息去下载 studentArray 数据
    NSArray                     *studentArray;          //原始的所有学生的数据
    
    
    BOOL                        selectFlag;             //全选标识
    NSMutableDictionary         *selectDic;             //选中的数据

    NSArray                     *filteredArray;
    NameManager                 *nameManager;
    
    NSMutableDictionary         *sectionRow;            //选中的行和列  key是 section 和 row 的字符串  例如 3#2  value 是bool值
                                                        //因为初始化问题，  ture 表示显示， false表示隐藏
    
}


@property(nonatomic,retain)UITableView                  *namesTable;
@property(nonatomic,retain)NSDictionary                 *message;
@property(nonatomic,retain)NSArray                      *studentArray;

@property(nonatomic,retain)NSMutableDictionary          *selectDic;

@property(nonatomic,retain)id                           delegate;

//@property(nonatomic,retain)UISearchBar                  *searchBar;
//@property(nonatomic,retain)UISearchDisplayController    *searchDC;
@property(nonatomic,retain)NSArray                      *filteredArray;
@property(nonatomic,retain)NameManager                  *nameManager;
@property(nonatomic,retain)NSMutableDictionary          *sectionRow;

//判断是否只是单选
@property(nonatomic, assign)BOOL                    isOneSelect;


-(id) initWithTitle:(NSString *)title data:(NSDictionary *)amessage delegate:(id)adelegate;


@end
