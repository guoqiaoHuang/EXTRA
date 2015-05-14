//
//  NameManager.m
//  Eguardian
//
//  Created by apple on 13-5-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NameManager.h"
#import "pinyin.h"

@implementation NameManager
@synthesize pinyinArray;
@synthesize namesDictionary;
@synthesize namesArray;


void orderWithArray( int *arr, int count)
{
    int out, in;
    for (out=1; out<count; out++)
    {
        int temp = arr[out];
        in = out;
        
        while ( in>0 && arr[in-1]>= temp )
        {
            arr[in] = arr[in-1];
            --in;
        }
        arr[in] = temp;
    }
}




- (void)dealloc
{
    [namesArray release];
    [namesDictionary release];
    [pinyinArray release];
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self) {
        pinyinArray = [[NSMutableArray alloc] init];
        namesDictionary = [[NSMutableDictionary alloc] init];
        namesArray = [[NSMutableArray alloc] init];
    }
    return self;
}



/*
 *  @brief      初始化数据，将名字分区  存储在 namesDictionary 中， key == 名字的首个单词，  value 保存 首个单词的所有人物的信息
 *
 *
 *
 *
 */
-(void)processWithNames:(NSArray *)tempNameArray
{
    int count = tempNameArray.count;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for ( int i=0; i<count; i++)
    {
        NSDictionary *userMessage = [tempNameArray objectAtIndex:i];
        NSString *userName = [userMessage objectForKey:@"sname"];
        NSString *nameChar = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([userName characterAtIndex:0])] lowercaseString];
    
        if ( [namesDictionary objectForKey:nameChar] )
        {
            NSMutableArray *tempArray = [namesDictionary objectForKey:nameChar];
            [tempArray addObject:userMessage];
        }
        else
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            [tempArray addObject:userMessage];
            [namesDictionary setObject:tempArray forKey:nameChar];
            [tempArray release];
        }
    }
    [pool release];
}





/*
 *  @brief     将字符串排序并存储
 *
 */
-(void)sortWithChar
{
    NSArray *chars = [namesDictionary allKeys];
    int count = chars.count;
    if (count == 0)
        return;

    
    int orderArray[count];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //将 string 的 第一个字的char 转成 int
    for (int i=0; i<count; i++)
    {
        NSString *key = [chars objectAtIndex:i];
        orderArray[i] = pinyinFirstLetter([key characterAtIndex:0]);
    }
    
    orderWithArray(orderArray, count);
    
    for (int i=0; i<count; i++)
    {
        NSString *string = [NSString stringWithFormat:@"%c",orderArray[i]];
        [pinyinArray insertObject:string atIndex:i];
    }
    [pool release];
    
}



/*
 *  @brief          根据字母查询
 *
 */
-(NSArray *)findWidthABC:(NSString *)str
{
    NSString *target = [str lowercaseString];
    NSArray *result = nil;
    result = [namesDictionary objectForKey:target];
    return result;
}


-(NSArray *)findNameWithSection:(int )asection
{
    NSString *keyString = nil;
    if (asection < pinyinArray.count && asection >=0)
        keyString = [pinyinArray objectAtIndex:asection];
    return [namesDictionary objectForKey:keyString];
}


/*
 *  @brief                              将字符串 a 转换成证书，去判断 namesDictionary 中对应key的数组的 count
 *
 *  @param          asection            tabel的区域
 *
 *  @return                             namesDictionary 中 key 对应数组的大小
 */
-(int) nameCountWithSection:(int)asection
{

    NSString *keyString = nil;
    if (asection < pinyinArray.count && asection >=0)
        keyString = [pinyinArray objectAtIndex:asection];
    return [[namesDictionary objectForKey:keyString] count];
}


#pragma mark 查找 N区 M行的 名字   N区表示 汉字首字母的排序好的数组的下标 其实是  pinyinArray的下标,  M是对应 key后数组的下标
-(NSString *)findNameWithSection:(int)asection index:(int)aindex
{
    NSString *key = [pinyinArray objectAtIndex:asection];
    NSArray *tempNames = [namesDictionary objectForKey:key];
    return [[tempNames objectAtIndex:aindex] objectForKey:@"sname"];
}


-(NSDictionary *)findUserMessageWithSection:(int)asection index:(int)aindex
{
    NSString *key = [pinyinArray objectAtIndex:asection];
    NSArray *tempNames = [namesDictionary objectForKey:key];
    return [tempNames objectAtIndex:aindex];
}




#pragma mark 将所有的名字排序 并放入到namesArray 数组中
-(void) insertNamesArray
{
    
    if (pinyinArray.count)
    {
        for ( int i=0; i<pinyinArray.count; i++ )
        {
            NSArray *userMessages = [namesDictionary objectForKey: [pinyinArray objectAtIndex:i]];
            if ( userMessages )
            {
                NSMutableArray *tempNames = [[NSMutableArray alloc] init];
                for (int i=0; i<userMessages.count; i++)
                {
                    NSString *userName = [[userMessages objectAtIndex:i] objectForKey:@"sname"];
                    [tempNames insertObject:userName atIndex:i];
                }
                [namesArray addObjectsFromArray:tempNames];
                [tempNames release];
            }
        }
        
    }
    
    
    
//    for ( int i=0; i<pinyinArray.count; i++ )
//    {
//        NSArray *objs = [namesDictionary objectForKey: [pinyinArray objectAtIndex:i] ];
//        
//        if (objs)
//        {
//            [namesArray addObjectsFromArray:objs];
//        }
//        
//        
//    }
    
    
}






@end





























































