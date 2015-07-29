//
//  NSObject_Extension.m
//  FilcoAppKey
//
//  Created by Kirn on 7/29/15.
//  Copyright (c) 2015 北京易客信息技术有限公司. All rights reserved.
//


#import "NSObject_Extension.h"
#import "FilcoAppKey.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[FilcoAppKey alloc] initWithBundle:plugin];
        });
    }
}
@end
