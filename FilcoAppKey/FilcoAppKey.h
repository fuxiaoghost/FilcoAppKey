//
//  FilcoAppKey.h
//  FilcoAppKey
//
//  Created by Kirn on 7/29/15.
//  Copyright (c) 2015 北京易客信息技术有限公司. All rights reserved.
//

#import <AppKit/AppKit.h>

@class FilcoAppKey;

static FilcoAppKey *sharedPlugin;

@interface FilcoAppKey : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end