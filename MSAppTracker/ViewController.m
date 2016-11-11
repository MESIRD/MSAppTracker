//
//  ViewController.m
//  MSAppTracker
//
//  Created by mesird on 11/11/2016.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (strong) NSArray *runningApps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    _runningApps = [NSArray array];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [self _fetchRunningApps];
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


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
