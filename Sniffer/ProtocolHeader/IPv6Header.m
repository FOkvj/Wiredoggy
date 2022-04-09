//
//  IPv6Header.m
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//

#import "IPv6Header.h"

@implementation IPv6Header
- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingFormat:@"Internet Protocol Version 6, Src: %@, Dst: %@", _srcAddr, _dstAddr];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* lenItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Payload length: %d", _payloadLen]];
    [item1 addChildren:lenItem];
    OutLineViewItem* nextItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Next header: %@", _nextHeader]];
    [item1 addChildren:nextItem];
    OutLineViewItem* hopItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Hop limit: %d", _hopLimit]];
    [item1 addChildren:hopItem];
    return item1;
}

@end
