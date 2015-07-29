//
//  FilcoAppKey.m
//  FilcoAppKey
//
//  Created by Kirn on 7/29/15.
//  Copyright (c) 2015 北京易客信息技术有限公司. All rights reserved.
//

#import "FilcoAppKey.h"

@interface FilcoAppKey()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, assign) BOOL appKeyOpen;
@property (nonatomic, strong) id eventMonitor;
@end

@implementation FilcoAppKey

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        self.appKeyOpen = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
    }
    return self;
}
- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti{
    //removeObservadf
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Filco(App Key Disabled)" action:@selector(doMenuAction:) keyEquivalent:@""];
        //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
    
    
    // 遇到 filco 的 app键 跳出
    self.eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent *(NSEvent *incomingEvent) {
        if ([incomingEvent type] == NSKeyDown && [incomingEvent keyCode] == 110 && self.appKeyOpen == YES) {
            return nil;
        }
        return incomingEvent;
    }];
}


// Sample Action, for menu item:
- (void)doMenuAction:(id)sender
{
    self.appKeyOpen = !self.appKeyOpen;
    NSMenuItem *item = (NSMenuItem *)sender;
    if (self.appKeyOpen) {
        item.title = @"Filco(App Key Disabled)";
    }else{
        item.title = @"Filco(App Key Enabled)";
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end