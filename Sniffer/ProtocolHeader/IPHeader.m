//
//  Packege.m
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import "IPHeader.h"

@implementation IPHeader

- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingFormat:@"Internet Protocol Version %d, Src: %@, Dst: %@", _version, _sourceIP, _destIP];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* lenItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Total length: %d", _totalLen]];
    [item1 addChildren:lenItem];
    OutLineViewItem* flagsItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"falgs: 0x%x",_flags]];
    [item1 addChildren:flagsItem];
    OutLineViewItem* identyItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Identity: 0x%x", _identy]];
    [item1 addChildren:identyItem];
    OutLineViewItem* offItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Fragment offset: %d", _offset]];
    [item1 addChildren:offItem];
    OutLineViewItem* ttlItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Time to live: %d", _timeToLive]];
    [item1 addChildren:ttlItem];
    OutLineViewItem* proItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Protocol: %@", _protocol]];
    [item1 addChildren:proItem];
    OutLineViewItem* sum = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Header check sum: 0x%x", _headerCheckSum]];
    [item1 addChildren:sum];
    OutLineViewItem* srcItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Source IP: %@", _sourceIP]];
    [item1 addChildren:srcItem];
    OutLineViewItem* dstItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Destination IP: %@", _destIP]];
    [item1 addChildren:dstItem];
    return item1;
}

@end
