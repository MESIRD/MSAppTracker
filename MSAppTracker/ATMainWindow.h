//
//  ATMainWindow.h
//  MSAppTracker
//
//  Created by xujie on 11/11/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATMainWindow : NSWindow <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@end
