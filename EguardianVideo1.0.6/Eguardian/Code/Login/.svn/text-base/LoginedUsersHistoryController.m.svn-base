//
//  LoginedUsersHistoryController.m
//  CampusManager
//
//  Created by Deathman on 13-4-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginedUsersHistoryController.h"
#import "LoginViewController.h"
#import "LoginedUsersTableViewCell.h"
#import "LoginBaseViewController.h"

#define TableHeight 52.0

@interface LoginedUsersHistoryController ()

@end

@implementation LoginedUsersHistoryController

@synthesize loginViewController = loginViewController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [arrowImageView_ release];
    [tableView_ release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    CGRect tableFrame = tableView_.frame;
    tableFrame.size.height = MAX(TableHeight, TableHeight*[loginViewController_.loginedUsers count]);
    tableView_.frame = tableFrame;
    
    self.view.frame = CGRectMake(24, 270, 266, tableFrame.origin.y + tableFrame.size.height);
        
    tableView_.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tableView_ reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX([loginViewController_.loginedUsers count], 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LoginedUsersCell";
    LoginedUsersTableViewCell *cell = (LoginedUsersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {

        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LoginedUsersTableViewCell" owner:self options:nil];
        if ([array count] > 0) {
            cell = [array objectAtIndex:0];
        }
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logined_cell_unselected"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logined_cell_selected"]] autorelease];
    }

    NSArray *loginedUsers = self.loginViewController.loginedUsers;
    if ([loginedUsers count] > 0) {
        
        NSDictionary *dict = [loginedUsers objectAtIndex:indexPath.row];
        NSString *number = [dict objectForKey:User_UserNumber];
        NSString *school = [dict objectForKey:User_SchoolName];
        cell.userNumerLabel.text = number;
        cell.userIconImageView.hidden = NO;
        if ([number isEqualToString:loginViewController_.userNameTextfield.text]
            && [school isEqualToString:loginViewController_.schoolTextfield.text]) {
            
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            
            if (indexPath.row == 0) {
                arrowImageView_.image = [UIImage imageNamed:@"arrow_selected"];
            } else {
                arrowImageView_.image = [UIImage imageNamed:@"arrow_unselected"];
            }
        }
    } else {
        cell.userNumerLabel.text = @"";
        cell.userIconImageView.hidden = YES;
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        arrowImageView_.image = [UIImage imageNamed:@"arrow_selected"];
    }
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *loginedUsers = self.loginViewController.loginedUsers;
    if ([loginedUsers count] > 0) {
        [self.loginViewController selectedUser:[loginedUsers objectAtIndex:indexPath.row]];
        if (indexPath.row == 0) {
            arrowImageView_.image = [UIImage imageNamed:@"arrow_selected"];
        } else {
            arrowImageView_.image = [UIImage imageNamed:@"arrow_unselected"];
        }
    } 
    [self.view removeFromSuperview];
}

@end
