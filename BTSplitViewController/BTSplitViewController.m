//
//  BTSplitViewController.m
//
//  Created by Byte on 5/23/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "BTSplitViewController.h"

@interface BTSplitViewController ()

@end

@implementation BTSplitViewController
{
    BOOL _needsPush;
    BOOL _animated;
    UIViewController *_viewController;
}

- (id)initWithMaster:(id)masterController detail:(id)detailController
{
    if (self = [super init]) {
        _masterController = masterController;
        _detailController = detailController;
        
        _needsPush = NO;
        _viewController = nil;
        _animated = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *masterView = _masterController.view;
    [masterView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:masterView];
    
    UIView *lineSplitView = [[UIView alloc] init];
    [lineSplitView setBackgroundColor:[UIColor blackColor]];
    [lineSplitView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:lineSplitView];
    
    UIView *detailView = _detailController.view;
    [detailView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:detailView];
    
    NSDictionary *metrics = @{@"masterWidth": @(320), @"splitLineWidth": @(1)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[masterView(masterWidth)][lineSplitView(splitLineWidth)][detailView]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(masterView, lineSplitView, detailView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[masterView]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(masterView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lineSplitView]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(lineSplitView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailView]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(detailView)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:SPLIT_VIEW_BACK_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(masterAction:) name:SPLIT_VIEW_ACTION_MASTER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailAction:) name:SPLIT_VIEW_ACTION_DETAIL object:nil];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // Add back button to the viewController
    if ([_masterController isKindOfClass:[UINavigationController class]]) {
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action: @selector(back)];
        [_masterController.topViewController.navigationItem setLeftBarButtonItem:backBarButtonItem];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPLIT_VIEW_BACK_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPLIT_VIEW_ACTION_MASTER object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPLIT_VIEW_ACTION_DETAIL object:nil];
    
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)masterAction:(NSNotification *)notification
{
    if ([_masterController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)_masterController;
        [navController setDelegate:self];
        [self actionWithNav:navController notification:notification];
    } else {
        return;
    }
}

- (void)detailAction:(NSNotification *)notification
{
    if ([_detailController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)_detailController;
        [navController setDelegate:self];
        [self actionWithNav:navController notification:notification];
    } else {
        return;
    }
}

- (void)actionWithNav:(UINavigationController *)navController notification:(NSNotification *)notification
{ 
    NSDictionary *dictionary = notification.object;
    ActionType actionType = [dictionary[SPLIT_KEY_ACTION_TYPE] intValue];
    _animated = [dictionary[SPLIT_KEY_ANIMATE] boolValue];
    _viewController = dictionary[SPLIT_KEY_VIEW_CONTROLLER];
    
    
    switch (actionType) {
        case ActionTypePop:
            [navController popViewControllerAnimated:_animated];
            break;
        case ActionTypePush:
            [navController pushViewController:_viewController animated:_animated];
            break;
        case ActionTypePopThenPush:
            if ([navController.topViewController isEqual:navController.viewControllers[0]]) {
                // if it is the root view, just push
                [navController pushViewController:_viewController animated:_animated];
            } else {
                _needsPush = YES;
                [navController popViewControllerAnimated:_animated];
            }
            break;
        case ActionTypePushIfNotExist:
            if ([navController.topViewController isEqual:_viewController]) {
                // Do nothing since it already exists
            } else if ([navController.topViewController isEqual:navController.viewControllers[0]]) {
                // It is at root and it is not the right view, push
                [navController pushViewController:_viewController animated:_animated];
            } else {
                // It is not the right view and not at root. Pop then push
                _needsPush = YES;
                [navController popToRootViewControllerAnimated:_animated];
            }
            break;
        default:
            break;
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate
#pragma UINavigationController
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (_needsPush) {
        _needsPush = NO;
        [navigationController pushViewController:_viewController animated:_animated];
    }
}

@end
