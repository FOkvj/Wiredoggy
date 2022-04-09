//
//  UDPHeader.m
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import "UDPHeader.h"

@implementation UDPHeader
- (NSString *)getInfo {
    NSString* info = [NSString stringWithFormat:@"%d->%d Len=%d",_sourcePort,_destPort,_length];
    return info;
}

- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingFormat:@"User Datagram Protocol, Src Port: %d, Dst Port: %d", _sourcePort, _destPort];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* spItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Source port: %d", _sourcePort]];
    [item1 addChildren:spItem];
    OutLineViewItem* dpItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Destination port: %d",_destPort]];
    [item1 addChildren:dpItem];
    OutLineViewItem* lenItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Length : %d", _length]];
    [item1 addChildren:lenItem];
    OutLineViewItem* sum = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Header check sum: 0x%x", _checkSum]];
    [item1 addChildren:sum];
    return  item1;
}

@end
