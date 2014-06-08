//
//  BTSplitViewDefinition.m
//  Reunite
//
//  Created by Byte on 5/27/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "BTSplitViewDefinition.h"

@implementation BTSplitViewDefinition
+ (NSDictionary *)actionDictWithActionType:(ActionType)actionType animated:(BOOL)animated viewController:(UIViewController *)viewController
{
    return @{SPLIT_KEY_ACTION_TYPE: @(actionType), SPLIT_KEY_ANIMATE: animated?@YES:@NO, SPLIT_KEY_VIEW_CONTROLLER:viewController};
}

+ (void)modifyMasterWithActionDict:(NSDictionary *)actionDict
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SPLIT_VIEW_ACTION_MASTER object:actionDict];
}

+ (void)modifyDetailWithActionDict:(NSDictionary *)actionDict
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SPLIT_VIEW_ACTION_DETAIL object:actionDict];
}

@end
