//
//  ATMainWindow.m
//  MSAppTracker
//
//  Created by xujie on 11/11/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ATMainWindow.h"

@interface ATMainWindow ()

@property (strong) NSArray *runningApps;

@end

@implementation ATMainWindow

+ (void)initialize {
    
    NSLog(@"init");
}

+ (void)load {
    
    NSLog(@"load");
}

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"awake");
    
    _runningApps = [NSArray array];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self _fetchRunningApps];
}

- (NSWindow *)initWithWindowRef:(void *)windowRef {
    
    if (self = [super initWithWindowRef:windowRef]) {
        NSLog(@"ref");
    }
    return self;
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    
    if (self = [super initWithContentRect:contentRect styleMask:style backing:bufferingType defer:flag]) {
        
        NSLog(@"content");
    }
    return self;
}

- (void)_fetchRunningApps {
    
    _runningApps = [[NSWorkspace sharedWorkspace] runningApplications];
    [_tableView reloadData];
}

#pragma mark - table view delegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _runningApps.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40.0f;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSRunningApplication *app = _runningApps[row];
    NSInteger column = [_tableView columnWithIdentifier:tableColumn.identifier];
    NSTableCellView *view = [tableView viewAtColumn:column row:row makeIfNecessary:NO];
    if (column == 0) {
        if (!view) {
            view = [tableView makeViewWithIdentifier:@"IconCellView" owner:self];
        }
        NSImageView *imageView = view.subviews.firstObject;
        imageView.image = app.icon;
    } else if (column == 1) {
        if (!view) {
            view = [tableView makeViewWithIdentifier:@"AppNameCellView" owner:self];
        }
        NSTextField *textLabel = view.subviews.firstObject;
        textLabel.stringValue = app.localizedName;
    } else if (column == 2) {
        if (!view) {
            view = [tableView makeViewWithIdentifier:@"TimeUsageCellView" owner:self];
        }
        NSTextField *textLabel = view.subviews.firstObject;
        textLabel.stringValue = @"00:00";
    }
    
    return view;
}

@end
