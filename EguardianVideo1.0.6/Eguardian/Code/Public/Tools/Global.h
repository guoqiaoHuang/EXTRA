//
//  Global.h
//  Eguardian
//
//  Created by S.C.S on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define ViewBGColor [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]

#define Blackccccc  [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1]

#define Black99999  [UIColor colorWithRed:152.0 / 255.0 green:152.0 / 255.0 blue:152.0 / 255.0 alpha:1]

#define Black66666  [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1]

#define Black3333  [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1]

//获取默认文件设置 默认是 0
#define DefaultFileIndex 0

//获取默认路径字符串
#define Default_File_Path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:DefaultFileIndex]


#define Custom_File_Path(afileName,afileFormat,adirectory) 	[FileSystemManager fileName:afileName fileFormat:afileFormat directory:adirectory]


//屏幕宽高
#define ScreenH  [[UIScreen mainScreen] applicationFrame].size.height
#define ScreenW  [[UIScreen mainScreen] applicationFrame].size.width

//---------------------- AppDelegate  --------------------------
#define DELEGATE  ((AppDelegate*)[[UIApplication sharedApplication]delegate])

//获取 根的 UINavigationController
#define rootNav (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController

//-----------------------------------通知标识-------------------------------------------
#define NotificationKey @"NotificationKey"

#define NotificationSecondKey @"NotificationSecondKey"

//语音通讯的通知
#define NotificationIMListViewController @"NotificationIMListViewController"

//登录子账号
#define NotificationLoginAccountInfo @"NotificationLoginAccountInfo"

//用于联系其它子账号
#define NotificationNOLoginAccountInfo @"NotificationNOLoginAccountInfo"

#define NotificationCreateGroupViewController @"NotificationCreateGroupViewController"

#define NotificationGroupInfoViewController @"NotificationGroupInfoViewController"

//创建子账号
#define NotificationCreateAccountInfo @"NotificationCreateAccountInfo"

//老师积分查询通知
#define NotificationTeacherIntegralViewController @"NotificationTeacherIntegralViewController"

//班主任考勤提交
#define NotificationCheckWorksubmit @"NotificationCheckWorksubmit"

//默认创建群
#define NotificationCreateGroupInstance @"NotificationCreateGroupInstance"

//获取群的列表（在默认创建群）
#define NotificationGroupList @"NotificationGroupList"

//创建群名
#define NotificationCreateGroupName @"NotificationCreateGroupName"

//获取班级的子账号（在默认创建群）
#define NotificationGroupAccount @"NotificationGroupAccount"

//语音通讯添加子账号
#define NotificationGroupAddAccount @"NotificationGroupAddAccount"

//家长获取未读取信息条数
#define NotificationReadNumber @"NotificationReadNumber"

//联系人
#define NotificationContactPeople @"NotificationContactPeople"


//语音通讯的主账号
#define Serverip @"app.cloopen.com"

#define Server_port @"8883"

#define Main_account @"aaf98f89400525a001400abb81f60022"

#define Main_token @"dc2f8a0fb35d4704bc284ceb71c7414f"

#define App_id @"aaf98f8940e7469a0140f26ba39000af"

//群组
#define GroupType @"GroupType"


//视频监控
//#define VdeoServAddr @"http://123.157.208.25:8081"
//#define VdeoUserName @"szshb"
//#define VdeoPassword @"82995120"
//#define VdeoServAddr @"http://113.106.92.55"
//#define VdeoUserName @"shouhubao"
//#define VdeoPassword @"123456"

#define VdeoCControlUnitInfo @"VdeoCControlUnitInfo"


//footBarH的高度， 默认宽度是 屏幕宽
#define footBarH 50

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]


#define CellCornerRadius 10

#define User_AutoLogin               @"AutoLogin"
#define User_AutoLoginCheck          @"AutoLogin_Check"
#define User_AutoLoginRole           @"AutoLogin_Role"

#define User_UserNumber              @"UserNumber"
#define User_SchoolID                @"SchoolID"
#define User_SchoolName              @"SchoolName"
#define User_Password                @"Password"

#define User_LoginedUsers_Teachers   @"LoginedUsers_Teachers"
#define User_LoginedUsers_Parents    @"LoginedUsers_Parents"
#define User_LoginedUsers_Leaders    @"LoginedUsers_Leaders"


static  UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br )
{
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast );
    CGColorSpaceRelease(colorSpace);
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
    
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
}






static void CusstomCellRounde(UITableViewCell *cell, float radius, BOOL top )
{
    UIImage *mask;
    if ( top )
        mask =  MTDContextCreateRoundedMask( cell.bounds, radius, radius, 0.0, 0.0);
    else
        mask =  MTDContextCreateRoundedMask( cell.bounds, 0.0, 0.0, radius, radius );
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = cell.bounds;
    layerMask.contents = (id)mask.CGImage;
    cell.layer.mask = layerMask;
}





static NSDate* GetYesterday(NSDate *date)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date ];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:date options:0];
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    //    NSDate *date = yesterday;
    //    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    //    [dateformat setDateFormat:@"yyyy-MM-dd"];
    //    NSString *result = [dateformat stringFromDate:date];
    
    return yesterday;
}




static NSDate* GetTomorrow(NSDate *date)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date ];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:date options:0];
    
    [components setHour:+24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *resutl = [cal dateByAddingComponents:components toDate: today options:0];
    return resutl;
}





static NSString* GetWeekDay(NSDate *date)
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    NSInteger weekDay = [components weekday];
    
    NSString *result;
    
    switch (weekDay) {
        case 1:
            result = @"星期日";
            break;
        case 2:
            result = @"星期一";
            break;
        case 3:
            result = @"星期二";
            break;
        case 4:
            result = @"星期三";
            break;
        case 5:
            result = @"星期四";
            break;
        case 6:
            result = @"星期五";
            break;
        default:
            result = @"星期六";
            break;
    }
    return result;
}

//底部的View
@interface BottonView:UIView

- (id) initWithFrame:(CGRect)frame ID:(id) delegate;

@end


#define NavTriangleTitle 16

@interface NavTriangleTitleView : UIControl

- (id)initWithFrame:(CGRect)frame Delegate:(id) delegate;

@property (nonatomic,assign) id mDelegate;
@property(nonatomic, retain) UILabel *title;
@property(nonatomic, retain) UIButton *mBtn;

@end


