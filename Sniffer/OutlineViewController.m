//
//  OutlineViewController.m
//  Sniffer
//
//  Created by DZC on 2022/3/29.
//

#import "OutlineViewController.h"

@implementation OutlineViewController
- (id)init {
    self = [super self];
    if (self) {
        
        allPackets = [SharedData getSharedDataInstance].outlineViewList;
//        if (
//        _list = allPackets[[SharedData getSharedDataInstance].selectedRow];
    }
    return self;
}

#pragma mark OutlineView Data Source Methods

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    NSInteger selectedRow = [SharedData getSharedDataInstance].selectedRow;
    NSMutableArray* list;
    if ([allPackets count] > 0) list = allPackets[selectedRow];
    return !item ? [list count] : [[item children] count];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return !item ? YES : [[item children] count] != 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    NSInteger selectedRow = [SharedData getSharedDataInstance].selectedRow;
    NSMutableArray* list;
    if ([allPackets count] > 0) list = allPackets[selectedRow];
    return !item ? [list objectAtIndex:index] : [[item children] objectAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    if ([[tableColumn identifier] isEqualToString:@"name"]) {
        return [item name];
    }
    return @"Nothing here";
}
@end
