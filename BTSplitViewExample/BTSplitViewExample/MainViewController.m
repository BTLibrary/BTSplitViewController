//
//  MainViewController.m
//  BTSplitViewExample
//
//  Created by Byte on 6/7/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "MainViewController.h"
#import "MasterTableViewController.h"
#import "BTSplitViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    MasterTableViewController *_masterController;
    BTSplitViewController *_splitViewController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display a button to go to master view controller
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self action:@selector(goToMaster) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Go to Master View" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    // Whole screen
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button)]];
}

- (void)goToMaster
{
    // Initialize master controller
    if (!_masterController) {
        _masterController = [[MasterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    
    // Check if it is iPad or iPhone
    if (IS_IPAD) {
        // Initialize split controller
        if (!_splitViewController) {
            // create another navigation stack for master
            UINavigationController *masterNavController = [[UINavigationController alloc] initWithRootViewController:_masterController];
            
            // create a blank detail navigation stack
            UINavigationController *detailNavController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
            
            // create the splitView
            _splitViewController = [[BTSplitViewController alloc] initWithMaster:masterNavController detail:detailNavController];
        }
        
        // Push split controller onto the current stack
        [self.navigationController pushViewController:_splitViewController animated:YES];
    } else {
        // Push master controller onto the current stack (as usual)
        [self.navigationController pushViewController:_masterController animated:YES];
    }
}

@end
