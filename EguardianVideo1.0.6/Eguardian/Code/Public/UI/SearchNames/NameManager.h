//
//  NameManager.h
//  Eguardian
//
//  Created by apple on 13-5-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameManager : NSObject
{
    NSMutableArray             *pinyinArray;       //存储姓名第一个字母的数组   names中的key 且一般是排序的
    NSMutableDictionary        *namesDictionary;   // key 是 拼音的第一个单词   value 是 名字数组
    NSMutableArray             *namesArray;        //汉字名称， 全部的名称排序后 放在数组里面;
}


@property(nonatomic,retain)NSMutableArray *pinyinArray;
@property(nonatomic,retain)NSMutableDictionary *namesDictionary;
@property(nonatomic,retain)NSMutableArray *namesArray;


-(void)processWithNames:(NSArray *)tempNameArray;

-(void)sortWithChar;






-(NSArray *)findWidthABC:(NSString *)abc;

-(NSArray *)findNameWithSection:(int )section;

-(int) nameCountWithSection:(int)section;

-(NSString *)findNameWithSection:(int)section index:(int)index;


-(NSDictionary *)findUserMessageWithSection:(int)section index:(int)index;

-(void) insertNamesArray;



@end























































