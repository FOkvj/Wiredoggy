//
//  EthernetPackege.m
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import "EthernetHeader.h"

@implementation EthernetHeader


- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingFormat:@"Ethernet, Src: %@, Dst: %@", _sourceMac, _destMac];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* sItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Source: %@", _sourceMac]];
    [item1 addChildren:sItem];
    OutLineViewItem* dItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Destination: %@", _destMac]];
    [item1 addChildren:dItem];
    OutLineViewItem* tItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Type: %@", _type]];
    [item1 addChildren:tItem];
    return  item1;
}

@end
