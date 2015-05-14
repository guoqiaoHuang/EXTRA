//
//  SchoolChoosedController.m
//  ChildrenKeeper
//
//  Created by Deathman on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SchoolPickedController.h"
#import "ConfigManager.h"

@interface SchoolPickedController () {
    NSUInteger requestCount_;
}

@property (nonatomic,retain) NSArray *provinceList;
@property (nonatomic,retain) NSArray *cityList;
@property (nonatomic,retain) NSMutableArray *schoolList;

@property (nonatomic,retain) NSDictionary *locationData;

- (void)fetchProvinceAndCity;
- (void)fetchSchoolByProvince:(NSString *)province city:(NSString *)city;

- (NSDictionary *)selectedProvince;
- (NSDictionary *)selectedCity;
- (NSDictionary *)selectedSchool;

- (NSString *)locationFilePath;

- (void)updateActivityState;

@end

@implementation SchoolPickedController

@synthesize provinceList = provinceList_;
@synthesize cityList = cityList_;
@synthesize schoolList = schoolList_;


@synthesize delegate = delegate_;

@synthesize locationData = locationData_;

- (NSDictionary *)selectedProvince {
    [pickerView_ reloadComponent:0];
    return [provinceList_ objectAtIndex:[pickerView_ selectedRowInComponent:0]];
}
- (NSDictionary *)selectedCity {
    [pickerView_ reloadComponent:1];
    return [cityList_ objectAtIndex:[pickerView_ selectedRowInComponent:1]];
}
- (NSDictionary *)selectedSchool {
    [pickerView_ reloadComponent:2];
    return [schoolList_ objectAtIndex:[pickerView_ selectedRowInComponent:2]];
}

- (NSString *)locationFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Location.plist"];
}

- (void)updateActivityState {
    if (requestCount_ == 0) {
        [activityView_ stopAnimating];
    }
    
}

- (void)fetchProvinceAndCity {
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@/index.php?action=prov_city",baseURL];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];    
    
    [activityView_ startAnimating];
    requestCount_ ++;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (error) {
                                   NSLog(@"网络连接错误");
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];

                                   NSString *status = [jsonObject objectForKey:@"status"];
                                   if ([status isEqualToString:@"ok"]) {
                                       self.locationData =[jsonObject objectForKey:@"content"];
                                       [pickerView_ reloadAllComponents];
                                       [self.locationData writeToFile:[self locationFilePath]
                                                           atomically:YES];
                                   } else {
                                       self.locationData = nil;
                                       [pickerView_ reloadAllComponents];
                                       NSLog(@"获取省份失败");
                                   }
                               }
                               
                               requestCount_ --;
                               [self updateActivityState];
                               
                           }];
    
}

- (void)fetchSchoolByProvince:(NSString *)province city:(NSString *)city
{
    
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@?action=school&prov=%@&city=%@",
                           baseURL,
                           province,
                           city];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"school:%@",urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [activityView_ startAnimating];
    requestCount_ ++;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (error) {
                                   NSLog(@"网络连接错误");
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                                   NSString *status = [jsonObject objectForKey:@"status"];
                                   if ([status isEqualToString:@"ok"]) {
                                       self.schoolList = [NSMutableArray arrayWithArray: [jsonObject objectForKey:@"content"]];
                                       [schoolList_ insertObject:[NSDictionary dictionary] atIndex:0];
                                       [pickerView_ reloadComponent:2];
                                   } else {
                                       NSMutableArray *array = [NSArray arrayWithObject:[NSDictionary dictionary]];
                                       self.schoolList = array;
                                       [pickerView_ reloadComponent:2];
                                       NSLog(@"获取学校失败");
                                   }
                               }
                               
                               requestCount_ --;
                               [self updateActivityState];
                               
                           }];
    
}


#pragma mark - IBAction
- (IBAction)cancel:(id)sender {
    [self.delegate schoolPickedSelectedSchool:nil];
    [self.view removeFromSuperview];
}

- (IBAction)confirm:(id)sender {
    [self.delegate schoolPickedSelectedSchool:[self selectedSchool]];
    [self.view removeFromSuperview];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc {
    [pickerView_ release];
    [provinceList_ release];
    [cityList_ release];
    [schoolList_ release];
    [activityView_ release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger needFetchLocation = [[[ConfigManager sharedConfigManager].configData objectForKey:@"update_prov_city"] intValue];
        
    if (needFetchLocation == 0) {
        self.locationData = [NSDictionary dictionaryWithContentsOfFile:[self locationFilePath]];
    } 
    
    if (needFetchLocation == 1 || self.locationData == nil) {
        [self fetchProvinceAndCity];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Picker datasource & delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        NSInteger count = [[self.locationData allKeys] count];
        return MAX(count, 1);
    }
    if (component == 1) {
        int pIndex = [pickerView selectedRowInComponent:0];
        NSString *p = [[self.locationData allKeys] objectAtIndex:pIndex];
        NSArray *cityArray = [self.locationData objectForKey:p];
        return MAX([cityArray count], 1);
    }
    if (component == 2) {
        return MAX([schoolList_ count], 1);
    }
    return 1;
}

- (float)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

- (float)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerRowLabel = (UILabel *)view;
    if (pickerRowLabel == nil) {
        CGRect frame = CGRectMake(20.0, 0.0, 80, 44);
        pickerRowLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
        pickerRowLabel.backgroundColor = [UIColor clearColor];
        pickerRowLabel.userInteractionEnabled = YES;
        pickerRowLabel.textColor = [UIColor blackColor];
        if (component == 2) {
            pickerRowLabel.font = [UIFont boldSystemFontOfSize:17];
        } else {
            pickerRowLabel.font = [UIFont boldSystemFontOfSize:20];
        }
    }
    
    if (component == 0) {
        NSArray *pArray = [self.locationData allKeys];
        if ([pArray count] == 0) {
            return nil;
        }
        pickerRowLabel.text = [pArray objectAtIndex:row];
    }
    if (component == 1) {
        int pIndex = [pickerView selectedRowInComponent:0];
        NSString *p = [[self.locationData allKeys] objectAtIndex:pIndex];
        NSArray *cityArray = [self.locationData objectForKey:p];
        if ([cityArray count] == 0) {
            return nil;
        }
        pickerRowLabel.text = [cityArray objectAtIndex:row];
    }
    if (component == 2) {
        if ([schoolList_ count] == 0) {
            return nil;
        }
        pickerRowLabel.text = [[schoolList_ objectAtIndex:row] objectForKey:JSONKey_School];
        
    }
        
    return pickerRowLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 2) {
        return;
    }
    
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];

    int pIndex = [pickerView selectedRowInComponent:0];
    NSString *p = [[self.locationData allKeys] objectAtIndex:pIndex];
    
    int cIndex = [pickerView selectedRowInComponent:1];
    NSArray *cityArray = [self.locationData objectForKey:p];
    
    [self fetchSchoolByProvince:p city:[cityArray objectAtIndex:cIndex]];
}



@end
