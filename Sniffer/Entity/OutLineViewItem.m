//
//  OutLineViewItem.m
//  Sniffer
//
//  Created by DZC on 2022/4/6.
//

#import "OutLineViewItem.h"

@implementation OutLineViewItem

- (id)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = name;
        _children = [NSMutableArray new];
    }
    return self;
}

- (void)addChildren:(OutLineViewItem *)item {
    [_children addObject:item];
}
@end
