//
//  BTSplitViewDefinition.h
//  Reunite
//
//  Created by Byte on 5/27/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import <Foundation/Foundation.h>

// To return to the earlier page before split view
#define SPLIT_VIEW_BACK_NOTIFICATION @"SPLIT_VIEW_BACK_NOTIFICATION"

// Action that calls to perform manipulation to master or detail
#define SPLIT_VIEW_ACTION_MASTER @"SPLIT_VIEW_ACTION_MASTER"
#define SPLIT_VIEW_ACTION_DETAIL @"SPLIT_VIEW_ACTION_DETAIL"

// Keys to create Action Dictionary to pass along the notification
#define SPLIT_KEY_ACTION_TYPE @"SPLIT_KEY_ACTION_TYPE"
#define SPLIT_KEY_ANIMATE @"SPLIT_KEY_ANIMATE"
#define SPLIT_KEY_VIEW_CONTROLLER @"SPLIT_KEY_VIEW_CONTROLLER"

#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

typedef enum {
    ActionTypePush, // Push onto the navigation stack
    ActionTypePop, // Pop form the navigation stack
    ActionTypePushIfNotExist, // Push onlo the stack only when it is not there already
    ActionTypePopThenPush // Pop to root, then push onto the stack
}ActionType;

@interface BTSplitViewDefinition : NSObject

// Create dictionary that tells split view what to do
+ (NSDictionary *)actionDictWithActionType:(ActionType)actionType animated:(BOOL)animated viewController:(UIViewController *)viewController;

// When ready, modify one of the navigation view with the above dict
+ (void)modifyMasterWithActionDict:(NSDictionary *)actionDict;
+ (void)modifyDetailWithActionDict:(NSDictionary *)actionDict;
@end
