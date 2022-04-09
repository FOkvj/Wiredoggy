//
//  ARPHeader.m
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//

#import "ARPHeader.h"

@implementation ARPHeader


- (nonnull NSString *)getInfo {
    NSString* info = @"";
    //1是request
    if (_optionCode == 1){
        info = [info stringByAppendingFormat:@"Who has %@? Tell%@", _targetIpAdrr, _sendIpAddr];
    }
    //2 是reply
    else if (_optionCode == 2){
        info = [info stringByAppendingFormat:@"%@ is at %@", _sendIpAddr, _sendHardWareAddr];
    }
    return info;
}

- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 = [name1 stringByAppendingFormat:@"Address Resolution Protocol"];
    if (_optionCode == 1) name1 = [name1 stringByAppendingString:@"(request)"];
    else if (_optionCode == 2) name1 = [name1 stringByAppendingString:@"(reply)"];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* ptItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Protocol type: %@", _protocolType]];
    [item1 addChildren:ptItem];
    OutLineViewItem* hsItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Hardware size: %d", _hardWareSize]];
    [item1 addChildren:hsItem];
    OutLineViewItem* psItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Protocol size: %d", _protocolSize]];
    [item1 addChildren:psItem];
    OutLineViewItem* opItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Opcode: %d", _optionCode]];
    [item1 addChildren:opItem];
    OutLineViewItem* smItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Send mac address: %@", _sendHardWareAddr]];
    [item1 addChildren:smItem];
    OutLineViewItem* sipItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Send ip address: %@", _sendIpAddr]];
    [item1 addChildren:sipItem];
    OutLineViewItem* tmItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Target mac address: %@", _targetHardWareAddr]];
    [item1 addChildren:tmItem];
    OutLineViewItem* tipItem = [[OutLineViewItem new] initWithName: [NSString stringWithFormat:@"Target ip address: %@", _targetIpAdrr]];
    [item1 addChildren:tipItem];
    return  item1;
}

@end
