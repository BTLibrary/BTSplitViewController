//
//  MasterTableViewController.m
//  BTSplitViewExample
//
//  Created by Byte on 6/7/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "MasterTableViewController.h"
#import "DetailViewController.h"
// To know what to call using the notification
#import "BTSplitViewDefinition.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController {
    // Detail View
    DetailViewController *_detailController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // For reusable
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    // This is to demonstrate different use of notification call
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Push detail"];
            break;
        case 1:
            [cell.textLabel setText:@"Pop detail"];
            break;
        case 2:
            [cell.textLabel setText:@"Push if not exist"];
            break;
        case 3:
            [cell.textLabel setText:@"Pop then Push"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get all the necessary baggage for detail
    ActionType actionType;
    BOOL animated = YES;
    
    // For clarity sake
    NSString *typeName;

    switch (indexPath.row) {
        case 0:
            actionType = ActionTypePush;
            typeName = @"ActionTypePush";
            break;
        case 1:
            actionType = ActionTypePop;
            typeName = @"ActionTypePop";
            break;
        case 2:
            actionType = ActionTypePushIfNotExist;
            typeName = @"ActionTypePushIfNotExist";
            break;
        case 3:
            actionType = ActionTypePopThenPush;
            typeName = @"ActionTypePopThenPush";
            break;
    default:
            actionType = ActionTypePush;
            typeName = @"???";
        break;
    }
    
    if (!_detailController) {
        _detailController = [[DetailViewController alloc] init];
    }
    
    [_detailController.label setText:typeName];
    // Random color to show that something happened
    [_detailController.view setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(10)/10.0
                                                               green:arc4random_uniform(10)/10.0
                                                                blue:arc4random_uniform(10)/10.0
                                                               alpha:1]];
    
    // This is very important part
    if (IS_IPAD) {
        // Create an action dictionary for modifying detail
        // See more in BTSplitViewDefinition
        NSDictionary *actionDict = [BTSplitViewDefinition actionDictWithActionType:actionType animated:animated viewController:_detailController];
        
        // Go ahead and modify the detail according to the dictionary above
        [BTSplitViewDefinition modifyDetailWithActionDict:actionDict];
        
    } else {
        // Push onto the stack as usual
        [self.navigationController pushViewController:_detailController animated:animated];
    }
}
@end































// Space created so I can see what I am typing in the center of the screen, no other function
