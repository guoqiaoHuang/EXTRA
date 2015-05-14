//
//  LocationTableViewController.m
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LocationTableViewController.h"
#import "SchoolTableViewController.h"
#import "ConfigManager.h"

#import "CustomTableViewCell.h"

@interface LocationTableViewController () {
    enum LocationType locationType_;
}

- (void)setupNavigationBarStyle;
- (NSString *)locationFilePath;

@end

@implementation LocationTableViewController

#define kActivityViewTag 0x1232

@synthesize locationArray = locationArray_;
@synthesize loginViewController = loginViewController_;
@synthesize allLocationData = allLocationData_;

- (void)dealloc {
    [locationArray_ release];
    [allLocationData_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithLocationType:(enum LocationType)type {
    self = [self initWithStyle:UITableViewStyleGrouped];
    if (self) {
        locationType_ = type;
    }
    return self;
}

- (void)setupNavigationBarStyle {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] 
                                                  forBarMetrics:UIBarMetricsDefault];
    UIImage* image= [UIImage imageNamed:@"NavBack.png"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    [backButton release];
}

- (NSString *)locationFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Location.plist"];
}

- (void)fetchProvinceAndCity {
    NSString *baseURL = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *urlString = [NSString stringWithFormat:@"%@/index.php?action=prov_city",baseURL];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];    
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.tag = kActivityViewTag;
    [activityView startAnimating];
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    [activityView release];
    
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
                                       self.allLocationData =[jsonObject objectForKey:@"content"];
                                       [allLocationData_ writeToFile:[self locationFilePath]
                                                           atomically:YES];
                                       self.locationArray = [allLocationData_ allKeys];
                                   } else {
                                       self.locationArray = nil;
                                       NSLog(@"获取省份失败");
                                   }
                               }
                               
                               [self.tableView reloadData];
                               
                               UIView *activityView = [self.view viewWithTag:kActivityViewTag];
                               [activityView removeFromSuperview];
                               
                           }];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景.png"]];
    self.tableView.backgroundView = bgImageView;
    [bgImageView release];

    [self setupNavigationBarStyle];
    
    switch (locationType_) {
        case LocationTypeProvince:
            self.title = @"选择省";
            [self fetchProvinceAndCity];
            break;
        case LocationTypeCity:
            self.title = @"选择市";
            break;
        case LocationTypeDistrict:
            self.title = @"选择区";
            break;
            
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CustomCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [locationArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.contentLabel.text = [locationArray_ objectAtIndex:indexPath.row];    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    UIViewController *controller;
    if (locationType_ == LocationTypeProvince) {
        controller = [[LocationTableViewController alloc] initWithLocationType:LocationTypeCity];
        NSString *p = [[self.allLocationData allKeys] objectAtIndex:row];
        NSArray *cityArray = [self.allLocationData objectForKey:p];
        [(LocationTableViewController *)controller setAllLocationData:allLocationData_];
        [(LocationTableViewController *)controller setLocationArray:cityArray];
    }
    if (locationType_ == LocationTypeCity) {
        controller = [[SchoolTableViewController alloc] init];
        
    }
    if (locationType_ == LocationTypeDistrict) {
        controller = [[SchoolTableViewController alloc] init];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
